import 'package:alalamia/core/components/widgets/app_snack_bar.dart';
import 'package:alalamia/core/components/widgets/custom_page.dart';
import 'package:alalamia/core/components/widgets/message_type_selection_bottom_sheet.dart';
import 'package:alalamia/core/enums/message_type_enum.dart';
import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/utils/global_ui_utils.dart';
import 'package:alalamia/features/send_money/presentation/cubit/send_money_cubit.dart';
import 'package:alalamia/features/send_money/presentation/cubit/send_money_state.dart';
import 'package:alalamia/features/send_money/presentation/views/widgets/send_money_successfully_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../core/components/widgets/main_button.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import 'widgets/fee_details_card.dart';
import 'widgets/notes_card.dart';
import 'widgets/transaction_details_card.dart';
import '../../../../features/transfer_money/presentation/views/widgets/all_denominations_bottom_sheet.dart';
import '../../../../features/transfer_money/data/models/transfer_money_request_params.dart';
import '../../../../core/general/cubit/general_cubit.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../data/models/send_money_form_data.dart';

class SendMoneySecondStepView extends StatefulWidget {
  const SendMoneySecondStepView({super.key});

  @override
  State<SendMoneySecondStepView> createState() =>
      _SendMoneySecondStepViewState();
}

class _SendMoneySecondStepViewState extends State<SendMoneySecondStepView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SendMoneyCubit, SendMoneyState>(
      listener: (context, state) {
        if (state.sendMoneyStatus.isSuccess) {
          context.pop();
          context.pop();
                    context.read<HomeCubit>().getBranchCurrencies();

          GlobalUiUtils.showCustomDialog(
            context,
            child: SendMoneySuccessfullyDialog(),
          );

        } else if (state.sendMoneyStatus.isError) {
          AppSnackBar.showSnackBar(
            context: context,
            message: state.message ?? 'An error occurred',
            state: SnackBarStates.error,
          );
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: context.watch<SendMoneyCubit>().state.sendMoneyStatus.isLoading,
        child: CustomPage(
          title: context.sendMoney,
          hasActions: false,
          isBack: true,
          body: Column(
            children: [
              _stepHeader(context),
              12.verticalSizedBox,
              _progressBar(context),
              24.verticalSizedBox,
              TransactionDetailsCard(),
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
                        ? (){}
                        : () => _handleConfirm(context),
                  );
                },
              ),
              32.verticalSizedBox,
            ],
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
        message: 'Please fill all required fields',
        state: SnackBarStates.error,
      );
      return;
    }

    // Check specific requirements and show detailed error
    final missingFields = <String>[];
    
    if (!formData.hasSenderInfo) missingFields.add('Sender information');
    if (!formData.hasReceiverInfo) missingFields.add('Receiver information');
    if (!formData.hasAmountDetails) missingFields.add('Amount and currency');
    if (!formData.hasBranches) missingFields.add('Branch information');
    if (!formData.hasCommissionDetails) missingFields.add('Commission type');
    if (!formData.hasPaymentMethod) missingFields.add('Payment method');
    
    // Note: We don't check hasDenominations here because we are about to collect them

    if (missingFields.isNotEmpty) {
      AppSnackBar.showSnackBar(
        context: context,
        message: 'Missing: ${missingFields.join(', ')}',
        state: SnackBarStates.error,
      );
      return;
    }

    final amount = double.tryParse(formData.amount);
    if (amount == null || amount <= 0) {
      AppSnackBar.showSnackBar(
        context: context,
        message: "Please enter a valid amount",
        state: SnackBarStates.error,
      );
      return;
    }

    // Show message type selection bottom sheet
    final selectedMessageType = await showModalBottomSheet<MessageTypeEnum>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const MessageTypeSelectionBottomSheet(),
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
          amount: amount,
          onConfirm: (denominations) {
            _sendRequestWithDenominations(context, cubit, updatedFormData, denominations);
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
      final denominationsMap = denominations.map((d) => {
        'id': d.id,
        'quantity': d.quantity,
      }).toList();

      // Update form data with denominations
      final updatedFormData = formData.copyWith(denominations: denominationsMap);
      
      // Update cubit state
      cubit.updateFormData(updatedFormData);

      // Convert form data to request params and send
      final requestParams = updatedFormData.toRequestParams();
      cubit.sendMoney(sendMoneyRequestParams: requestParams);
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

