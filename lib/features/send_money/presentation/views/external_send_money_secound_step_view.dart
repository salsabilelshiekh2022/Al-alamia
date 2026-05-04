import 'package:alalamia/core/components/widgets/message_type_selection_bottom_sheet.dart';
import 'package:alalamia/core/enums/message_type_enum.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/features/home/presentation/cubit/home_state.dart';
import 'package:alalamia/features/send_money/presentation/views/widgets/external_transaction_details_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../core/components/widgets/app_snack_bar.dart';
import '../../../../core/components/widgets/custom_page.dart';
import '../../../../core/components/widgets/main_button.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/enums/request_status.dart';
import '../../../../core/general/cubit/general_cubit.dart';
import '../../../../core/helper/app_extention.dart';
import '../../../../core/helper/number_extentions.dart';
import '../../../../core/helper/translation_extensions.dart';
import '../../../../core/utils/global_ui_utils.dart';
import '../../../../core/utils/validator.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../../../transfer_money/data/models/transfer_money_request_params.dart';
import '../../../transfer_money/presentation/views/widgets/all_denominations_bottom_sheet.dart';
import '../../../transfer_money/presentation/views/widgets/total_section.dart';
import '../../data/models/send_money_form_data.dart';
import '../cubit/send_money_cubit.dart';
import '../cubit/send_money_state.dart';
import 'widgets/commition_card.dart';
import 'widgets/fee_details_card.dart';
import 'widgets/notes_card.dart';
import 'widgets/send_money_successfully_dialog.dart';

class ExternalSendMoneySecoundStepView extends StatefulWidget {
  const ExternalSendMoneySecoundStepView({super.key});

  @override
  State<ExternalSendMoneySecoundStepView> createState() =>
      _ExternalSendMoneySecoundStepViewState();
}

