import 'package:alalamia/core/database/cache/cache_helper.dart';
import 'package:alalamia/core/database/cache/cache_services.dart';
import 'package:alalamia/core/di/dependency_injection.dart';
import 'package:alalamia/core/enums/commission_type_enum.dart';
import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/core/general/cubit/general_cubit.dart';
import 'package:alalamia/core/general/cubit/general_state.dart';
import 'package:alalamia/core/general/data/models/fee_details_request_params.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/core/utils/validator.dart';
import 'package:alalamia/features/auth/data/models/user_model.dart';
import 'package:alalamia/features/home/presentation/cubit/home_state.dart';
import 'package:alalamia/features/send_money/presentation/cubit/send_money_cubit.dart';
import 'package:alalamia/features/send_money/presentation/cubit/send_money_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/widgets/card_with_purple_shadow.dart';
import '../../../../../core/components/widgets/custom_drop_down_card.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../core/enums/delivery_type_enum.dart';
import '../../../../../generated/app_assets.dart';
import '../../../../home/data/models/transfer_currency_request_params.dart';
import '../../../../home/presentation/cubit/home_cubit.dart';
import '../../../data/models/send_money_form_data.dart';

class ExternalTransactionDetailsCard extends StatefulWidget {
  const ExternalTransactionDetailsCard({super.key});

  @override
  State<ExternalTransactionDetailsCard> createState() =>
      _ExternalTransactionDetailsCardState();
}

