import 'package:alalamia/core/components/widgets/custom_modal_hub.dart';
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

  /// Handle copying transaction data and navigating to appropriate screen
  void _handleCopyTransaction(
    BuildContext context,
    TransactionDetailsModel transaction,
  ) {
    final transactionType = TransactionCopyService.getTransactionType(
      transaction,
    );
    final isExternal = TransactionCopyService.isExternalDelivery(transaction);

    // Navigate based on transaction type
    if (transactionType == 'transfering') {
      // Map to transfer money data
      final transferData = TransactionCopyService.mapToTransferMoneyData(
        transaction,
      );

      if (transferData == null) {
        AppSnackBar.showSnackBar(
          context: context,
          message: 'Failed to copy transaction data',
          state: SnackBarStates.error,
        );
        return;
      }

      // Navigate to transfer money screen
      context.pushNamed(Routes.transferCurrencyView, arguments: transferData);

      // Show success feedback
      AppSnackBar.showSnackBar(
        context: context,
        message: 'Transaction data copied successfully',
        state: SnackBarStates.success,
      );
    } else if (transactionType == 'sending') {
      // Map to send money form data
      final formData = TransactionCopyService.mapToSendMoneyFormData(
        transaction,
      );

      if (formData == null) {
        AppSnackBar.showSnackBar(
          context: context,
          message: 'Failed to copy transaction data',
          state: SnackBarStates.error,
        );
        return;
      }

      // Get or create SendMoneyCubit with initial data
      final sendMoneyCubit = getIt<SendMoneyCubit>();
      sendMoneyCubit.updateFormData(formData);

      // Navigate to send money first step with the appropriate delivery type
      context.pushNamed(
        Routes.sendMoneyFristStepView,
        arguments: {
          'deliveryType': isExternal
              ? DeliveryTypeEnum.outside
              : DeliveryTypeEnum.inside,
          'cubit': sendMoneyCubit,
          'initialData': formData,
        },
      );

      // Show success feedback
      AppSnackBar.showSnackBar(
        context: context,
        message: 'Transaction data copied successfully',
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

  @override
  Widget build(BuildContext context) {
    return CustomModelProgressIndecator(
      inAsyncCall: context
          .watch<TransactionsCubit>()
          .state
          .updateTransactionRequestStatus
          .isLoading,
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
                                  SenderInfoCard(),
                                  20.verticalSizedBox,
                                  BeneficiaryInfoCard(),
                                  20.verticalSizedBox,
                                  TransactionInfoCard(),
                                  32.verticalSizedBox,
                                  context
                                                  .read<TransactionsCubit>()
                                                  .state
                                                  .transactionDetails
                                                  ?.recievingBranch ==
                                              true &&
                                          context
                                                  .read<TransactionsCubit>()
                                                  .state
                                                  .transactionDetails
                                                  ?.details
                                                  .status ==
                                              StatusEnum.pending
                                      ? recivingButton()
                                      : MainButton(
                                          title: context.printReceipt,
                                          onTap: () => _launchUrl(
                                            state.transactionDetails?.pdfUrl ??
                                                '',
                                          ),
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
                                    state.transactionDetails?.details.status ??
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
                          ?.amountSent ??
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
