import 'package:alalamia/core/components/widgets/app_snack_bar.dart';
import 'package:alalamia/core/components/widgets/main_button.dart';
import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/features/transfer_money/presentation/cubit/transfer_money_cubit.dart';
import 'package:alalamia/features/transfer_money/presentation/cubit/transfer_money_state.dart';
import 'package:alalamia/features/transfer_money/presentation/views/widgets/all_denominations_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../generated/app_assets.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../../data/models/transfer_money_data_params.dart';
import '../../data/models/transfer_money_request_params.dart';

/// View for entering transfer amounts by denomination.
///
/// Displays two denomination panels:
/// - "المبلغ قبل التحويل" (Amount before transfer) - denominationsIn
/// - "المبلغ بعد التحويل" (Amount after transfer) - denominationsOut
///
/// Shows confirm button only when both amounts are complete (remaining = 0).
class AddAmountByDenominationView extends StatefulWidget {
  const AddAmountByDenominationView({super.key, required this.transferData});

  final TransferMoneyDataParams transferData;

  @override
  State<AddAmountByDenominationView> createState() =>
      _AddAmountByDenominationViewState();
}

class _AddAmountByDenominationViewState
    extends State<AddAmountByDenominationView> {
  // State for denomination lists
  List<DenominationsRequestParams> _denominationsIn = [];
  List<DenominationsRequestParams> _denominationsOut = [];

  // Track completion status for each amount
  bool _isAmountInComplete = false;
  bool _isAmountOutComplete = false;

  /// Check if both amounts are complete and ready for submission
  bool get _canSubmit => _isAmountInComplete && _isAmountOutComplete;

  /// Handle confirmation of denomination input
  void _handleConfirm() {
    if (!_canSubmit) return;

    final requestParams = TransferMoneyRequestParams(
      whatsappNumber: widget.transferData.whatsappNumber,
      clientPhone: widget.transferData.clientPhone,
      clientName: widget.transferData.clientName,
      fromCurrencyId: widget.transferData.fromCurrencyId,
      toCurrencyId: widget.transferData.toCurrencyId,
      amount: widget.transferData.amount,
      totalPrice: widget.transferData.totalPrice,
      amountByChar: widget.transferData.amountByChar,
      note: widget.transferData.note,
      denominations: _denominationsIn,
      denominationsOut: _denominationsOut,
      sendingMessageType: widget.transferData.sendingMessageType ?? 'sms',
    );

    context.read<TransferCurrencyCubit>().submitTransaction(
      transferMoneyRequestParams: requestParams,
      transactionId: widget.transferData.transactionId,
    );
  }

  /// Update denomination in status and list
  void _onAmountInStatusChanged(
    bool isComplete,
    List<DenominationsRequestParams> denominations,
  ) {
    setState(() {
      _isAmountInComplete = isComplete;
      _denominationsIn = denominations;
    });
  }

  /// Update denomination out status and list
  void _onAmountOutStatusChanged(
    bool isComplete,
    List<DenominationsRequestParams> denominations,
  ) {
    setState(() {
      _isAmountOutComplete = isComplete;
      _denominationsOut = denominations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransferCurrencyCubit, TransferMoneyState>(
      listener: _handleStateChanges,
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state.transferMoneyState.isLoading,
          child: Scaffold(
            appBar: _buildAppBar(context),
            body: _buildBody(context),
          ),
        );
      },
    );
  }

  /// Handle state changes for success/error
  void _handleStateChanges(BuildContext context, TransferMoneyState state) {
    if (state.transferMoneyState.isError) {
      AppSnackBar.showSnackBar(
        context: context,
        message: state.message ?? 'حدث خطأ',
        state: SnackBarStates.error,
      );
    } else if (state.transferMoneyState.isSuccess) {
      AppSnackBar.showSnackBar(
        context: context,
        message: state.message ?? 'تمت العملية بنجاح',
        state: SnackBarStates.success,
      );
      context.pop();
      context.pop();
      context.read<HomeCubit>().getBranchCurrencies();
    }
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "ادخل المبلغ بالفئات",
        style: context.textStyles.font18SemiBoldSecondaryColor,
      ),
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsetsDirectional.only(start: 16),
        child: InkWell(
          onTap: () => context.pop(),
          child: CustomSvgBuilder(
            path: AppAssets.svgsArrowBtnIcon,
            width: 44,
            height: 44,
            color: context.colors.secondaryColor,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final amountIn = double.tryParse(widget.transferData.amount) ?? 0;
    final amountOut = double.tryParse(widget.transferData.totalPrice) ?? 0;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Denomination In Section
          _buildSectionTitle(context, "المبلغ قبل التحويل"),
          14.verticalSizedBox,
          AllDenominationsBottomSheet(
            amount: amountIn,
            onConfirm: (_) {},
            showTitle: false,
            showConfirmButton: false,
            onAmountStatusChanged: _onAmountInStatusChanged,
          ),
          24.verticalSizedBox,

          // Denomination Out Section
          _buildSectionTitle(context, "المبلغ بعد التحويل"),
          14.verticalSizedBox,
          AllDenominationsBottomSheet(
            amount: amountOut,
            onConfirm: (_) {},
            showTitle: false,
            showConfirmButton: false,
            onAmountStatusChanged: _onAmountOutStatusChanged,
          ),
          24.verticalSizedBox,

          // Confirm Button - only visible when both amounts are complete
          if (_canSubmit) ...[
            MainButton(title: context.confirm, onTap: _handleConfirm),
            32.verticalSizedBox,
          ],
        ],
      ).allPadding(16),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(title, style: context.textStyles.font16MediumSecondaryColor);
  }
}
