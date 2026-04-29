import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/core/general/data/models/expenses_type_model.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/widgets/app_snack_bar.dart';
// import '../../../../../core/components/widgets/currency_selection_bottom_sheet.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../core/components/widgets/expenses_type_selection_bottom_sheet.dart';
import '../../../../../core/components/widgets/main_button.dart';
import '../../../../../core/database/cache/cache_helper.dart';
import '../../../../../core/database/cache/cache_services.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/general/cubit/general_cubit.dart';
import '../../../../../core/general/cubit/general_state.dart';
import '../../../../../core/utils/global_ui_utils.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../../generated/app_assets.dart';
import '../../../../home/data/models/currency_model.dart';
import '../../../../home/presentation/cubit/home_cubit.dart';
import '../../../../home/presentation/cubit/home_state.dart';
import '../../../../transfer_money/data/models/transfer_money_request_params.dart';
import '../../../../transfer_money/presentation/views/widgets/all_denominations_bottom_sheet.dart';
import '../../../data/models/expenses_request_params.dart';
import '../../cubit/expenses_cubit.dart';
import '../../cubit/expenses_state.dart';

class ExpensesForm extends StatefulWidget {
  const ExpensesForm({super.key});

  @override
  State<ExpensesForm> createState() => _ExpensesFormState();
}

class _ExpensesFormState extends State<ExpensesForm> {
  late TextEditingController amountController;
  late TextEditingController currencyController;
  late TextEditingController purposeController;
  late TextEditingController notesController;
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  int? selectedCurrencyId;
  int? selectedExpensesTypeId;

  @override
  void initState() {
    super.initState();
    final user =  getIt<CacheServices>().getDataFromCache(
      boxName: CacheBoxes.userModelBox,
      key: 'user',
    );
     selectedCurrencyId = context
        .read<HomeCubit>()
        .state
        .currenciesList
        .firstWhere(
          (currency) => currency.name == user?.currency,
          orElse: () => CurrencyModel(id: 0, name: ''),
        )
        .id;
    amountController = TextEditingController();
    currencyController = TextEditingController(
      text: context
          .read<HomeCubit>()
          .state
          .currenciesList
          .firstWhere(
            (currency) => currency.name == user?.currency,
            orElse: () => CurrencyModel(id: 0, name: ''),
          )
          .name,
    );
    selectedCurrencyId = context
        .read<HomeCubit>()
        .state
        .currenciesList
        .firstWhere(
          (currency) => currency.name == user?.currency,
          orElse: () => CurrencyModel(id: 0, name: ''),
        )
        .id;
    purposeController = TextEditingController();
    notesController = TextEditingController();
  }

  @override
  void dispose() {
    amountController.dispose();
    currencyController.dispose();
    purposeController.dispose();
    notesController.dispose();
    super.dispose();
  }

  // void _onCurrencySelected(CurrencyModel currency) {
  //   setState(() {
  //     currencyController.text = currency.name ?? '';
  //     selectedCurrencyId = currency.id;
  //   });
  // }

  // void _showCurrencyBottomSheet(List<CurrencyModel> currencies) {
  //   GlobalUiUtils.showBottomSheet(
  //     context,
  //     child: CurrencySelectionBottomSheet(
  //       currencies: currencies,
  //       selectedCurrencyId: selectedCurrencyId,
  //       onCurrencySelected: (currency) {
  //         _onCurrencySelected(currency);
  //         Navigator.pop(context);
  //       },
  //     ),
  //   );
  // }

  void _onExpensesTypeSelected(ExpensesTypeModel type) {
    setState(() {
      purposeController.text = type.name;
      selectedExpensesTypeId = type.id;
    });
  }

