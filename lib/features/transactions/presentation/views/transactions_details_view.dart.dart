import 'package:alalamia/core/components/widgets/custom_modal_hub.dart';
import 'package:alalamia/core/components/widgets/custom_svg_builder.dart';
import 'package:alalamia/core/components/widgets/main_button.dart';
import 'package:alalamia/core/enums/delivery_type_enum.dart';
import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/core/enums/update_transaction_state_enum.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/core/routes/routes.dart';
import 'package:alalamia/core/services/transaction_copy_service.dart';
import 'package:alalamia/features/send_money/presentation/cubit/send_money_cubit.dart';
import 'package:alalamia/features/home/data/models/currency_model.dart';
import 'package:alalamia/features/home/presentation/cubit/home_cubit.dart';
import 'package:alalamia/features/send_money/presentation/views/widgets/notes_card.dart';
import 'package:alalamia/features/transactions/data/models/transaction_details_model.dart';
import 'package:alalamia/features/transactions/data/models/update_transaction_request_params.dart';
import 'package:alalamia/features/transactions/presentation/cubit/transactions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/components/widgets/app_snack_bar.dart';
import '../../../../core/components/widgets/custom_app_bar.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/enums/status_enum.dart';
import '../../../../core/enums/transactions_enum.dart';
import '../../../../core/general/cubit/general_cubit.dart';
import '../../../../core/utils/global_ui_utils.dart';
import '../../../../generated/app_assets.dart';
import '../../../transfer_money/data/models/transfer_money_request_params.dart';
import '../../../transfer_money/presentation/views/widgets/all_denominations_bottom_sheet.dart';
import '../cubit/transactions_state.dart';
import 'widgets/transactions_details/beneficiary_info_card.dart';
import 'widgets/transactions_details/notes_info_card.dart';
import 'widgets/transactions_details/sender_info_card.dart';
import 'widgets/transactions_details/status_box.dart';
import 'widgets/transactions_details/transaction_info.dart';
import 'widgets/transactions_details/transefered_info_widget.dart';

class TransactionsDetailsView extends StatefulWidget {
  const TransactionsDetailsView(this.id, {super.key});
  final int id;

  @override
  State<TransactionsDetailsView> createState() =>
      _TransactionsDetailsViewState();
}

