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
  final void Function(bool isComplete, List<DenominationsRequestParams> denominations)? onAmountStatusChanged;

  @override
  State<AllDenominationsBottomSheet> createState() =>
      _AllDenominationsBottomSheetState();
}

class _AllDenominationsBottomSheetState
    extends State<AllDenominationsBottomSheet> {
  late num remainingAmount;
  late TextEditingController amountController;
  Map<int, int> denominationCounts = {};

  @override
  void initState() {
    super.initState();
    remainingAmount = widget.amount;
    amountController = TextEditingController(text: _formatAmount(remainingAmount));
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

  void _updateAmount(int denominationId, num denominationValue, int countChange) {
    setState(() {
      remainingAmount -= (denominationValue * countChange);
      amountController.text = _formatAmount(remainingAmount);

      denominationCounts[denominationId] =
          (denominationCounts[denominationId] ?? 0) + countChange;

      if (denominationCounts[denominationId] == 0) {
        denominationCounts.remove(denominationId);
      }
    });

    // Notify parent about amount status change
    widget.onAmountStatusChanged?.call(_isAmountComplete, _buildDenominationsList());
  }

  List<DenominationsRequestParams> _buildDenominationsList() {
    return denominationCounts.entries
        .map((entry) => DenominationsRequestParams(
              id: entry.key,
              quantity: entry.value,
            ))
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
    widget.showTitle ?    Text(
          context.enterAmountByDenominations,
          style: context.textStyles.font17SemiBoldSecondaryColor,
        ) : const SizedBox.shrink(),
       widget.showTitle ?   27.verticalSizedBox : const SizedBox.shrink(),
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
                return Skeletonizer(
                  enabled: state.getAllDenominationsStatus.isLoading,
                  child: DenominationItem(
                    denominationModel: denomination ?? DenominationModel(),
                    onCountChanged: (change) {
                      if (denomination != null) {
                        _updateAmount(
                          denomination.id ?? 0,
                          double.parse(denomination.value ?? '0'),
                          change,
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
            MainButton(
              title: context.confirm,
              onTap: _handleConfirm,
            )
          else
            const SizedBox(),
          32.verticalSizedBox,
        ],
      ],
    );
  }
}