  void _showExpensesTypeBottomSheet(List<ExpensesTypeModel?> expensesTypes) {
    GlobalUiUtils.showBottomSheet(
      context,
      child: ExpensesTypeSelectionBottomSheet(
        expensesTypes: expensesTypes,
        selectedExpensesTypeId: selectedExpensesTypeId,
        onExpensesTypeSelected: (type) {
          _onExpensesTypeSelected(type);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _onDenominationsConfirmed(
    List<DenominationsRequestParams> denominations,
  ) {
    final cubit = context.read<ExpensesCubit>();
    cubit.addExpense(
      expensesRequestParams: ExpensesRequestParams(
        currencyId: selectedCurrencyId ?? 0,
        amount: amountController.text,
        notes: notesController.text,
        denominations: denominations,
        expensesTypeId: selectedExpensesTypeId ?? 0,
      ),
    );
  }

  void _handleSendButton() {
    if (formKey.currentState?.validate() ?? false) {
      final amount = double.tryParse(amountController.text);

      if (amount == null || amount <= 0) {
        AppSnackBar.showSnackBar(
          context: context,
          message: "pleaseEnterValidAmount",
          state: SnackBarStates.error,
        );
        return;
      }
      GlobalUiUtils.showBottomSheet(
        context,
        child: BlocProvider.value(
          value: getIt<GeneralCubit>(),
          child: AllDenominationsBottomSheet(
            amount: amount,
            onConfirm: _onDenominationsConfirmed,
          ),
        ),
      );
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExpensesCubit, ExpensesState>(
      listener: (context, state) {
        if (state.expensesStatus.isError) {
          AppSnackBar.showSnackBar(
            context: context,
            message: state.message!,
            state: SnackBarStates.error,
          );
        } else if (state.expensesStatus.isSuccess) {
          AppSnackBar.showSnackBar(
            context: context,
            message: state.message!,
            state: SnackBarStates.success,
          );
          // context.pop();
          context.pop();

         context.read<ExpensesCubit>().refreshExpenses();
          context.read<HomeCubit>().getBranchCurrencies();
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              _buildPurposeField(),
              20.verticalSizedBox,
              _buildCurrencyField(context),
              20.verticalSizedBox,
              _buildAmountField(),
              20.verticalSizedBox,
              _buildNotesField(),
              40.verticalSizedBox,
              _buildSubmitButton(state.expensesStatus),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNotesField() {
    return CustomTextFieldWithLabel(
      controller: notesController,
      label: "ملاحظة",
      hintText: context.notesHint,
      isRequired: false,
      keyboardType: TextInputType.text,
    );
  }

  Widget _buildPurposeField() {
    return BlocBuilder<GeneralCubit, GeneralState>(
      builder: (context, state) {
        final expensesTypes = state.expensesTypes ?? [];
        return CustomTextFieldWithLabel(
          controller: purposeController,
          label: "نوع المصروف ",
          hintText: context.purposeHint,
          isRequired: true,
          isReadOnly: true,
          keyboardType: TextInputType.text,
          validator: (value) => Validator.validateAnotherField(value, context),
          onTap: () => _showExpensesTypeBottomSheet(expensesTypes),
          suffixWidget: InkWell(
            splashColor: Colors.transparent,
            onTap: () => _showExpensesTypeBottomSheet(expensesTypes),
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: context.colors.grayColor,
            ),
          ),
        );
      },
    );
  }

  Widget _buildAmountField() {
    return CustomTextFieldWithLabel(
      controller: amountController,
      label: context.amount,
      hintText: context.enterAmountExpenses,
      isRequired: true,
      keyboardType: TextInputType.number,
      validator: (value) => Validator.validateAnotherField(value, context),
    );
  }

  Widget _buildSubmitButton(RequestStatus status) {
    return MainButton(
      title: context.send,
      onTap: status.isLoading ? () {} : _handleSendButton,
    );
  }

  Widget _buildCurrencyField(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return CustomTextFieldWithLabel(
          // onTap: () => _showCurrencyBottomSheet(state.currenciesList),
          controller: currencyController,
          label: context.currency,
          hintText: context.currenyHint,
          prefixWidget: AppAssets.svgsCoinsIcon,
          isRequired: true,
          isReadOnly: true,
          enabled: false,
          validator: (value) => Validator.validateAnotherField(value, context),
          // suffixWidget: InkWell(
          //   splashColor: Colors.transparent,
          //   onTap: () => _showCurrencyBottomSheet(state.currenciesList),
          //   child: Icon(
          //     Icons.keyboard_arrow_down_rounded,
          //     color: context.colors.grayColor,
          //   ),
          // ),
        );
      },
    );
  }
}
