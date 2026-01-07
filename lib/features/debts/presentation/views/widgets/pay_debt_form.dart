import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/features/debts/presentation/cubit/debt_state.dart';
import 'package:alalamia/features/debts/presentation/cubit/debts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/widgets/app_snack_bar.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../core/components/widgets/main_button.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/enums/debets_enum.dart';
import '../../../../../core/general/cubit/general_cubit.dart';
import '../../../../../core/general/cubit/general_state.dart';
import '../../../../../core/utils/global_ui_utils.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../../generated/app_assets.dart';
import '../../../../home/presentation/cubit/home_cubit.dart';
import '../../../../home/presentation/cubit/home_state.dart';
import '../../../../transfer_money/data/models/transfer_money_request_params.dart';
import '../../../../transfer_money/presentation/views/widgets/all_denominations_bottom_sheet.dart';
import '../../../data/models/get_debts_by_currency_request_params.dart';
import 'package:alalamia/features/home/data/models/currency_model.dart';
import 'currency_selection_bottom_sheet.dart';
import '../../../data/models/pay_debt_request_params.dart';

class PayDebtForm extends StatefulWidget {
  const PayDebtForm({super.key, required this.debtType});
  final DebetsTypeEnum debtType;

  @override
  State<PayDebtForm> createState() => _PayDebtFormState();
}

class _PayDebtFormState extends State<PayDebtForm> {
  late TextEditingController amountController;
  late TextEditingController currencyController;
  late TextEditingController phoneController;
  late TextEditingController nameController;

  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  int? selectedCurrencyId;
  @override
  void initState() {
    amountController = TextEditingController();
    currencyController = TextEditingController();
    phoneController = TextEditingController();
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    amountController.dispose();
    currencyController.dispose();
    phoneController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void _onItemSelected(CurrencyModel currency) {
    context.read<DebtsCubit>().getDebtsByCurrency(
      id: currency.id!,
      params: GetDebtsByCurrencyRequestParams(
        debtsType: widget.debtType,
        phone: phoneController.text,
      ),
    );
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
          _onItemSelected(currency);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _onDenominationsConfirmed(List<DenominationsRequestParams> denominations) {
    final payDebtRequestParams = PayDebtRequestParams(
      amount: amountController.text,
      currencyId: selectedCurrencyId!,
      name: nameController.text,
      phone: phoneController.text,
      denominations: denominations,
    );
    context.read<DebtsCubit>().payDebt(
      payDebtRequestParams: payDebtRequestParams,
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
    return BlocListener<DebtsCubit, DebtsState>(
      listener: (context, state) {
        if (state.debtsStatus.isSuccess) {
          AppSnackBar.showSnackBar(
            context: context,
            message: state.message!,
            state: SnackBarStates.success,
          );
          context.read<DebtsCubit>().getDebtsTransactions(
            type: widget.debtType == DebetsTypeEnum.debt_inside ? "inside" : "outside",
          );
          context.pop();
          context.pop();
          context.read<HomeCubit>().getBranchCurrencies();
        } else if (state.debtsStatus.isError) {
          AppSnackBar.showSnackBar(
            context: context,
            message: state.message!,
            state: SnackBarStates.error,
          );
        }
      },
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          children: [
            widget.debtType == DebetsTypeEnum.debt_outside
                ? _buildUserData(context)
                : const SizedBox(),
            _buildCurrencyField(context),
            _buildTotalDebt(),
            20.verticalSizedBox,
            CustomTextFieldWithLabel(
              label: context.amount,
              controller: amountController,
              hintText: context.enterRequiredAmount,
              isRequired: true,
              keyboardType: TextInputType.number,
              validator: (value) =>
                  Validator.validateAnotherField(value, context),
            ),
            40.verticalSizedBox,
            MainButton(
              title: context.send,
              onTap: _handleSendButton,
            ),
          ],
        ),
      ),
    );
  }

  BlocBuilder<DebtsCubit, DebtsState> _buildTotalDebt() {
    return BlocBuilder<DebtsCubit, DebtsState>(
      builder: (context, state) {
        return (widget.debtType == DebetsTypeEnum.debt_outside  ?(currencyController.text.isEmpty ||
                state.debtsAmountByCurrency == null || phoneController.text.isEmpty) :(currencyController.text.isEmpty ||
                state.debtsAmountByCurrency == null ) )
            ? SizedBox()
            : Column(
                children: [
                  6.verticalSizedBox,
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 18),
                    decoration: BoxDecoration(
                      color: context.colors.primaryColor.withValues(
                        alpha: 0.03,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: context.colors.primaryColor.withValues(
                          alpha: 0.30,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.totalDebt,
                          style: context.textStyles.font14MediumGrayColor,
                        ),
                        12.verticalSizedBox,
                        Text(
                          "${state.debtsAmountByCurrency ?? 0}",
                          style:
                              context.textStyles.font18SemiBoldSecondaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              );
      },
    );
  }

  Widget _buildCurrencyField(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return CustomTextFieldWithLabel(
          onTap: () {
            _showCurrencyBottomSheet(state.currenciesList);
          },
          controller: currencyController,
          label: context.currency,
          hintText: context.currenyHint,
          prefixWidget: AppAssets.svgsCoinsIcon,
          isRequired: true,
          isReadOnly: true,
          validator: (value) => Validator.validateAnotherField(value, context),
          suffixWidget: InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              _showCurrencyBottomSheet(state.currenciesList);
            },
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: context.colors.grayColor,
            ),
          ),
        );
      },
    );
  }

   Widget _buildUserData(BuildContext context) {
    return BlocListener<GeneralCubit, GeneralState>(
      listener: (context, state) {
      if(state.getUserByPhoneStatus.isSuccess) {
        nameController.text = state.userByPhone?.name ?? '';
      context.read<DebtsCubit>().getDebtsByCurrency(
      id: selectedCurrencyId!,
      params: GetDebtsByCurrencyRequestParams(debtsType: widget.debtType, phone: phoneController.text),
    );
      }
      },
      child: Column(
        children: [
          CustomTextFieldWithLabel(
            label: context.phone,
            controller: phoneController,
            hintText: context.phoneHint,
            isRequired: true,
            keyboardType: TextInputType.phone,
            onChanged: (val) {
              context.read<GeneralCubit>().getUserByPhone(phone: val.trim());
            },
            validator: (value) => Validator.validatePhone(value, context),
          ),
          20.verticalSizedBox,
          CustomTextFieldWithLabel(
            label: context.clientName,
            hintText: context.clientNameHint,
            keyboardType: TextInputType.text,
            controller: nameController,
            isRequired: true,
              validator: (value) =>
                Validator.validateAnotherField(value, context),
          ),
          20.verticalSizedBox,
        ],
      ),
    );
  }
}
