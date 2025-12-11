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
import '../../../../../core/utils/validator.dart';
import '../../../../../generated/app_assets.dart';
import '../../../../home/presentation/cubit/home_cubit.dart';
import '../../../../home/presentation/cubit/home_state.dart';
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
    amountController = TextEditingController();
    currencyController = TextEditingController();
    purposeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    amountController.dispose();
    currencyController.dispose();
    purposeController.dispose();
    super.dispose();
  }

  void _onItemSelected(String selectedItem) {
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
        }
      },
      builder: (context, state) {
        var cubit = context.read<ExpensesCubit>();
        return Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              CustomTextFieldWithLabel(
                controller: purposeController,
                label: context.purpose,
                hintText: context.purposeHint,
                isRequired: true,
                keyboardType: TextInputType.text,
                validator: (value) =>
                    Validator.validateAnotherField(value, context),
              ),
              20.verticalSizedBox,
              currencyField(context),
              20.verticalSizedBox,
              CustomTextFieldWithLabel(
                controller: amountController,
                label: context.amount,
                hintText: context.enterAmountExpenses,
                isRequired: true,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    Validator.validateAnotherField(value, context),
              ),
              40.verticalSizedBox,
              MainButton(
                title: context.send,
                onTap: () {
                  if (formKey.currentState?.validate() ?? false) {
                    cubit.addExpense(
                      expensesRequestParams: ExpensesRequestParams(
                        currencyId: selectedCurrencyId ?? 0,
                        amount: amountController.text,
                        notes: purposeController.text,
                      ),
                    );
                  } else {
                    setState(() {
                      autovalidateMode = AutovalidateMode.always;
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget currencyField(BuildContext context) {
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
