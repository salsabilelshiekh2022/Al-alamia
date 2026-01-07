import 'package:alalamia/core/database/cache/cache_helper.dart';
import 'package:alalamia/core/di/dependency_injection.dart';
import 'package:alalamia/core/general/cubit/general_cubit.dart';
import 'package:alalamia/core/general/cubit/general_state.dart';
import 'package:alalamia/features/auth/data/models/user_model.dart';
import 'package:alalamia/features/in_and_out_transaction/presentation/cubit/in_and_out_transaction_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/widgets/app_snack_bar.dart';
import '../../../../../core/components/widgets/currency_selection_bottom_sheet.dart';
import '../../../../../core/general/data/models/branch_model.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../core/components/widgets/main_button.dart';
import '../../../../../core/database/cache/cache_services.dart';
import '../../../../../core/enums/request_status.dart';
import '../../../../../core/helper/app_extention.dart';
import '../../../../../core/helper/number_extentions.dart';
import '../../../../../core/helper/translation_extensions.dart';
import '../../../../../core/utils/global_ui_utils.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../../generated/app_assets.dart';
import '../../../../home/data/models/currency_model.dart';
import '../../../../home/presentation/cubit/home_cubit.dart';
import '../../../../transfer_money/data/models/transfer_money_request_params.dart';
import '../../../../transfer_money/presentation/views/widgets/all_denominations_bottom_sheet.dart';
import '../../../data/models/in_and_out_request_params.dart';
import 'branch_selection_bottom_sheet.dart';
import '../../cubit/in_and_out_transaction_state.dart';

class InAndOutTransactionForm extends StatefulWidget {
  const InAndOutTransactionForm({super.key});

  @override
  State<InAndOutTransactionForm> createState() =>
      _InAndOutTransactionFormState();
}

class _InAndOutTransactionFormState extends State<InAndOutTransactionForm> {
  late TextEditingController resourseController;
  late TextEditingController destinationController;
  late TextEditingController currencyController;
  late TextEditingController amountController;
  late TextEditingController noteController;
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;




  int? selectedCurrencyId;
  int? selectedDestinationId;

  @override
  void initState() {
    final user = getIt<CacheServices>().getDataFromCache<UserModel>(
      boxName: CacheBoxes.userModelBox,
      key: "user",
    );
    resourseController = TextEditingController(text: user?.branch?.name ?? '');
    destinationController = TextEditingController();
    currencyController = TextEditingController();
    amountController = TextEditingController();
    noteController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    resourseController.dispose();
    destinationController.dispose();
    currencyController.dispose();
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  void _onCurrencySelected(CurrencyModel currency) {
    setState(() {
      currencyController.text = currency.name ?? '';
      selectedCurrencyId = currency.id;
    });
  }

  void _showCurrencyBottomSheet(List<CurrencyModel> currencies) {
    GlobalUiUtils.showBottomSheet(
      context,
      child: CurrencySelectionBottomSheet(
        currencies: currencies,
        selectedCurrencyId: selectedCurrencyId,
        onCurrencySelected: (currency) {
          _onCurrencySelected(currency);
          Navigator.pop(context);
        },
      ),
    );
  }

  _onDestinationSelected(BranchModel branch) {
    setState(() {
      destinationController.text = branch.name ?? '';
      selectedDestinationId = branch.id;
    });
  }

  void _showBranchBottomSheet(List<BranchModel?> branches) {
    GlobalUiUtils.showBottomSheet(
      context,
      child: BranchSelectionBottomSheet(
        branches: branches,
        selectedBranchId: selectedDestinationId,
        onBranchSelected: (branch) {
          _onDestinationSelected(branch);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _handleSendButton() {
    if (formKey.currentState?.validate() ?? false) {
      final amount = double.tryParse(amountController.text);

      if (amount == null || amount <= 0) {
        AppSnackBar.showSnackBar(
          context: context,
          message: "please Enter Valid Amount",
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

  void _onDenominationsConfirmed(
    List<DenominationsRequestParams> denominations,
  ) {
    final cubit = context.read<InAndOutTransactionCubit>();
    cubit.inAndOutTransaction(
      params: InAndOutRequestParams(
        toBranchId: selectedDestinationId ?? 0,
        currencyId: selectedCurrencyId ?? 0,
        amount: double.tryParse(amountController.text) ?? 0,
        notes: noteController.text,
        denominations: denominations,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: BlocListener<InAndOutTransactionCubit, InAndOutTransactionState>(
        listener: (context, state) {
          if (state.inAndOutTransactionStatus.isSuccess) {
            AppSnackBar.showSnackBar(
              context: context,
              message: state.message!,
              state: SnackBarStates.success,
            );
            context.pop();
          context.read<HomeCubit>().getBranchCurrencies();
          }else if (state.inAndOutTransactionStatus.isError) {
            AppSnackBar.showSnackBar(
              context: context,
              message: state.message!,
              state: SnackBarStates.error,
            );
          }
        },
        child: Column(
          children: [
            CustomTextFieldWithLabel(
              controller: resourseController,
              label: context.resource,
              hintText: context.resource,
              isReadOnly: true,
              isRequired: true,
              prefixWidget: AppAssets.svgsBank,
              enabled: false,
            ),
            20.verticalSizedBox,
            BlocBuilder<GeneralCubit, GeneralState>(
              builder: (context, state) {
                return CustomTextFieldWithLabel(
                  controller: destinationController,
                  label: context.destination,
                  hintText: context.distinctionHint,
                  isReadOnly: true,
                  isRequired: true,
                  prefixWidget: AppAssets.svgsBank,
                  validator: (value) => Validator.validateAnotherField(value, context),
                  onTap: () {
                     _showBranchBottomSheet(state.branches!);
                  },
                  suffixWidget: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                       _showBranchBottomSheet(state.branches!);
                    },
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: context.colors.grayColor,
                    ),
                  ),
                );
              },
            ),
            20.verticalSizedBox,
            CustomTextFieldWithLabel(
              controller: currencyController,
              label: context.currency,
              hintText: context.currency,
              isReadOnly: true,
              isRequired: true,
              prefixWidget: AppAssets.svgsCoinsIcon,
              validator: (value) =>
                  Validator.validateAnotherField(value, context),
              onTap: () {
                context.read<InAndOutTransactionCubit>().state.inAndOutTransactionStatus.isLoading
                    ? null
                    : _showCurrencyBottomSheet(
                        context.read<HomeCubit>().state.currenciesList);
              },
              suffixWidget: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                   context.read<InAndOutTransactionCubit>().state.inAndOutTransactionStatus.isLoading
                    ? null
                    : _showCurrencyBottomSheet(
                        context.read<HomeCubit>().state.currenciesList);
                },
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: context.colors.grayColor,
                ),
              ),
            ),
            20.verticalSizedBox,
            CustomTextFieldWithLabel(
              controller: amountController,
              label: context.amount,
              hintText: context.amountHint,
              keyboardType: TextInputType.number,
              isRequired: true,
              validator: (value) =>
                  Validator.validateAnotherField(value, context),
            ),
            20.verticalSizedBox,
            CustomTextFieldWithLabel(
              controller: noteController,
              label: context.note,
              hintText: context.notesHint,
              maxLines: 3,
            ),
            40.verticalSizedBox,
            MainButton(title: context.confirm, onTap: _handleSendButton),
          ],
        ),
      ),
    );
  }


}
