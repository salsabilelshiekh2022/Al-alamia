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
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../core/components/widgets/payment_methods_bottom_sheet.dart';
import '../../../../../core/enums/delivery_type_enum.dart';
import '../../../../../core/general/data/models/branch_model.dart';
import '../../../../../core/general/data/models/payment_method_model.dart';
import '../../../../../core/utils/global_ui_utils.dart';
import '../../../../../generated/app_assets.dart';
import '../../../../home/data/models/currency_model.dart';
import '../../../../home/data/models/transfer_currency_request_params.dart';
import '../../../../home/presentation/cubit/home_cubit.dart';
import '../../../data/models/send_money_form_data.dart';

class ExternalTransactionDetailsCard extends StatefulWidget {
  const ExternalTransactionDetailsCard({
    required this.commissionController,
    required this.commissionTypeController,
    super.key,
  });

  final TextEditingController commissionController;
  final TextEditingController commissionTypeController;
  

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
  late TextEditingController paymentMethodController;
  late TextEditingController amountController;
  late TextEditingController amountByCharController;
  TextEditingController get commissionTypeController =>
      widget.commissionTypeController;
  TextEditingController get commissionController => widget.commissionController;
  int? selectedCurrencyId;
  int? selectedToCurrencyId;
  int? selectedDestinationId;
  int? selectedPaymentMethodId;

  BranchModel? _findBranchById(List<BranchModel?> branches, int? branchId) {
    if (branchId == null) return null;
    for (final branch in branches) {
      if (branch?.id == branchId) return branch;
    }
    return null;
  }

  PaymentMethodModel? _findPaymentMethodById(
    List<PaymentMethodModel?> paymentMethods,
    int? paymentMethodId,
  ) {
    if (paymentMethodId == null) return null;
    for (final method in paymentMethods) {
      if (method?.id == paymentMethodId) return method;
    }
    return null;
  }

