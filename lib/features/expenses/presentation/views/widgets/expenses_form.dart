import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/widgets/app_snack_bar.dart';
import '../../../../../core/components/widgets/custom_drop_down_card.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../core/components/widgets/main_button.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/general/cubit/general_cubit.dart';
import '../../../../../core/utils/global_ui_utils.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../../generated/app_assets.dart';
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
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isDropDownOpen = false;
  int? selectedCurrencyId;

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
    currencyController = TextEditingController();
    purposeController = TextEditingController();
  }

  @override
  void dispose() {
    amountController.dispose();
    currencyController.dispose();
    purposeController.dispose();
    super.dispose();
  }

  void _onCurrencySelected(String selectedItem) {
    final homeCubit = context.read<HomeCubit>();
    final selectedCurrency = homeCubit.state.currenciesList.firstWhere(
      (currency) => currency.name == selectedItem,
    );

    setState(() {
      isDropDownOpen = false;
      currencyController.text = selectedItem;
      selectedCurrencyId = selectedCurrency.id;
    });
  }

  void _onDenominationsConfirmed(List<DenominationsRequestParams> denominations) {
    final cubit = context.read<ExpensesCubit>();
    cubit.addExpense(
      expensesRequestParams: ExpensesRequestParams(
        currencyId: selectedCurrencyId ?? 0,
        amount: amountController.text,
        notes: purposeController.text,
        denominations: denominations,
      ),
    );
  }

  void _handleSendButton() {
    if (formKey.currentState?.validate() ?? false) {
      final amount = double.tryParse(amountController.text);
      
      if (amount == null || amount <= 0) {
        AppSnackBar.showSnackBar(
          context: context,
          message:"pleaseEnterValidAmount",
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
          context.pop();
          context.pop();
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
              40.verticalSizedBox,
              _buildSubmitButton(state.expensesStatus),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPurposeField() {
    return CustomTextFieldWithLabel(
      controller: purposeController,
      label: context.purpose,
      hintText: context.purposeHint,
      isRequired: true,
      keyboardType: TextInputType.text,
      validator: (value) => Validator.validateAnotherField(value, context),
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
      onTap: status.isLoading ? (){} : _handleSendButton,
    
    );
  }

  Widget _buildCurrencyField(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            CustomTextFieldWithLabel(
              onTap: _toggleDropdown,
              controller: currencyController,
              label: context.currency,
              hintText: context.currenyHint,
              prefixWidget: AppAssets.svgsCoinsIcon,
              isRequired: true,
              isReadOnly: true,
              validator: (value) =>
                  Validator.validateAnotherField(value, context),
              suffixWidget: _buildDropdownIcon(),
            ),
            if (isDropDownOpen)
              CustomDropDownCard(
                dropDownItems: state.currenciesList
                    .map((e) => e.name)
                    .whereType<String>()
                    .toList(),
                selectedValue: currencyController.text,
                onItemSelected: _onCurrencySelected,
              ).onlyPadding(topPadding: 6),
          ],
        );
      },
    );
  }

  Widget _buildDropdownIcon() {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: _toggleDropdown,
      child: Icon(
        isDropDownOpen
            ? Icons.keyboard_arrow_up_rounded
            : Icons.keyboard_arrow_down_rounded,
        color: isDropDownOpen
            ? context.colors.primaryColor
            : context.colors.grayColor,
      ),
    );
  }

  void _toggleDropdown() {
    setState(() {
      isDropDownOpen = !isDropDownOpen;
    });
  }
}