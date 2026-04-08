import 'package:alalamia/core/database/cache/cache_helper.dart';
import 'package:alalamia/core/database/cache/cache_services.dart';
import 'package:alalamia/core/di/dependency_injection.dart';
import 'package:alalamia/core/enums/commission_type_enum.dart';
import 'package:alalamia/core/general/cubit/general_cubit.dart';
import 'package:alalamia/core/general/cubit/general_state.dart';
import 'package:alalamia/core/general/data/models/fee_details_request_params.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/utils/validator.dart';
import 'package:alalamia/features/auth/data/models/user_model.dart';
import 'package:alalamia/features/home/presentation/cubit/home_state.dart';
import 'package:alalamia/features/send_money/presentation/cubit/send_money_cubit.dart';
import 'package:alalamia/features/send_money/presentation/cubit/send_money_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/widgets/card_with_purple_shadow.dart';
import '../../../../../core/components/widgets/currency_selection_bottom_sheet.dart';
import '../../../../../core/components/widgets/branch_selection_bottom_sheet.dart';
import '../../../../../core/components/widgets/commission_type_selection_bottom_sheet.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../core/enums/delivery_type_enum.dart';
import '../../../../../core/general/data/models/branch_model.dart';
import '../../../../../core/utils/global_ui_utils.dart';
import '../../../../../generated/app_assets.dart';
import '../../../../home/data/models/currency_model.dart';
import '../../../../home/data/models/transfer_currency_request_params.dart';
import '../../../../home/presentation/cubit/home_cubit.dart';
import '../../../data/models/send_money_form_data.dart';

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
  int? selectedCurrencyId;
  int? selectedToCurrencyId;
  int? selectedDestinationId;
  CommissionTypeEnum? selectedCommissionType;

  BranchModel? _findBranchById(List<BranchModel?> branches, int? branchId) {
    if (branchId == null) return null;
    for (final branch in branches) {
      if (branch?.id == branchId) return branch;
    }
    return null;
  }

  void _syncDestinationText(List<BranchModel?> branches) {
    if (selectedDestinationId == null) return;
    if (destinationController.text.trim().isNotEmpty) return;
    if (branches.isEmpty) return;

    final branch = _findBranchById(branches, selectedDestinationId);
    final name = branch?.name?.trim();
    if (name == null || name.isEmpty) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (destinationController.text.trim().isEmpty) {
        destinationController.text = name;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    // Initialize controllers
    currencyController = TextEditingController();
    destinationController = TextEditingController();
    amountController = TextEditingController();
    amountByCharController = TextEditingController();
    commissionTypeController = TextEditingController();
    commissionController = TextEditingController();
    toCurrencyController = TextEditingController();
    converterAmountController = TextEditingController();

    // Set default currency ID
    selectedCurrencyId = context
        .read<HomeCubit>()
        .state
        .currenciesList
        .first
        .id;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Load existing form data if available (for copy feature)
    _loadExistingFormData();

    // Load all branches
    context.read<GeneralCubit>().getAllBranches();
  }

  /// Load existing form data from cubit (used when copying transactions)
  void _loadExistingFormData() {
    final cubit = context.read<SendMoneyCubit>();
    final formData = cubit.state.formData;

    if (formData != null) {
      // Pre-fill controllers with existing data
      if (formData.amount.isNotEmpty) {
        amountController.text = formData.amount;
      }

      if (formData.amountByChar.isNotEmpty) {
        amountByCharController.text = formData.amountByChar;
      }

      // Set currency selections
      if (formData.fromCurrency != null) {
        setState(() {
          selectedCurrencyId = formData.fromCurrency!.id;
          currencyController.text = formData.fromCurrency!.name ?? '';
        });
      }

      if (formData.toCurrency != null) {
        setState(() {
          selectedToCurrencyId = formData.toCurrency!.id;
          toCurrencyController.text = formData.toCurrency!.name ?? '';
        });
      }

      // Set branch selection
      if (formData.toBranch != null) {
        setState(() {
          selectedDestinationId = formData.toBranch;
          // Try to set branch name immediately if branches are already loaded
          final generalState = context.read<GeneralCubit>().state;
          if (generalState.branches != null &&
              generalState.branches!.isNotEmpty) {
            final branch =
                _findBranchById(generalState.branches!, formData.toBranch);
            if (branch != null) {
              setState(() {
                destinationController.text = branch.name ?? '';
              });
            }
          }
        });
      }

      // Set commission type
      if (formData.commissionType != null) {
        setState(() {
          selectedCommissionType = formData.commissionType;
          commissionTypeController.text = formData.commissionType!
              .getCommissionType(context);
        });
      }

      // If we have amount and currency, calculate exchange rate and fee details
      if (formData.amount.isNotEmpty && selectedCurrencyId != null) {
        _onAmountChanged(formData.amount);
      }
    }
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

  void _onCurrencySelected(CurrencyModel currency) {
    _calculateExchangeRate();
    setState(() {
      currencyController.text = currency.name ?? '';
      selectedCurrencyId = currency.id;
    });
    _updateFormData();
    _getFeeDetails();
  }

  void _onToCurrencySelected(CurrencyModel currency) {
    _calculateExchangeRate();
    setState(() {
      toCurrencyController.text = currency.name ?? '';
      selectedToCurrencyId = currency.id;
    });
    _updateFormData();
    _getFeeDetails();
  }

  void _showCurrencyBottomSheet(
    List<CurrencyModel> currencies, {
    bool isToCurrency = false,
  }) {
    GlobalUiUtils.showBottomSheet(
      context,
      child: CurrencySelectionBottomSheet(
        currencies: currencies,
        selectedCurrencyId: isToCurrency
            ? selectedToCurrencyId
            : selectedCurrencyId,
        onCurrencySelected: (currency) {
          if (isToCurrency) {
            _onToCurrencySelected(currency);
          } else {
            _onCurrencySelected(currency);
          }
          Navigator.pop(context);
        },
      ),
    );
  }

  void _onDestinationSelected(BranchModel branch) {
    setState(() {
      destinationController.text = branch.name ?? '';
      selectedDestinationId = branch.id;
    });
    _updateFormData();
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

  void _onCommissionTypeSelected(CommissionTypeEnum type) {
    setState(() {
      commissionTypeController.text = type.getCommissionType(context);
      selectedCommissionType = type;
    });
    _updateFormData();
    _getFeeDetails();
  }

  void _showCommissionTypeBottomSheet() {
    GlobalUiUtils.showBottomSheet(
      context,
      child: CommissionTypeSelectionBottomSheet(
        selectedType: selectedCommissionType,
        onTypeSelected: (type) {
          _onCommissionTypeSelected(type);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _calculateExchangeRate() {
    if (selectedCurrencyId == null || selectedToCurrencyId == null) return;
    if (amountController.text.trim().isEmpty) return;

    final amount = num.tryParse(amountController.text.trim());
    if (amount == null) return;

    final cubit = context.read<HomeCubit>();
    cubit.transferCurrency(
      transferCurrencyRequestParams: TransferCurrencyRequestParams(
        fromCurrencyId: selectedCurrencyId!,
        toCurrencyId: selectedToCurrencyId!,
        amount: amount,
      ),
    );
  }

  void _onAmountChanged(String value) {
    final homeState = context.read<HomeCubit>().state;
    final double amount = double.tryParse(value) ?? 0;
    final num exchangeRate = homeState.transferCurrency?.exchangePriceUsed ?? 0;
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
      CommissionTypeEnum? commissionType = selectedCommissionType;

      cubit.updateFormData(
        currentFormData.copyWith(
          fromCurrency: fromCurrency,
          toCurrency: toCurrency,
          fromBranch: fromBranch,
          toBranch: toBranch,
          amount: amountController.text,
          amountByChar: amountByCharController.text,
          commissionType: commissionType,
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

    final sendMoneyCubit = context.read<SendMoneyCubit>();
    int? toCurrencyId = selectedToCurrencyId;

    if (sendMoneyCubit.state.deliveryType == DeliveryTypeEnum.inside) {
      toCurrencyId = selectedCurrencyId;
    }

    if (toCurrencyId == null) return;

    CommissionTypeEnum commissionType =
        selectedCommissionType ?? CommissionTypeEnum.none;

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
   final UserModel user = getIt<CacheServices>().getDataFromCache(boxName: CacheBoxes.userModelBox, key: 'user' ,);
    return BlocListener<GeneralCubit, GeneralState>(
      listener: (context, generalState) {
        // When branches are loaded, update destination name if we have a selected ID
        if (selectedDestinationId != null &&
            generalState.branches != null &&
            generalState.branches!.isNotEmpty &&
            destinationController.text.isEmpty) {
          // Only update if still empty
          final branch =
              _findBranchById(generalState.branches!, selectedDestinationId);
          if (branch != null) {
            setState(() {
              destinationController.text = branch.name ?? '';
            });
          }
        }
      },
      child: BlocBuilder<SendMoneyCubit, SendMoneyState>(
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
                        // controller: currencyController,
                        label: context.currency,
                        hintText: context.currenyHint,
                        initialValue:
                            context
                                .read<HomeCubit>()
                                .state
                                .currenciesList
                                .firstWhere(
                                  (c) => c.id == selectedCurrencyId,
                                  orElse: () => CurrencyModel(name: ''),
                                )
                                .name ??
                            '',
                        prefixWidget: AppAssets.svgsDollarIcon,
                        isRequired: true,
                        isReadOnly: true,
                        // onTap: () {
                        //   _showCurrencyBottomSheet(context.read<HomeCubit>().state.currenciesList);
                        // },
                        // suffixWidget: InkWell(
                        //   splashColor: Colors.transparent,
                        //   onTap: () {
                        //     _showCurrencyBottomSheet(context.read<HomeCubit>().state.currenciesList);
                        //   },
                        //   child: Icon(
                        //     Icons.keyboard_arrow_down_rounded,
                        //     color: context.colors.grayColor,
                        //   ),
                        // ),
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
                BlocBuilder<GeneralCubit, GeneralState>(
                  builder: (context, state) {
                    _syncDestinationText(state.branches ?? []);
                    return CustomTextFieldWithLabel(
                      onTap: () {
                        _showBranchBottomSheet(state.branches ?? []);
                      },
                      label: context.destination,
                      controller: destinationController,
                      hintText: context.distinctionHint,
                      prefixWidget: AppAssets.svgsBank,
                      isReadOnly: true,
                      isRequired: true,
                      validator: (value) =>
                          Validator.validateAnotherField(value, context),
                      suffixWidget: InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          _showBranchBottomSheet(state.branches ?? []);
                        },
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: context.colors.grayColor,
                        ),
                      ),
                    );
                  },
                ),
                16.verticalSizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomTextFieldWithLabel(
                        onTap: () {
                          setState(() {
                            // openCommissionTypesDropDown =
                            //     !openCommissionTypesDropDown;
                          });
                        },
                        controller: commissionController,
                        label: context.commission,
                        hintText: "\$0.00",
                        enabled: user.branch?.commissionCanChange == 1 ? true : false,
                        prefixWidget: AppAssets.svgsCoinsIcon,
                        isRequired: true,
                      ),
                    ),
                    14.horizontalSizedBox,
                    Expanded(
                      child: CustomTextFieldWithLabel(
                        onTap: () {
                          _showCommissionTypeBottomSheet();
                        },
                        controller: commissionTypeController,
                        label: context.commissionType,
                        hintText: context.commissionType,
                        prefixWidget: AppAssets.svgsCoinsIcon,
                        isRequired: true,
                        isReadOnly: true,
                        validator: (value) =>
                          Validator.validateAnotherField(value, context),
                        suffixWidget: InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            _showCommissionTypeBottomSheet();
                          },
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: context.colors.grayColor,
                          ),
                        ),
                      ),
                    ),

                    context.read<SendMoneyCubit>().state.deliveryType ==
                            DeliveryTypeEnum.outside
                        ? Column(
                            children: [
                              16.verticalSizedBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BlocBuilder<HomeCubit, HomeState>(
                                    builder: (context, state) {
                                      return Expanded(
                                        child: CustomTextFieldWithLabel(
                                          onTap: () {
                                            _showCurrencyBottomSheet(
                                              state.currenciesList,
                                              isToCurrency: true,
                                            );
                                          },
                                          controller: toCurrencyController,
                                          label: context.convertedCurrency,
                                          hintText: context.convertedCurrency,
                                          prefixWidget:
                                              AppAssets.svgsDollarIcon,
                                          isRequired: true,
                                          isReadOnly: true,
                                          suffixWidget: InkWell(
                                            splashColor: Colors.transparent,
                                            onTap: () {
                                              _showCurrencyBottomSheet(
                                                state.currenciesList,
                                                isToCurrency: true,
                                              );
                                            },
                                            child: Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color: context.colors.grayColor,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  14.horizontalSizedBox,
                                  BlocBuilder<HomeCubit, HomeState>(
                                    builder: (context, state) {
                                      return Expanded(
                                        child: CustomTextFieldWithLabel(
                                          controller: converterAmountController,
                                          label: context.convertedAmount,
                                          hintText: context.convertedAmount,
                                          prefixWidget:
                                              AppAssets.svgsDollarIcon,
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
                            ],
                          )
                        : 0.verticalSizedBox,
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