class _ExternalSendMoneySecoundStepViewState
    extends State<ExternalSendMoneySecoundStepView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _commissionController = TextEditingController();
  final TextEditingController _commissionTypeController =
      TextEditingController();

  @override
  void dispose() {
    _commissionController.dispose();
    _commissionTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var formData = context.watch<SendMoneyCubit>().state.formData;
    return BlocListener<SendMoneyCubit, SendMoneyState>(
      listener: (context, state) {
        if (state.sendMoneyStatus.isSuccess) {
          final isEditMode = state.formData?.transactionId != null;
          context.pop();
          context.pop();
          context.read<HomeCubit>().getBranchCurrencies();

          if (isEditMode) {
            AppSnackBar.showSnackBar(
              context: context,
              message: state.message ?? 'Transaction updated successfully',
              state: SnackBarStates.success,
            );
          } else {
            GlobalUiUtils.showCustomDialog(
              context,
              child: SendMoneySuccessfullyDialog(),
            );
          }
        } else if (state.sendMoneyStatus.isError) {
          AppSnackBar.showSnackBar(
            context: context,
            message: state.message ?? 'An error occurred',
            state: SnackBarStates.error,
          );
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: context
            .watch<SendMoneyCubit>()
            .state
            .sendMoneyStatus
            .isLoading,
        child: CustomPage(
          title: context.sendMoney,
          hasActions: false,
          isBack: true,
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                _stepHeader(context),
                12.verticalSizedBox,
                _progressBar(context),
                24.verticalSizedBox,
                ExternalTransactionDetailsCard(
                  commissionController: _commissionController,
                  commissionTypeController: _commissionTypeController,
                ),
                formData?.fromCurrency == null || formData?.toCurrency == null
                    ? SizedBox()
                    : formData?.fromCurrency == formData?.toCurrency
                    ? CommitionCard(
                        commissionController: _commissionController,
                        commissionTypeController: _commissionTypeController,
                      )
                    : TotalSection(
                        fromCurrency: formData!.fromCurrency!,
                        toCurrency: formData.toCurrency!,
                        total: formData.amount,
                        exchangePrice: 0.0,
                      ).onlyPadding(topPadding: 8),
                20.verticalSizedBox,
                NotesCard(),
                20.verticalSizedBox,
                FeeDetailsCard(),
                24.verticalSizedBox,
                BlocBuilder<SendMoneyCubit, SendMoneyState>(
                  builder: (context, state) {
                    return MainButton(
                      title: context.confirm,
                      // isLoading: state.sendMoneyStatus.isLoading,
                      onTap: state.sendMoneyStatus.isLoading
                          ? () {}
                          : () => _handleConfirm(context),
                    );
                  },
                ),
                32.verticalSizedBox,
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Handle confirm button tap - collect data and send request
  void _handleConfirm(BuildContext context) async {
    final cubit = context.read<SendMoneyCubit>();
    final formData = cubit.state.formData;

    // Validate that we have all required data
    if (formData == null) {
      AppSnackBar.showSnackBar(
        context: context,
        message: 'يرجى ملء جميع البيانات المطلوبة ',
        state: SnackBarStates.error,
      );
      return;
    }

    // Check specific requirements and show detailed error
    final missingFields = <String>[];

    if (!formData.hasSenderInfo) missingFields.add('بيانات المرسل');
    if (!formData.hasReceiverInfo) missingFields.add('بيانات المستفيد');
    if (!formData.hasAmountDetails) missingFields.add('المبلغ والعملة');
    if (!formData.hasBranches) missingFields.add('بيانات الفرع');
    if (!formData.hasCommissionDetails) missingFields.add('نوع العمولة');
    if (!formData.hasPaymentMethod) missingFields.add('طريقة الدفع');

    // Note: We don't check hasDenominations here because we are about to collect them

    if (missingFields.isNotEmpty) {
      !_formKey.currentState!.validate();
      AppSnackBar.showSnackBar(
        context: context,
        message: 'يرجى ملء ${missingFields.join(', ')}',
        state: SnackBarStates.error,
      );
      return;
    }

    final amount = double.tryParse(formData.amount);
    if (amount == null || amount <= 0) {
      AppSnackBar.showSnackBar(
        context: context,
        message: "يرجى إدخال مبلغ صحيح",
        state: SnackBarStates.error,
      );
      return;
    }
    
    if (context.read<HomeCubit>().state.transferCurrencyStatus.isError) {
       AppSnackBar.showSnackBar(
        context: context,
        message:"يرجى اختيار عملتين بينهم سعر صرف",
        state: SnackBarStates.error,
      );
      return;
    }

    // Show message type selection bottom sheet
    final senderWhatsApp = formData.senderWhatsApp.trim();
    final receiverWhatsApp = formData.receiverWhatsApp.trim();
    final senderHasValidWhatsApp = senderWhatsApp.isNotEmpty &&
        Validator.validatePhone(senderWhatsApp, context) == null;
    final receiverHasValidWhatsApp = receiverWhatsApp.isNotEmpty &&
        Validator.validatePhone(receiverWhatsApp, context) == null;
    final allowWhatsApp = senderHasValidWhatsApp || receiverHasValidWhatsApp;

    final selectedMessageType = await showModalBottomSheet<MessageTypeEnum>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => MessageTypeSelectionBottomSheet(
        allowWhatsApp: allowWhatsApp,
      ),
    );

    // If user cancelled, do not proceed
    if (selectedMessageType == null) {
      return;
    }

    // Update form data with selected message type
    final updatedFormData = formData.copyWith(
      sendingMessageType: selectedMessageType.apiValue,
    );
    cubit.updateFormData(updatedFormData);

    // Show bottom sheet to collect denominations
    GlobalUiUtils.showBottomSheet(
      context,
      child: BlocProvider.value(
        value: getIt<GeneralCubit>(),
        child: AllDenominationsBottomSheet(
          amount:
              context.read<GeneralCubit>().state.feeDetails?.finalAmount ??
              amount,
          onConfirm: (denominations) {
            _sendRequestWithDenominations(
              context,
              cubit,
              updatedFormData,
              denominations,
            );
          },
        ),
      ),
    );
  }

  void _sendRequestWithDenominations(
    BuildContext context,
    SendMoneyCubit cubit,
    SendMoneyFormData formData,
    List<DenominationsRequestParams> denominations,
  ) {
    try {
      // Map denominations to the format expected by SendMoneyFormData
      final denominationsMap = denominations
          .map((d) => {'id': d.id, 'quantity': d.quantity})
          .toList();

      // Update form data with denominations
      final updatedFormData = formData.copyWith(
        denominations: denominationsMap,
      );

      // Update cubit state
      cubit.updateFormData(updatedFormData);

      // Convert form data to request params and send
      final requestParams = updatedFormData.toRequestParams();
      cubit.submitTransaction(
        sendMoneyRequestParams: requestParams,
        transactionId: updatedFormData.transactionId,
      );
    } catch (e) {
      AppSnackBar.showSnackBar(
        context: context,
        message: 'Error preparing request: ${e.toString()}',
        state: SnackBarStates.error,
      );
    }
  }

  Widget _progressBar(BuildContext context) {
    return Container(
      height: 10,
      width: context.width,
      decoration: BoxDecoration(
        borderRadius: 24.allBorderRadius,
        gradient: context.colors.navigationGradientColor,
      ),
    );
  }

  Row _stepHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "2 ${context.from} 2",
          style: context.textStyles.font14SemiBoldPrimaryColor.copyWith(
            color: Color(0xff3E1A74).withValues(alpha: 0.8),
          ),
        ),
        Text(
          context.transactionDetails,
          style: context.textStyles.font14SemiBoldPrimaryColor.copyWith(
            color: Color(0xff3E1A74).withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}
