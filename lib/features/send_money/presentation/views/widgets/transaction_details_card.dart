import 'package:alalamia/core/database/cache/cache_helper.dart';
import 'package:alalamia/core/database/cache/cache_services.dart';
import 'package:alalamia/core/di/dependency_injection.dart';
import 'package:alalamia/core/enums/commission_type_enum.dart';
import 'package:alalamia/core/general/cubit/general_cubit.dart';
import 'package:alalamia/core/general/cubit/general_state.dart';
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
import 'delivery_types_widget.dart';

class TransactionDetailsCard extends StatefulWidget {
  const TransactionDetailsCard({super.key});

  @override
  State<TransactionDetailsCard> createState() => _TransactionDetailsCardState();
}

class _TransactionDetailsCardState extends State<TransactionDetailsCard> {
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
    context.read<GeneralCubit>().getAllBranches();
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
    _calculateExchangeRate();
    setState(() {
      openCurrencyDropDown = false;
      currencyController.text = selectedItem;
      selectedCurrencyId = selectedCurrency.id;
    });
  }

  void _onToCurrencySelected(String selectedItem) {
    final homeCubit = context.read<HomeCubit>();
    final selectedCurrency = homeCubit.state.currenciesList.firstWhere(
      (currency) => currency.name == selectedItem,
    );
    _calculateExchangeRate();
    setState(() {
      openToCurrencyDropDown = false;
      toCurrencyController.text = selectedItem;
      selectedToCurrencyId = selectedCurrency.id;
    });
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
  }

  void _onCommissionTypeSelected(String selectedItem) {
    setState(() {
      openCommissionTypesDropDown = false;
      commissionTypeController.text = selectedItem;
      selectedCommissionType = selectedItem;
    });
  }

  void _calculateExchangeRate() {
    if (selectedCurrencyId == null || selectedToCurrencyId == null) return;

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
    final num exchangeRate = homeState.transferCurrency?.exchangePriceUsed ?? 0;
    final result = (amount * exchangeRate).toStringAsFixed(2);
   converterAmountController.text = result;
   
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
              DeliveryTypeWidget(),
              16.verticalSizedBox,

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
              16.verticalSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomTextFieldWithLabel(
                      onTap: () {
                        setState(() {
                          openCommissionTypesDropDown =
                              !openCommissionTypesDropDown;
                        });
                      },
                      label: context.commission,
                      initialValue: "${getIt<CacheServices>().getDataFromCache<UserModel>(boxName: CacheBoxes.userModelBox, key: "user")?.branch?.commissionRatePercentage} %",
                      hintText: "\$20",
                      enabled: false,
                      prefixWidget: AppAssets.svgsCoinsIcon,
                      isRequired: true,
                    ),
                  ),
                  14.horizontalSizedBox,
                  Expanded(
                    child: CustomTextFieldWithLabel(
                      controller: commissionTypeController,
                      label: context.commissionType,
                      hintText: context.commissionType,
                      prefixWidget: AppAssets.svgsCoinsIcon,
                      isRequired: true,
                      isReadOnly: true,
                      suffixWidget: InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            openCommissionTypesDropDown =
                                !openCommissionTypesDropDown;
                          });
                        },
                        child: Icon(
                          openCommissionTypesDropDown
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          color: openCommissionTypesDropDown
                              ? context.colors.primaryColor
                              : context.colors.grayColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (openCommissionTypesDropDown)
                CustomDropDownCard(
                  dropDownItems: CommissionTypeEnum.values
                      .map((e) => e.getCommissionType(context))
                      .toList(),
                  selectedValue: commissionTypeController.text,
                  onItemSelected: _onCommissionTypeSelected,
                ).onlyPadding(topPadding: 6),

              context.read<SendMoneyCubit>().state.deliveryType ==
                      DeliveryTypeEnum.externalDelivery
                  ? Column(
                      children: [
                        16.verticalSizedBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomTextFieldWithLabel(
                                controller: toCurrencyController,
                                label: context.convertedCurrency,
                                hintText: context.convertedCurrency,
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
                                    label: context.convertedAmount,
                                    hintText: context.convertedAmount,
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
                    )
                  : 0.verticalSizedBox,
            ],
          ),
        );
      },
    );
  }
}