  void _syncPaymentMethodText(List<PaymentMethodModel?> paymentMethods) {
    if (selectedPaymentMethodId == null) return;
    if (paymentMethodController.text.trim().isNotEmpty) return;
    if (paymentMethods.isEmpty) return;

    final method = _findPaymentMethodById(
      paymentMethods,
      selectedPaymentMethodId,
    );
    final name = method?.name.trim() ?? '';
    if (name.isEmpty) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (paymentMethodController.text.trim().isEmpty) {
        paymentMethodController.text = name;
      }
    });
  }

  void _syncToCurrencyFromFormData(SendMoneyFormData? formData) {
    final toCurrency = formData?.toCurrency;
    if (toCurrency == null) return;

    selectedToCurrencyId ??= toCurrency.id;

    final name = toCurrency.name?.trim() ?? '';
    if (name.isEmpty) return;
    if (toCurrencyController.text.trim().isNotEmpty) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (toCurrencyController.text.trim().isEmpty) {
        toCurrencyController.text = name;
      }
    });
  }

  void _syncCommissionTypeFromFormData(SendMoneyFormData? formData) {
    final commissionType = formData?.commissionType;
    if (commissionType == null) return;

    final translatedValue = commissionType.getCommissionType(context);
    if (commissionTypeController.text.trim() == translatedValue.trim()) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      commissionTypeController.text = translatedValue;
    });
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
    toCurrencyController = TextEditingController();
    converterAmountController = TextEditingController();
    paymentMethodController = TextEditingController();

    // Set default currency ID
    final user = getIt<CacheServices>().getDataFromCache(
      boxName: CacheBoxes.userModelBox,
      key: 'user',
    );
    final userCurrency = context
        .read<HomeCubit>()
        .state
        .currenciesList
        .where((currency) => currency.name == user?.currency)
        .firstOrNull;

    selectedCurrencyId = userCurrency?.id;

    selectedToCurrencyId = userCurrency?.id;
     final cubit = context.read<HomeCubit>();
    cubit.transferCurrency(
      transferCurrencyRequestParams: TransferCurrencyRequestParams(
        fromCurrencyId: selectedCurrencyId!,
        toCurrencyId: selectedToCurrencyId!,
        amount: null,
      ),
    );

    // Don't set initial payment method ID - will be set after branch selection
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Load existing form data if available (for copy feature)
    _loadExistingFormData();

    // Load branches
    context.read<GeneralCubit>().getAllBranches(
      queryParameters: {'type': "company"},
    );
    // Don't fetch payment methods initially - wait for branch selection
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
            final branch = _findBranchById(
              generalState.branches!,
              formData.toBranch,
            );
            if (branch != null) {
              destinationController.text = branch.name ?? '';
              // Also fetch payment methods for this branch
              context.read<GeneralCubit>().getPaymentMethods(
                branchId: formData.toBranch!,
              );
            }
          }
        });
      }

      // Set payment method if available
      if (formData.paymentMethodId != null) {
        setState(() {
          selectedPaymentMethodId = formData.paymentMethodId;
          // Try to set payment method name immediately if payment methods are already loaded
          final generalState = context.read<GeneralCubit>().state;
          if (generalState.paymentMethods != null &&
              generalState.paymentMethods!.isNotEmpty) {
            final paymentMethod = generalState.paymentMethods!
                .cast<PaymentMethodModel?>()
                .firstWhere(
                  (pm) => pm?.id == formData.paymentMethodId,
                  orElse: () => null,
                );
            if (paymentMethod != null && paymentMethod.name.isNotEmpty) {
              paymentMethodController.text = paymentMethod.name;
            }
          }
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
    toCurrencyController.dispose();
    converterAmountController.dispose();
    paymentMethodController.dispose();
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
     setState(() {
      toCurrencyController.text = currency.name ?? '';
      selectedToCurrencyId = currency.id;
    });
    _calculateExchangeRate();
   
    _updateFormData();
    _getFeeDetails();
  setState(() {
    
  });
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
      // Clear payment method selection when branch changes
      paymentMethodController.clear();
      selectedPaymentMethodId = null;
    });
    _updateFormData();

    // Fetch payment methods for the selected branch
    if (branch.id != null) {
      context.read<GeneralCubit>().getPaymentMethods(branchId: branch.id!);
    }
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

  void _onPaymentMethodSelected(PaymentMethodModel paymentMethod) {
    setState(() {
      paymentMethodController.text = paymentMethod.name;
      selectedPaymentMethodId = paymentMethod.id;
    });
    _updateFormData();
  }

  void _showPaymentMethodBottomSheet(
    List<PaymentMethodModel?>? paymentMethods,
  ) {
    GlobalUiUtils.showBottomSheet(
      context,
      child: PaymentMethodBottomSheet(
        paymentMethods: paymentMethods ?? [],
        selectedPaymentMethodId: selectedPaymentMethodId,
        onPaymentMethodSelected: (paymentMethod) {
          _onPaymentMethodSelected(paymentMethod);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _calculateExchangeRate() {
    if (selectedCurrencyId == null ||
        selectedToCurrencyId == null 
        )
      return;

    final amount = num.tryParse(amountController.text.trim());
   

    final cubit = context.read<HomeCubit>();
    cubit.transferCurrency(
      transferCurrencyRequestParams: TransferCurrencyRequestParams(
        fromCurrencyId: selectedCurrencyId!,
        toCurrencyId: selectedToCurrencyId!,
        amount: amount,
      ),
    );
     final homeState = context.read<HomeCubit>().state;
    final num exchangeRate = homeState.transferCurrencyStatus.isSuccess
        ? homeState.transferCurrency?.exchangePriceUsed ?? 0
        : 0;
    final result = (amount ?? 0 * exchangeRate).toStringAsFixed(2);
    converterAmountController.text = result;
  }

  void _onAmountChanged(String value) {
   
    final amountText = value.trim();
    if (amountText.isEmpty) {
      converterAmountController.text = "0.00";
      commissionController.text = "0.00";
      _updateFormData();
      context.read<GeneralCubit>().clearFeeDetails();
      return;
    }

    final homeState = context.read<HomeCubit>().state;
    final double amount = double.tryParse(amountText) ?? 0;
    final num exchangeRate = homeState.transferCurrencyStatus.isSuccess
        ? homeState.transferCurrency?.exchangePriceUsed ?? 0
        : 0;
    final result = (amount * exchangeRate).toStringAsFixed(2);
    converterAmountController.text = result;

    final commissionType = context
        .read<SendMoneyCubit>()
        .state
        .formData
        ?.commissionType;
    if (commissionType == CommissionTypeEnum.none) {
      commissionController.text = "0.00";
    } else {
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
    }

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
      final CommissionTypeEnum? commissionType = currentFormData.commissionType;

      cubit.updateFormData(
        currentFormData.copyWith(
          fromCurrency: fromCurrency,
          toCurrency: toCurrency,
          fromBranch: fromBranch,
          toBranch: toBranch,
          deliveryType: DeliveryTypeEnum
              .outside, // Assuming inside delivery for external transactions
          amount: amountController.text,
          amountByChar: amountByCharController.text,
          commissionAmount:
              double.tryParse(commissionController.text.trim()) ??
              currentFormData.commissionAmount,
          commissionType: fromCurrency != toCurrency
              ? CommissionTypeEnum.none
              : commissionType,
          paymentMethodId: paymentMethodController.text.isNotEmpty
              ? selectedPaymentMethodId
              : null,
        ),
      );
    } catch (e, stackTrace) {
      print('ERROR in _updateFormData: $e');
      print('Stack trace: $stackTrace');
    }
  }

  void _getFeeDetails() {
    final amountText = amountController.text.trim();
    if (amountText.isEmpty ||
        selectedCurrencyId == null ||
        selectedToCurrencyId == null) {
      context.read<GeneralCubit>().clearFeeDetails();
      return;
    }

    final amountValue = num.tryParse(amountText);
    if (amountValue == null || amountValue <= 0) {
      context.read<GeneralCubit>().clearFeeDetails();
      return;
    }

    final formData = context.read<SendMoneyCubit>().state.formData;
    CommissionTypeEnum commissionType =
        formData?.commissionType ?? CommissionTypeEnum.none;

    context.read<GeneralCubit>().getFeeDetails(
      params: FeeDetailsRequestParams(
        fromCurrencyId: selectedCurrencyId!,
        toCurrencyId: selectedToCurrencyId!,
        amount: amountText,
        commissionType: commissionType,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GeneralCubit, GeneralState>(
      listener: (context, generalState) {
        // When branches are loaded, update destination name if we have a selected ID
        if (selectedDestinationId != null &&
            generalState.branches != null &&
            generalState.branches!.isNotEmpty &&
            destinationController.text.isEmpty) {
          // Only update if still empty
          final branch = _findBranchById(
            generalState.branches!,
            selectedDestinationId,
          );
          if (branch != null) {
            setState(() {
              destinationController.text = branch.name ?? '';
            });
            // Fetch payment methods for this branch
            if (branch.id != null) {
              context.read<GeneralCubit>().getPaymentMethods(
                branchId: branch.id!,
              );
            }
          }
        }

        // When payment methods are loaded, update payment method name if we have a selected ID
        if (selectedPaymentMethodId != null &&
            generalState.paymentMethods != null &&
            generalState.paymentMethods!.isNotEmpty &&
            paymentMethodController.text.isEmpty) {
          // Only update if still empty
          final paymentMethod = _findPaymentMethodById(
            generalState.paymentMethods!.cast<PaymentMethodModel?>(),
            selectedPaymentMethodId,
          );
          if (paymentMethod != null && paymentMethod.name.isNotEmpty) {
            setState(() {
              paymentMethodController.text = paymentMethod.name;
            });
          }
        }
      },
      child: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          _onAmountChanged(amountController.text);
        },
        child: BlocBuilder<SendMoneyCubit, SendMoneyState>(
          builder: (context, state) {
            _syncToCurrencyFromFormData(state.formData);
            _syncCommissionTypeFromFormData(state.formData);
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
                          //   _showCurrencyBottomSheet(context.read<HomeCubit>().state.currenciesList);`
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
                  // Payment Methods Field - Only enabled when branch is selected
                  BlocBuilder<GeneralCubit, GeneralState>(
                    builder: (context, state) {
                      _syncPaymentMethodText(
                        state.paymentMethods
                                ?.cast<PaymentMethodModel?>()
                                .toList() ??
                            [],
                      );
                      final bool isBranchSelected =
                          selectedDestinationId != null;
                      final bool isLoading =
                          state.getPaymentMethodsStatus ==
                          RequestStatus.loading;
                      final bool hasError =
                          state.getPaymentMethodsStatus == RequestStatus.error;
                      final bool hasPaymentMethods =
                          state.paymentMethods != null &&
                          state.paymentMethods!.isNotEmpty;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFieldWithLabel(
                            onTap: () {
                              if (isBranchSelected &&
                                  hasPaymentMethods &&
                                  !isLoading) {
                                _showPaymentMethodBottomSheet(
                                  state.paymentMethods ?? [],
                                );
                              }
                            },
                            label: "طرق التسليم",
                            controller: paymentMethodController,
                            hintText: !isBranchSelected
                                ? "اختر الوجهة أولاً"
                                : isLoading
                                ? "جاري التحميل..."
                                : hasError
                                ? "حدث خطأ، حاول مرة أخرى"
                                : hasPaymentMethods
                                ? "اختر طريقة التسليم"
                                : "لا توجد طرق تسليم متاحة",
                            prefixWidget: AppAssets.svgsBank,
                            isReadOnly: true,
                            isRequired: true,
                            validator: (value) =>
                                Validator.validateAnotherField(value, context),
                            enabled:
                                isBranchSelected &&
                                hasPaymentMethods &&
                                !isLoading,
                            suffixWidget: isLoading
                                ? Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              context.colors.primaryColor,
                                            ),
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      if (isBranchSelected &&
                                          hasPaymentMethods &&
                                          !isLoading) {
                                        _showPaymentMethodBottomSheet(
                                          state.paymentMethods ?? [],
                                        );
                                      }
                                    },
                                    child: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color:
                                          isBranchSelected && hasPaymentMethods
                                          ? context.colors.grayColor
                                          : context.colors.grayColor
                                                .withOpacity(0.3),
                                    ),
                                  ),
                          ),
                          if (hasError && isBranchSelected)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                "فشل تحميل طرق الدفع للشركة المحددة",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  Column(
                    children: [
                      16.verticalSizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  label: context.toCurrency,
                                  hintText: context.toCurrency,
                                  prefixWidget: AppAssets.svgsDollarIcon,
                                  isRequired: true,
                                  isReadOnly: true,
                                  validator: (value) =>
                                      Validator.validateAnotherField(
                                        value,
                                        context,
                                      ),
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
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
