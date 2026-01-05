import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/core/general/cubit/general_state.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/features/debts/presentation/cubit/debt_state.dart';
import 'package:alalamia/features/debts/presentation/cubit/debts_cubit.dart';
import 'package:alalamia/features/home/presentation/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/widgets/app_snack_bar.dart';
import '../../../../../core/components/widgets/custom_drop_down_card.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../core/components/widgets/main_button.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/enums/debets_enum.dart';
import '../../../../../core/general/cubit/general_cubit.dart';
import '../../../../../core/utils/global_ui_utils.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../../generated/app_assets.dart';
import '../../../../home/presentation/cubit/home_cubit.dart';
import '../../../../transfer_money/data/models/transfer_money_request_params.dart';
import '../../../../transfer_money/presentation/views/widgets/all_denominations_bottom_sheet.dart';
import '../../../data/models/add_debt_request_params.dart';

class RequestDebtForm extends StatefulWidget {
  const RequestDebtForm({super.key, required this.debetType});
  final DebetsTypeEnum debetType;

  @override
  State<RequestDebtForm> createState() => _RequestDebtFormState();
}

class _RequestDebtFormState extends State<RequestDebtForm> {
  late TextEditingController amountController;
  late TextEditingController currencyController;
  late TextEditingController purposeController;
  late TextEditingController phoneController;
  late TextEditingController nameController;

  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isDropDownOpen = false;
  int? selectedCurrencyId;
  @override
  void initState() {
    amountController = TextEditingController();
    currencyController = TextEditingController();
    purposeController = TextEditingController();
    phoneController = TextEditingController();
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    amountController.dispose();
    currencyController.dispose();
    purposeController.dispose();
    phoneController.dispose();
    nameController.dispose();
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

  void _onDenominationsConfirmed(List<DenominationsRequestParams> denominations) {
    final addDebtRequestParams = AddDebtRequestParams(
      amount: amountController.text,
      currencyId: selectedCurrencyId!,
      notes: purposeController.text,
      phone: widget.debetType == DebetsTypeEnum.debt_outside
          ? phoneController.text
          : '',
      name: widget.debetType == DebetsTypeEnum.debt_outside
          ? nameController.text
          : '',
      denominations: denominations,
    );
    context.read<DebtsCubit>().addDebt(
      addDebtRequestParams: addDebtRequestParams,
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
            widget.debetType == DebetsTypeEnum.debt_outside
                ? _buildUserData(context)
                : const SizedBox(),
            _buildCurrencyField(context),
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
            20.verticalSizedBox,
            CustomTextFieldWithLabel(
              label: context.purpose,
              hintText: context.purposeHint,
              keyboardType: TextInputType.text,
              controller: purposeController,
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

  Widget _buildUserData(BuildContext context) {
    return BlocListener<GeneralCubit, GeneralState>(
      listener: (context, state) {
        if (state.getUserByPhoneStatus.isSuccess) {
          nameController.text = state.userByPhone?.name ?? '';
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
