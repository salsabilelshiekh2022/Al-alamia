import 'package:alalamia/core/components/widgets/main_button.dart';
import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/core/general/cubit/general_cubit.dart';
import 'package:alalamia/core/general/cubit/general_state.dart';
import 'package:alalamia/core/general/data/models/denomination_model.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/features/transfer_money/data/models/transfer_money_request_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'denomination_item.dart';

class AllDenominationsBottomSheet extends StatefulWidget {
  const AllDenominationsBottomSheet({
    required this.amount,
    required this.onConfirm,
    super.key,
    this.showTitle = true,
    this.showConfirmButton = true,
    this.onAmountStatusChanged,
  });

  final num amount;
  final Function(List<DenominationsRequestParams> denominations) onConfirm;
  final bool showTitle;
  final bool showConfirmButton;

  /// Callback triggered when the amount completion status changes.
  /// Returns true when remaining amount equals 0, false otherwise.
  final void Function(
    bool isComplete,
    List<DenominationsRequestParams> denominations,
  )?
  onAmountStatusChanged;

  @override
  State<AllDenominationsBottomSheet> createState() =>
      _AllDenominationsBottomSheetState();
}

class _AllDenominationsBottomSheetState
    extends State<AllDenominationsBottomSheet> {
  late num remainingAmount;
  late TextEditingController amountController;
  final Map<int, int> _denominationQuantities = {};

  @override
  void initState() {
    super.initState();
    remainingAmount = widget.amount;
    amountController = TextEditingController(
      text: _formatAmount(remainingAmount),
    );
    context.read<GeneralCubit>().getAllDenominations();
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  String _formatAmount(num amount) {
    return amount.toStringAsFixed(2);
  }

  void _handleQuantityChanged(
    int denominationId,
    num denominationValue,
    int newQuantity,
  ) {
    setState(() {
      final oldQuantity = _denominationQuantities[denominationId] ?? 0;
      final quantityDifference = newQuantity - oldQuantity;

      // Update remaining amount based on the difference
      remainingAmount -= (denominationValue * quantityDifference);

      // Fix floating point issues for currency calculations
      remainingAmount = double.parse(remainingAmount.toStringAsFixed(2));
      amountController.text = _formatAmount(remainingAmount);

      // Update the quantity
      if (newQuantity > 0) {
        _denominationQuantities[denominationId] = newQuantity;
      } else {
        _denominationQuantities.remove(denominationId);
      }
    });

    // Notify parent about amount status change
    widget.onAmountStatusChanged?.call(
      _isAmountComplete,
      _buildDenominationsList(),
    );
  }

  int _calculateMaxQuantity(num denominationValue) {
    if (denominationValue <= 0) return 0;
    return (remainingAmount / denominationValue).floor();
  }

  List<DenominationsRequestParams> _buildDenominationsList() {
    return _denominationQuantities.entries
        .map(
          (entry) =>
              DenominationsRequestParams(id: entry.key, quantity: entry.value),
        )
        .toList();
  }

  bool get _isAmountComplete => remainingAmount == 0;

  void _handleConfirm() {
    if (_isAmountComplete) {
      final denominations = _buildDenominationsList();
      widget.onConfirm(denominations);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom +40;
    final screenHeight = MediaQuery.of(context).size.height;
    final availableHeight = screenHeight - keyboardHeight;
    
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: availableHeight * 0.9,
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: keyboardHeight > 0 ? 16 : 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.showTitle) ...[
              Text(
                context.enterAmountByDenominations,
                style: context.textStyles.font17SemiBoldSecondaryColor,
              ),
              20.verticalSizedBox,
            ],
            _buildRemainingAmountCard(context),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    16.verticalSizedBox,
                    BlocBuilder<GeneralCubit, GeneralState>(
                      builder: (context, state) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 4,
                            mainAxisExtent: 50,
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.denominations?.length?? 6,
                          itemBuilder: (context, index) {
                            final denomination = state.denominations?[index];
                            final denominationValue = double.tryParse(
                                  denomination?.value?.replaceAll(',', '') ?? '0',
                                ) ??
                                0;
                            final currentQuantity =
                                _denominationQuantities[denomination?.id] ?? 0;
                            final maxQuantity =
                                _calculateMaxQuantity(denominationValue) +
                                    currentQuantity;
                            final isEnabled = maxQuantity > 0;

                            return Skeletonizer(
                              enabled: state.getAllDenominationsStatus.isLoading,
                              child: DenominationItem(
                                key: ValueKey(denomination?.id),
                                denominationModel:
                                    denomination ?? DenominationModel(),
                                isEnabled: isEnabled,
                                maxQuantity: maxQuantity,
                                onQuantityChanged: (newQuantity) {
                                  if (denomination != null) {
                                    _handleQuantityChanged(
                                      denomination.id ?? 0,
                                      denominationValue,
                                      newQuantity,
                                    );
                                  }
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  if (widget.showConfirmButton && _isAmountComplete) ...[
                    24.verticalSizedBox,
                    MainButton(title: context.confirm, onTap: _handleConfirm),
                    16.verticalSizedBox,
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildRemainingAmountCard(BuildContext context) {
    final isComplete = _isAmountComplete;
    final hasStarted = _denominationQuantities.isNotEmpty;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isComplete
            ? context.colors.secondaryColor.withOpacity(0.1)
            : hasStarted
            ? context.colors.orangeColor.withOpacity(0.1)
            : context.colors.backgroundFieldColor,
        borderRadius: 12.allBorderRadius,
        border: Border.all(
          color: isComplete
              ? context.colors.secondaryColor
              : hasStarted
              ? context.colors.orangeColor
              : context.colors.strokeColor,
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.amountHint,
                style: context.textStyles.font14MediumSecondaryColor.copyWith(
                  color: context.colors.secondaryColor.withOpacity(0.7),
                ),
              ),
              if (isComplete)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: context.colors.secondaryColor,
                    borderRadius: 20.allBorderRadius,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, size: 16, color: Colors.white),
                      4.horizontalSizedBox,
                      Text(
                        'مكتمل',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          8.verticalSizedBox,
          Text(
            _formatAmount(remainingAmount),
            style: context.textStyles.font24BoldSecondaryColor.copyWith(
              color: isComplete
                  ? context.colors.secondaryColor
                  : hasStarted
                  ? context.colors.orangeColor
                  : context.colors.secondaryColor,
            ),
          ),
          if (hasStarted && !isComplete) ...[
            4.verticalSizedBox,
            Text(
              'المتبقي من ${_formatAmount(widget.amount)}',
              style: context.textStyles.font14MediumSecondaryColor.copyWith(
                color: context.colors.secondaryColor.withOpacity(0.6),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
