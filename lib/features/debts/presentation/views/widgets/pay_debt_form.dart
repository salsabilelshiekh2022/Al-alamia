import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/features/debts/presentation/cubit/debt_state.dart';
import 'package:alalamia/features/debts/presentation/cubit/debts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/widgets/app_snack_bar.dart';
import '../../../../../core/components/widgets/custom_drop_down_card.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../core/components/widgets/main_button.dart';
import '../../../../../core/enums/debets_enum.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../../generated/app_assets.dart';
import '../../../../home/presentation/cubit/home_cubit.dart';
import '../../../../home/presentation/cubit/home_state.dart';
import '../../../data/models/get_debts_by_currency_request_params.dart';
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
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isDropDownOpen = false;
  int? selectedCurrencyId;
  @override
  void initState() {
    amountController = TextEditingController();
    currencyController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    amountController.dispose();
    currencyController.dispose();
    super.dispose();
  }

  void _onItemSelected(String selectedItem) {
    final homeCubit = context.read<HomeCubit>();
    final selectedCurrency = homeCubit.state.currenciesList.firstWhere(
      (currency) => currency.name == selectedItem,
    );
    context.read<DebtsCubit>().getDebtsByCurrency(
      id: selectedCurrency.id!,
      params: GetDebtsByCurrencyRequestParams(debtsType: widget.debtType),
    );
    setState(() {
      isDropDownOpen = false;
      currencyController.text = selectedItem;
      selectedCurrencyId = selectedCurrency.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
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
          BlocListener<DebtsCubit, DebtsState>(
            listener: (context, state) {
              if (state.debtsStatus.isSuccess) {
                AppSnackBar.showSnackBar(
                  context: context,
                  message: state.message!,
                  state: SnackBarStates.success,
                );
                context.pop();
              } else if (state.debtsStatus.isError) {
                AppSnackBar.showSnackBar(
                  context: context,
                  message: state.message!,
                  state: SnackBarStates.error,
                );
              }
            },
            child: MainButton(
              title: context.send,
              onTap: () {
                if (formKey.currentState!.validate()) {
                  final payDebtRequestParams = PayDebtRequestParams(
                    amount: amountController.text,
                    currencyId: selectedCurrencyId!,
                  );
                  context.read<DebtsCubit>().payDebt(
                    payDebtRequestParams: payDebtRequestParams,
                  );
                } else {
                  setState(() {
                    autovalidateMode = AutovalidateMode.always;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  BlocBuilder<DebtsCubit, DebtsState> _buildTotalDebt() {
    return BlocBuilder<DebtsCubit, DebtsState>(
      builder: (context, state) {
        return (currencyController.text.isEmpty ||
                state.debtsAmountByCurrency == null)
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
        return Column(
          children: [
            CustomTextFieldWithLabel(
              onTap: () {
                setState(() {
                  isDropDownOpen = !isDropDownOpen;
                });
              },
              controller: currencyController,
              label: context.currency,
              hintText: context.currenyHint,
              prefixWidget: AppAssets.svgsCoinsIcon,
              isRequired: true,
              isReadOnly: true,
              validator: (value) =>
                  Validator.validateAnotherField(value, context),
              suffixWidget: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    isDropDownOpen = !isDropDownOpen;
                  });
                },
                child: Icon(
                  isDropDownOpen
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: isDropDownOpen
                      ? context.colors.primaryColor
                      : context.colors.grayColor,
                ),
              ),
            ),

            isDropDownOpen
                ? CustomDropDownCard(
                    dropDownItems: state.currenciesList
                        .map((e) => e.name)
                        .whereType<String>()
                        .toList(),
                    selectedValue: currencyController.text,
                    onItemSelected: _onItemSelected,
                  ).onlyPadding(topPadding: 6)
                : SizedBox(),
          ],
        );
      },
    );
  }
}