class _ExternalTransactionDetailsCardState
    extends State<ExternalTransactionDetailsCard> {
  late TextEditingController currencyController;
  late TextEditingController toCurrencyController;
  late TextEditingController converterAmountController;
  late TextEditingController destinationController;
  late TextEditingController amountController;
  late TextEditingController amountByCharController;
  late TextEditingController commissionTypeController;
  late TextEditingController commissionController;
  bool openCurrencyDropDown = false;
  bool openDestinationDropDown = false;
  bool openCommissionTypesDropDown = false;
  bool openToCurrencyDropDown = false;
  int? selectedCurrencyId;
  int? selectedToCurrencyId;
  int? selectedDestinationId;
  String? selectedCommissionType;
  @override
  void initState() {
    currencyController = TextEditingController();
    destinationController = TextEditingController();
    amountController = TextEditingController();
    amountByCharController = TextEditingController();
    commissionTypeController = TextEditingController();
    commissionController = TextEditingController();
    toCurrencyController = TextEditingController();
    converterAmountController = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.read<GeneralCubit>().getAllBranches(
      queryParameters: {'type': "company"},
    );
    context.read<GeneralCubit>().getPaymentMethods();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    currencyController.dispose();
    destinationController.dispose();
    amountController.dispose();
    amountByCharController.dispose();
    commissionController.dispose();
    commissionTypeController.dispose();
    toCurrencyController.dispose();
    converterAmountController.dispose();
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
    _calculateExchangeRate();
    _onAmountChanged(amountController.text);
    _updateFormData();
    _getFeeDetails();
  }

  void _onToCurrencySelected(String selectedItem) {
    final homeCubit = context.read<HomeCubit>();
    final selectedCurrency = homeCubit.state.currenciesList.firstWhere(
      (currency) => currency.name == selectedItem,
    );
    setState(() {
      openToCurrencyDropDown = false;
      toCurrencyController.text = selectedItem;
      selectedToCurrencyId = selectedCurrency.id;
    });
    _calculateExchangeRate();
    _onAmountChanged(amountController.text);
    _updateFormData();
    _getFeeDetails();
  }

  void _onDestinationSelected(String selectedItem) {
    final generalCubit = context.read<GeneralCubit>();
    final selectedDestination = generalCubit.state.branches?.firstWhere(
      (branch) => branch?.name == selectedItem,
    );
    setState(() {
      openDestinationDropDown = false;
      destinationController.text = selectedItem;
      selectedDestinationId = selectedDestination?.id;
    });
    _updateFormData();
  }

  void _calculateExchangeRate() {
    print(
      "selectedCurrencyId: $selectedCurrencyId, selectedToCurrencyId: $selectedToCurrencyId",
    );
    if (selectedCurrencyId == null ||
        selectedToCurrencyId == null ||
        amountController.text.isEmpty)
      return;
    print(
      "selectedCurrencyId: $selectedCurrencyId, selectedToCurrencyId: $selectedToCurrencyId",
    );

    final cubit = context.read<HomeCubit>();
    cubit.transferCurrency(
      transferCurrencyRequestParams: TransferCurrencyRequestParams(
        fromCurrencyId: selectedCurrencyId!,
        toCurrencyId: selectedToCurrencyId!,
        amount: int.parse(amountController.text),
      ),
    );
  }

  void _onAmountChanged(String value) {
    final homeState = context.read<HomeCubit>().state;
    final double amount = double.tryParse(value) ?? 0;
    final num exchangeRate =homeState.transferCurrencyStatus.isSuccess ? homeState.transferCurrency?.exchangePriceUsed ?? 0 : 0;
    final result = (amount * exchangeRate).toStringAsFixed(2);
    converterAmountController.text = result;

    // Calculate commission
    final branch = getIt<CacheServices>()
        .getDataFromCache<UserModel>(
          boxName: CacheBoxes.userModelBox,
          key: "user",
        )
        ?.branch;

    final double commissionPercentage =
        double.tryParse(branch?.commissionRatePercentage ?? "0") ?? 0.0;

    final double commissionAmount = (amount * commissionPercentage) / 100;
    commissionController.text = commissionAmount.toStringAsFixed(2);

    _updateFormData();
    _getFeeDetails();
  }

  /// Update form data in cubit with current transaction details
  void _updateFormData() {
    try {
      final cubit = context.read<SendMoneyCubit>();
      final currentFormData = cubit.state.formData ?? SendMoneyFormData.empty();
      final homeCubit = context.read<HomeCubit>();

      // Get currency models
      final fromCurrency = selectedCurrencyId != null
          ? homeCubit.state.currenciesList.firstWhere(
              (c) => c.id == selectedCurrencyId,
              orElse: () => homeCubit.state.currenciesList.first,
            )
          : null;

      final toCurrency = selectedToCurrencyId != null
          ? homeCubit.state.currenciesList.firstWhere(
              (c) => c.id == selectedToCurrencyId,
              orElse: () => homeCubit.state.currenciesList.first,
            )
          : cubit.state.deliveryType == DeliveryTypeEnum.inside
          ? fromCurrency // For inside delivery, to currency is same as from currency
          : null;

      // Get branch models
      final fromBranch = getIt<CacheServices>()
          .getDataFromCache<UserModel>(
            boxName: CacheBoxes.userModelBox,
            key: "user",
          )
          ?.branch
          ?.id;

      final toBranch = selectedDestinationId;

      // Get commission type
      CommissionTypeEnum? commissionType;
      if (selectedCommissionType != null) {
        for (var type in CommissionTypeEnum.values) {
          if (type.getCommissionType(context) == selectedCommissionType) {
            commissionType = type;
            break;
          }
        }
      }

      cubit.updateFormData(
        currentFormData.copyWith(
          fromCurrency: fromCurrency,
          toCurrency: toCurrency,
          fromBranch: fromBranch,
          toBranch: toBranch,
          amount: amountController.text,
          amountByChar: amountByCharController.text,
          commissionType: fromCurrency != toCurrency
              ? CommissionTypeEnum.none
              : commissionType,
        ),
      );
      print('DEBUG: Form data updated successfully');
    } catch (e, stackTrace) {
      print('ERROR in _updateFormData: $e');
      print('Stack trace: $stackTrace');
    }
  }

  void _getFeeDetails() {
    if (amountController.text.isEmpty || selectedCurrencyId == null) {
      return;
    }

    int? toCurrencyId = selectedToCurrencyId;

    if (toCurrencyId == null) return;

    CommissionTypeEnum commissionType = CommissionTypeEnum.none;
    if (selectedCommissionType != null) {
      for (var type in CommissionTypeEnum.values) {
        if (type.getCommissionType(context) == selectedCommissionType) {
          commissionType = type;
          break;
        }
      }
    }

    context.read<GeneralCubit>().getFeeDetails(
      params: FeeDetailsRequestParams(
        fromCurrencyId: selectedCurrencyId!,
        toCurrencyId: toCurrencyId,
        amount: amountController.text,
        commissionType: commissionType,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendMoneyCubit, SendMoneyState>(
      builder: (context, state) {
        return CardWithPurpleShadow(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.transactionDetails,
                style: context.textStyles.font16SemiBoldSecondaryColor,
              ),
              12.verticalSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomTextFieldWithLabel(
                      controller: currencyController,
                      label: context.currency,
                      hintText: context.currenyHint,
                      prefixWidget: AppAssets.svgsDollarIcon,
                      isRequired: true,
                      isReadOnly: true,
                      suffixWidget: InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            openCurrencyDropDown = !openCurrencyDropDown;
                          });
                        },
                        child: Icon(
                          openCurrencyDropDown
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          color: openCurrencyDropDown
                              ? context.colors.primaryColor
                              : context.colors.grayColor,
                        ),
                      ),
                    ),
                  ),
                  14.horizontalSizedBox,
                  Expanded(
                    child: CustomTextFieldWithLabel(
                      onChanged: (val) {
                        _onAmountChanged(val);
                      },
                      controller: amountController,
                      label: context.amount,
                      hintText: context.amountHint,
                      prefixWidget: AppAssets.svgsDollarIcon,
                      isRequired: true,
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          Validator.validateAnotherField(value, context),
                    ),
                  ),
                ],
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
              16.verticalSizedBox,
              CustomTextFieldWithLabel(
                controller: amountByCharController,
                label: context.amountByChar,
                hintText: context.amountHint,
                prefixWidget: AppAssets.svgsDollarIcon,
                isRequired: true,
                keyboardType: TextInputType.text,
                validator: (value) =>
                    Validator.validateAnotherField(value, context),
                onChanged: (_) => _updateFormData(),
              ),
              16.verticalSizedBox,
              CustomTextFieldWithLabel(
                label: context.resource,
                hintText: context.recourseHint,
                prefixWidget: AppAssets.svgsBank,
                isRequired: true,
                initialValue:
                    getIt<CacheServices>()
                        .getDataFromCache<UserModel>(
                          boxName: CacheBoxes.userModelBox,
                          key: "user",
                        )
                        ?.branch
                        ?.name ??
                    "",
                isReadOnly: true,
              ),
              16.verticalSizedBox,
              // DeliveryTypeWidget(),
              // 16.verticalSizedBox,
              CustomTextFieldWithLabel(
                onTap: () {
                  setState(() {
                    openDestinationDropDown = !openDestinationDropDown;
                  });
                },
                label: context.destination,
                controller: destinationController,
                hintText: context.distinctionHint,
                prefixWidget: AppAssets.svgsBank,
                isReadOnly: true,
                isRequired: true,
                suffixWidget: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      openDestinationDropDown = !openDestinationDropDown;
                    });
                  },
                  child: Icon(
                    openDestinationDropDown
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: openDestinationDropDown
                        ? context.colors.primaryColor
                        : context.colors.grayColor,
                  ),
                ),
              ),
              if (openDestinationDropDown)
                BlocBuilder<GeneralCubit, GeneralState>(
                  builder: (context, state) {
                    return CustomDropDownCard(
                      dropDownItems: state.branches != null
                          ? state.branches!
                                .map((e) => e?.name)
                                .whereType<String>()
                                .toList()
                          : [],
                      selectedValue: destinationController.text,
                      onItemSelected: _onDestinationSelected,
                    );
                  },
                ).onlyPadding(topPadding: 6),
              Column(
                children: [
                  16.verticalSizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomTextFieldWithLabel(
                          controller: toCurrencyController,
                          label: context.toCurrency,
                          hintText: context.toCurrency,
                          prefixWidget: AppAssets.svgsDollarIcon,
                          isRequired: true,
                          isReadOnly: true,
                          suffixWidget: InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              setState(() {
                                openToCurrencyDropDown =
                                    !openToCurrencyDropDown;
                              });
                            },
                            child: Icon(
                              openToCurrencyDropDown
                                  ? Icons.keyboard_arrow_up_rounded
                                  : Icons.keyboard_arrow_down_rounded,
                              color: openToCurrencyDropDown
                                  ? context.colors.primaryColor
                                  : context.colors.grayColor,
                            ),
                          ),
                        ),
                      ),
                      14.horizontalSizedBox,
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          return Expanded(
                            child: CustomTextFieldWithLabel(
                              controller: converterAmountController,
                              label: context.amount,
                              hintText: context.amountHint,
                              prefixWidget: AppAssets.svgsDollarIcon,
                              isRequired: true,
                              isReadOnly: true,
                              keyboardType: TextInputType.number,
                              validator: (value) =>
                                  Validator.validateAnotherField(
                                    value,
                                    context,
                                  ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  if (openToCurrencyDropDown)
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        return CustomDropDownCard(
                          dropDownItems: state.currenciesList
                              .map((e) => e.name)
                              .whereType<String>()
                              .toList(),
                          selectedValue: toCurrencyController.text,
                          onItemSelected: _onToCurrencySelected,
                        );
                      },
                    ).onlyPadding(topPadding: 6),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
