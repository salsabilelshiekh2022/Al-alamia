import 'package:alalamia/core/database/cache/cache_helper.dart';
import 'package:alalamia/core/di/dependency_injection.dart';
import 'package:alalamia/core/general/cubit/general_cubit.dart';
import 'package:alalamia/core/general/cubit/general_state.dart';
import 'package:alalamia/features/auth/data/models/user_model.dart';
import 'package:alalamia/features/home/presentation/cubit/home_state.dart';
import 'package:alalamia/features/in_and_out_transaction/presentation/cubit/in_and_out_transaction_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/widgets/app_snack_bar.dart';
import '../../../../../core/components/widgets/custom_drop_down_card.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../core/components/widgets/main_button.dart';
import '../../../../../core/database/cache/cache_services.dart';
import '../../../../../core/enums/request_status.dart';
import '../../../../../core/helper/app_extention.dart';
import '../../../../../core/helper/number_extentions.dart';
import '../../../../../core/helper/translation_extensions.dart';
import '../../../../../core/helper/widget_extentions.dart';
import '../../../../../core/utils/global_ui_utils.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../../generated/app_assets.dart';
import '../../../../home/presentation/cubit/home_cubit.dart';
import '../../../../transfer_money/data/models/transfer_money_request_params.dart';
import '../../../../transfer_money/presentation/views/widgets/all_denominations_bottom_sheet.dart';
import '../../../data/models/in_and_out_request_params.dart';
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

  bool openCurrencyDropDown = false;
  bool openDestinationDropDown = false;

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

  void _onCurrencySelected(String selectedItem) {
    final homeCubit = context.read<HomeCubit>();
    final selectedCurrency = homeCubit.state.currenciesList.firstWhere(
      (currency) => currency.name == selectedItem,
    );

    setState(() {
      openCurrencyDropDown = false;
      currencyController.text = selectedItem;
      selectedCurrencyId = selectedCurrency.id;
    });
  }

  _onDestinationSelected(String selectedItem) {
    final generalCubit = context.read<GeneralCubit>();
    final selectedDestination = generalCubit.state.branches!.firstWhere(
      (branch) => branch?.name == selectedItem,
    );

    setState(() {
      openDestinationDropDown = false;
      destinationController.text = selectedItem;
      selectedDestinationId = selectedDestination?.id;
    });
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
            CustomTextFieldWithLabel(
              controller: destinationController,
              label: context.destination,
              hintText: context.distinctionHint,
              isReadOnly: true,
              isRequired: true,
              prefixWidget: AppAssets.svgsBank,
              validator: (value) => Validator.validateAnotherField(value, context),
              onTap: () {
                setState(() {
                  openDestinationDropDown = !openDestinationDropDown;
                  openCurrencyDropDown = false;
                });
              },
              suffixWidget: _buildDropdownIcon(
                isDropDownOpen: openDestinationDropDown,
              ),
            ),
            if (openDestinationDropDown)
              BlocBuilder<GeneralCubit, GeneralState>(
                builder: (context, state) {
                  return CustomDropDownCard(
                    dropDownItems: state.branches!
                        .map((e) => e?.name)
                        .whereType<String>()
                        .toList(),
                    selectedValue: destinationController.text,
                    onItemSelected: _onDestinationSelected,
                  );
                },
              ).onlyPadding(topPadding: 6),
            20.verticalSizedBox,
            CustomTextFieldWithLabel(
              controller: currencyController,
              label: context.currency,
              hintText: context.currency,
              isReadOnly: true,
              isRequired: true,
              prefixWidget: AppAssets.svgsCoinsIcon,
              validator: (value) => Validator.validateAnotherField(value, context),
              onTap: () {
                setState(() {
                  openCurrencyDropDown = !openCurrencyDropDown;
                  openDestinationDropDown = false;
                });
              },
              suffixWidget: _buildDropdownIcon(
                isDropDownOpen: openCurrencyDropDown,
              ),
            ),
            if (openCurrencyDropDown)
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return CustomDropDownCard(
                    dropDownItems: state.currenciesList
                        .map((e) => e.name)
                        .whereType<String>()
                        .toList(),
                    selectedValue: currencyController.text,
                    onItemSelected: _onCurrencySelected,
                  );
                },
              ).onlyPadding(topPadding: 6),
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

  Widget _buildDropdownIcon({required bool isDropDownOpen}) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () => _toggleDropdown(isDropDownOpen: isDropDownOpen),
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

  void _toggleDropdown({required bool isDropDownOpen}) {
    setState(() {
      isDropDownOpen = !isDropDownOpen;
    });
  }
}
