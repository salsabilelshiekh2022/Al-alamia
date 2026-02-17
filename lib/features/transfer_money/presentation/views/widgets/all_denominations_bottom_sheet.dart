import 'package:alalamia/core/components/widgets/custom_text_field.dart';
import 'package:alalamia/core/components/widgets/main_button.dart';
import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/core/general/cubit/general_cubit.dart';
import 'package:alalamia/core/general/cubit/general_state.dart';
import 'package:alalamia/core/general/data/models/denomination_model.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
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
    return Column(
      children: [
        widget.showTitle
            ? Text(
                context.enterAmountByDenominations,
                style: context.textStyles.font17SemiBoldSecondaryColor,
              )
            : const SizedBox.shrink(),
        widget.showTitle ? 27.verticalSizedBox : const SizedBox.shrink(),
        CustomTextField(
          hintText: context.amountHint,
          enabled: false,
          controller: amountController,
          textStyle: context.textStyles.font16MediumSecondaryColor,
        ),
        BlocBuilder<GeneralCubit, GeneralState>(
          builder: (context, state) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 4,
                mainAxisExtent: 50,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.denominations?.length ?? 6,
              itemBuilder: (context, index) {
                final denomination = state.denominations?[index];
                final denominationValue =
                    double.tryParse(
                      denomination?.value?.replaceAll(',', '') ?? '0',
                    ) ??
                    0;
                final currentQuantity =
                    _denominationQuantities[denomination?.id] ?? 0;
                final maxQuantity =
                    _calculateMaxQuantity(denominationValue) + currentQuantity;
                final isEnabled = maxQuantity > 0;

                return Skeletonizer(
                  enabled: state.getAllDenominationsStatus.isLoading,
                  child: DenominationItem(
                    key: ValueKey(denomination?.id),
                    denominationModel: denomination ?? DenominationModel(),
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
            ).onlyPadding(topPadding: 28);
          },
        ),
        if (widget.showConfirmButton) ...[
          _isAmountComplete ? 24.verticalSizedBox : const SizedBox.shrink(),
          if (_isAmountComplete)
            MainButton(title: context.confirm, onTap: _handleConfirm)
          else
            const SizedBox(),
          32.verticalSizedBox,
        ],
      ],
    );
  }
}