class _TransactionsDetailsViewState extends State<TransactionsDetailsView> {
  @override
  void initState() {
    context.read<TransactionsCubit>().showTransactionDetails(
      transactionId: widget.id.toString(),
    );
    super.initState();
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  void _onDenominationsConfirmed(
    List<DenominationsRequestParams> denominations,
  ) {
    final UpdateTransactionRequestParams updateTransactionRequestParams =
        UpdateTransactionRequestParams(
          status: UpdateTransactionStatusEnum.recieved,
          denominations: denominations,
        );
    context.read<TransactionsCubit>().updateTransactionStatus(
      transactionId: widget.id,
      params: updateTransactionRequestParams,
    );
  }

  CurrencyModel? _matchCurrencyByName(
    List<CurrencyModel> currencies,
    String name,
  ) {
    final normalized = name.trim();
    if (normalized.isEmpty) return null;

    for (final currency in currencies) {
      final currencyName = (currency.name ?? '').trim();
      if (currencyName.isEmpty) continue;
      if (currencyName == normalized) return currency;
    }

    return null;
  }

  bool _isTransferType(String transactionType) {
    final normalizedType = transactionType.trim().toLowerCase();
    return normalizedType == 'transfering' || normalizedType == 'transferring';
  }

  bool _canEditTransaction(TransactionDetailsModel transaction) {
    const editableStatuses = {
     
      StatusEnum.in_progress,
      
    };

    final status = transaction.details?.status;
    final transactionType = transaction.details?.transactionType;

    final isEditableType =
        transactionType?.trim().toLowerCase() == 'sending' ||
        _isTransferType(transactionType ?? '');

    return isEditableType && editableStatuses.contains(status) && transaction.recievingBranch != true;
  }

  bool _canCancelTransaction(TransactionDetailsModel transaction) {
    return _canEditTransaction(transaction);
  }

  bool _canPayBackTransaction(TransactionDetailsModel transaction) {
    return transaction.details?.status == StatusEnum.pending && transaction.recievingBranch != true;
  }

  Future<void> _showConfirmationBottomSheet(
    BuildContext context, {
    required String title,
    required String body,
    required VoidCallback onConfirm,
  }) async {
    await GlobalUiUtils.showBottomSheet(
      context,
      child: _buildConfirmationBottomSheet(
        context,
        title: title,
        body: body,
        onConfirm: onConfirm,
      ),
    );
  }

  Future<void> _showCancelConfirmation(BuildContext context) async {
    await _showConfirmationBottomSheet(
      context,
      title: context.cancelTransactionTitle,
      body: context.cancelTransactionBody,
      onConfirm: () {
        context.read<TransactionsCubit>().cancelTransaction(
              transactionId: widget.id,
            );
      },
    );
  }

  Future<void> _showPayBackConfirmation(BuildContext context) async {
    await _showConfirmationBottomSheet(
      context,
      title: context.payBackTransactionTitle,
      body: context.payBackTransactionBody,
      onConfirm: () {
        context.read<TransactionsCubit>().payBackTransaction(
              transactionId: widget.id.toString(),
            );
      },
    );
  }

  Widget _buildConfirmationBottomSheet(
    BuildContext context, {
    required String title,
    required String body,
    required VoidCallback onConfirm,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 70.w,
          height: 70.w,
          decoration: BoxDecoration(
            color: context.colors.redColor.withValues(alpha: 0.08),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: CustomSvgBuilder(
              path: AppAssets.svgsCancelled,
              width: 36.w,
              height: 36.w,
              color: context.colors.redColor,
            ),
          ),
        ),
        16.verticalSizedBox,
        Text(
          title,
          style: context.textStyles.font18SemiBoldSecondaryColor,
          textAlign: TextAlign.center,
        ),
        8.verticalSizedBox,
        Text(
          body,
          style: context.textStyles.font15RegularGrayColor,
          textAlign: TextAlign.center,
        ),
        24.verticalSizedBox,
        Row(
          children: [
            Expanded(
              child: MainButton(
                title: context.confirm,
                color: context.colors.redColor,
                onTap: () {
                  Navigator.of(context).pop();
                  onConfirm();
                },
              ),
            ),
            10.horizontalSpace,
            Expanded(
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.w),
                  decoration: BoxDecoration(
                    color: context.colors.whiteColor,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: context.colors.primaryColor,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      context.cancle,
                      style: context.textStyles.font16RegularSecondaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _openTransactionForm(
    BuildContext context,
    TransactionDetailsModel transaction, {
    required bool isEdit,
  }) {
    final transactionType = TransactionCopyService.getTransactionType(
      transaction,
    );
    final normalizedType = transactionType.trim().toLowerCase();
    final isExternal = TransactionCopyService.isExternalDelivery(transaction);
    final transactionId = isEdit ? widget.id : null;
    final successMessage = isEdit
        ? 'Transaction loaded for editing'
        : 'Transaction data copied successfully';
    final failedMessage = isEdit
        ? 'Failed to load transaction data for editing'
        : 'Failed to copy transaction data';

    // Navigate based on transaction type
    if (_isTransferType(normalizedType)) {
      // Map to transfer money data
      final transferData = TransactionCopyService.mapToTransferMoneyData(
        transaction,
        transactionId: transactionId,
        preserveNote: isEdit,
      );

      if (transferData == null) {
        AppSnackBar.showSnackBar(
          context: context,
          message: failedMessage,
          state: SnackBarStates.error,
        );
        return;
      }

      final currencies = getIt<HomeCubit>().state.currenciesList;
      final fromCurrency = _matchCurrencyByName(
        currencies,
        TransactionCopyService.getFromCurrencyName(transaction),
      );
      final toCurrency = _matchCurrencyByName(
        currencies,
        TransactionCopyService.getToCurrencyName(transaction),
      );

      final enrichedTransferData = transferData.copyWith(
        fromCurrencyId: fromCurrency?.id ?? transferData.fromCurrencyId,
        toCurrencyId: toCurrency?.id ?? transferData.toCurrencyId,
      );

      // Navigate to transfer money screen
      context.pushNamed(
        Routes.transferCurrencyView,
        arguments: enrichedTransferData,
      );

      // Show success feedback
      AppSnackBar.showSnackBar(
        context: context,
        message: successMessage,
        state: SnackBarStates.success,
      );
    } else if (normalizedType == 'sending') {
      // Map to send money form data
      final formData = TransactionCopyService.mapToSendMoneyFormData(
        transaction,
        transactionId: transactionId,
        preserveNote: isEdit,
      );

      if (formData == null) {
        AppSnackBar.showSnackBar(
          context: context,
          message: failedMessage,
          state: SnackBarStates.error,
        );
        return;
      }

      final currencies = getIt<HomeCubit>().state.currenciesList;
      final fromCurrency = _matchCurrencyByName(
        currencies,
        TransactionCopyService.getFromCurrencyName(transaction),
      );
      final toCurrency = _matchCurrencyByName(
        currencies,
        TransactionCopyService.getToCurrencyName(transaction),
      );

      final enrichedFormData = formData.copyWith(
        fromCurrency: fromCurrency,
        toCurrency: toCurrency,
      );

      // Get or create SendMoneyCubit with initial data
      final sendMoneyCubit = getIt<SendMoneyCubit>();
      sendMoneyCubit.updateFormData(enrichedFormData);

      // Navigate to send money first step with the appropriate delivery type
      context.pushNamed(
        Routes.sendMoneyFristStepView,
        arguments: {
          'deliveryType': isExternal
              ? DeliveryTypeEnum.outside
              : DeliveryTypeEnum.inside,
          'cubit': sendMoneyCubit,
          'initialData': enrichedFormData,
          'transactionId': transactionId,
        },
      );

      // Show success feedback
      AppSnackBar.showSnackBar(
        context: context,
        message: successMessage,
        state: SnackBarStates.success,
      );
    } else {
      // Unknown transaction type
      AppSnackBar.showSnackBar(
        context: context,
        message: 'Cannot copy this transaction type',
        state: SnackBarStates.error,
      );
    }
  }

  /// Handle copying transaction data and navigating to appropriate screen.
  void _handleCopyTransaction(
    BuildContext context,
    TransactionDetailsModel transaction,
  ) {
    _openTransactionForm(context, transaction, isEdit: false);
  }

  /// Handle editing transaction data and navigating to appropriate screen.
  void _handleEditTransaction(
    BuildContext context,
    TransactionDetailsModel transaction,
  ) {
    _openTransactionForm(context, transaction, isEdit: true);
  }

  @override
  Widget build(BuildContext context) {
    final transactionsState = context.watch<TransactionsCubit>().state;
    return CustomModelProgressIndecator(
      inAsyncCall:
          transactionsState.updateTransactionRequestStatus.isLoading ||
          transactionsState.cancelTransactionStatus.isLoading ||
          transactionsState.payBackTransactionStatus.isLoading,
      child: BlocListener<TransactionsCubit, TransactionsState>(
        listenWhen: (previous, current) =>
            previous.cancelTransactionStatus !=
            current.cancelTransactionStatus,
        listener: (context, state) {
          if (state.cancelTransactionStatus.isSuccess) {
            context.read<TransactionsCubit>().showTransactionDetails(
                  transactionId: widget.id.toString(),
                );
            context.read<TransactionsCubit>().refreshTransactions();
            AppSnackBar.showSnackBar(
              context: context,
              message: state.message ?? 'Transaction canceled successfully',
              state: SnackBarStates.success,
            );
          } else if (state.cancelTransactionStatus.isError) {
            AppSnackBar.showSnackBar(
              context: context,
              message: state.message ?? 'Failed to cancel transaction',
              state: SnackBarStates.error,
            );
          }
        },
        child: BlocListener<TransactionsCubit, TransactionsState>(
          listenWhen: (previous, current) =>
              previous.payBackTransactionStatus !=
              current.payBackTransactionStatus,
          listener: (context, state) {
            if (state.payBackTransactionStatus.isSuccess) {
              context.read<TransactionsCubit>().showTransactionDetails(
                    transactionId: widget.id.toString(),
                  );
              context.read<TransactionsCubit>().refreshTransactions();
              AppSnackBar.showSnackBar(
                context: context,
                message: state.message ?? context.success,
                state: SnackBarStates.success,
              );
            } else if (state.payBackTransactionStatus.isError) {
              AppSnackBar.showSnackBar(
                context: context,
                message: state.message ?? context.failed,
                state: SnackBarStates.error,
              );
            }
          },
          child: PopScope(
            canPop: true,
            onPopInvokedWithResult: (bool didPop, dynamic result) {
              if (!didPop) return;
              context.read<TransactionsCubit>().refreshTransactions();
            },
            child: Scaffold(
              body: Stack(
                children: [
                  Image.asset(
                    AppAssets.imagesBackground,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SingleChildScrollView(
                    child: BlocBuilder<TransactionsCubit, TransactionsState>(
                      builder: (context, state) {
                        final transaction = state.transactionDetails;
                        final canCancel = transaction != null &&
                            _canCancelTransaction(transaction);
                        final canPayBack = transaction != null &&
                            _canPayBackTransaction(transaction);
                        final showReceivingButton =
                            transaction?.recievingBranch == true &&
                            transaction?.details?.status == StatusEnum.in_progress;
            
                        return Column(
                          children: [
                        // Custom AppBar with Copy button
                        AppBar(
                          title: Text(
                            context.transactions,
                            style: context.textStyles.font18SemiBoldWhiteColor,
                          ),
                          leading: const CustomBackButton(),
                          actions: [
                            if (state.transactionDetails != null &&
                                _canEditTransaction(state.transactionDetails!))
                              IconButton(
                                icon: const Icon(
                                  Icons.edit_rounded,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                onPressed: () => _handleEditTransaction(
                                  context,
                                  state.transactionDetails!,
                                ),
                              ),
                            if (state.transactionDetails != null)
                              IconButton(
                                icon: const Icon(
                                  Icons.copy_rounded,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                onPressed: () => _handleCopyTransaction(
                                  context,
                                  state.transactionDetails!,
                                ),
                              ),
                          ],
                          centerTitle: true,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ).onlyPadding(bottomPadding: 24),
            
                        Skeletonizer(
                          enabled:
                              state.transactionDetailsStatus ==
                              RequestStatus.loading,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 25),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 35,
                                ),
                                width: double.infinity,
                                constraints: BoxConstraints(
                                  minHeight:
                                      MediaQuery.of(context).size.height - 130.h,
                                ),
                                decoration: BoxDecoration(
                                  color: context.colors.backgroundColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    topRight: Radius.circular(24),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    25.verticalSizedBox,
                                    TransferredAmountInfoWidget(),
                                    20.verticalSizedBox,
                              context.read<TransactionsCubit>().state.transactionDetails?.sender != null ?    SenderInfoCard().onlyPadding(bottomPadding: 20) : SizedBox(),
                             context.read<TransactionsCubit>().state.transactionDetails?.receiver != null ?        BeneficiaryInfoCard().onlyPadding(bottomPadding: 20) : SizedBox(),
                             context.read<TransactionsCubit>().state.transactionDetails?.notes != null ?        NotesInfoCard().onlyPadding(bottomPadding: 20) : SizedBox(),
                                    TransactionInfoCard(),
                                    32.verticalSizedBox,
                                    Column(
                                      children: [
                                        showReceivingButton
                                            ? recivingButton()
                                            : MainButton(
                                                title: context.printReceipt,
                                                onTap: () => _launchUrl(
                                                  state.transactionDetails?.pdfUrl ??
                                                      '',
                                                ),
                                              ),
                                        if (canCancel) ...[
                                          12.verticalSizedBox,
                                          MainButton(
                                            title: context.cancle,
                                            color: context.colors.redColor,
                                            onTap: () =>
                                                _showCancelConfirmation(context),
                                          ),
                                        ],
                                        if (canPayBack) ...[
                                          12.verticalSizedBox,
                                          MainButton(
                                            title: context.payBackTransactionLabel,
                                            color: context.colors.redColor,
                                            onTap: () =>
                                                _showPayBackConfirmation(context),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              PositionedDirectional(
                                top: -10,
                                start: 16,
                                end: 16,
                                child: StatusBox(
                                  status:
                                      state.transactionDetails?.details?.status ??
                                      StatusEnum.pending,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget recivingButton() {
    return BlocListener<TransactionsCubit, TransactionsState>(
      listenWhen: (previous, current) =>
          previous.updateTransactionRequestStatus !=
          current.updateTransactionRequestStatus,
      listener: (context, state) {
        if (state.updateTransactionRequestStatus.isSuccess) {
          context.read<TransactionsCubit>().getTransactionList(
            transaction: TransactionsEnum.recieving,
          );
          context.pop();
          AppSnackBar.showSnackBar(
            context: context,
            message: state.message ?? 'تمت العملية بنجاح',
            state: SnackBarStates.success,
          );
        }
      },
      child: MainButton(
        title: context.receivedDone,
        onTap: () {
          GlobalUiUtils.showBottomSheet(
            context,
            child: BlocProvider.value(
              value: getIt<GeneralCubit>(),
              child: AllDenominationsBottomSheet(
                amount: double.parse(
                  context
                          .read<TransactionsCubit>()
                          .state
                          .transactionDetails
                          ?.amount ??
                      '0',
                ).toInt(),
                onConfirm: _onDenominationsConfirmed,
              ),
            ),
          );
        },
      ),
    );
  }
}
