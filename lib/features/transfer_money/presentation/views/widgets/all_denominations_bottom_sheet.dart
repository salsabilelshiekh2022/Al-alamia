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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Callback type for when denominations are selected.
/// Returns a list of maps containing 'id' and 'quantity' for each selected denomination.
typedef OnDenominationsSelected = void Function(
  List<Map<String, dynamic>> denominations,
);

class AllDenominationsBottomSheet extends StatefulWidget {
  const AllDenominationsBottomSheet({
    super.key,
    required this.onDenominationsSelected,
  });

  /// Callback that fires when user confirms denomination selection.
  final OnDenominationsSelected onDenominationsSelected;

  @override
  State<AllDenominationsBottomSheet> createState() =>
      _AllDenominationsBottomSheetState();
}

class _AllDenominationsBottomSheetState
    extends State<AllDenominationsBottomSheet> {
  /// Tracks the quantity selected for each denomination by its ID.
  final Map<int, int> _denominationQuantities = {};

  /// Calculates the total count of selected denominations.
  int _calculateTotalCount() {
    int total = 0;
    for (final quantity in _denominationQuantities.values) {
      total += quantity;
    }
    return total;
  }

  /// Handles quantity change for a specific denomination.
  void _onQuantityChanged(int denominationId, int quantity) {
    setState(() {
      if (quantity > 0) {
        _denominationQuantities[denominationId] = quantity;
      } else {
        _denominationQuantities.remove(denominationId);
      }
    });
  }

  /// Builds the list of selected denominations to return via callback.
  List<Map<String, dynamic>> _buildSelectedDenominations() {
    return _denominationQuantities.entries
        .where((entry) => entry.value > 0)
        .map((entry) => {
              'id': entry.key,
              'quantity': entry.value,
            })
        .toList();
  }

  /// Handles the confirm button tap.
  void _onConfirm() {
    final selectedDenominations = _buildSelectedDenominations();
    Navigator.of(context).pop();
    widget.onDenominationsSelected(selectedDenominations);
  }

  @override
  void initState() {
    super.initState();
    context.read<GeneralCubit>().getAllDenominations();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeneralCubit, GeneralState>(
      builder: (context, state) {
        final totalCount = _calculateTotalCount();
        final isLoading = state.getAllDenominationsStatus.isLoading;
        final hasSelections = _denominationQuantities.values.any((q) => q > 0);
        
        // Filter out null denominations
        final denominations = state.denominations
            ?.whereType<DenominationModel>()
            .toList() ?? [];

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.enterAmountByDenominations,
              style: context.textStyles.font17SemiBoldSecondaryColor,
            ),
            27.verticalSizedBox,
            CustomTextField(
              hintText: context.amountHint,
              enabled: false,
              initialValue: '$totalCount ${context.number}',
              textStyle: context.textStyles.font16MediumSecondaryColor,
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                mainAxisExtent: 50,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: isLoading ? 6 : denominations.length,
              itemBuilder: (context, index) {
                if (isLoading) {
                  return Skeletonizer(
                    enabled: true,
                    child: DenominationItem(
                      denominationModel: DenominationModel(),
                      quantity: 0,
                      onQuantityChanged: (_) {},
                    ),
                  );
                }

                final denomination = denominations[index];
                final quantity = _denominationQuantities[denomination.id] ?? 0;

                return DenominationItem(
                  denominationModel: denomination,
                  quantity: quantity,
                  onQuantityChanged: (newQuantity) {
                    if (denomination.id != null) {
                      _onQuantityChanged(denomination.id!, newQuantity);
                    }
                  },
                );
              },
            ).onlyPadding(topPadding: 28),
            MainButton(
              title: context.confirm,
              onTap: hasSelections ? _onConfirm : () {},
            ),
            32.verticalSizedBox,
          ],
        );
      },
    );
  }
}

class DenominationItem extends StatelessWidget {
  const DenominationItem({
    super.key,
    required this.denominationModel,
    required this.quantity,
    required this.onQuantityChanged,
  });

  final DenominationModel denominationModel;
  final int quantity;
  final ValueChanged<int> onQuantityChanged;

  void _increment() => onQuantityChanged(quantity + 1);

  void _decrement() {
    if (quantity > 0) {
      onQuantityChanged(quantity - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.backgroundFieldColor,
        borderRadius: 12.allBorderRadius,
        border: Border.all(color: context.colors.strokeColor, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: double.infinity,
              padding: 12.allPadding,
              decoration: BoxDecoration(
                color: context.colors.strokeColor,
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(12.r),
                  bottomStart: Radius.circular(12.r),
                ),
              ),
              child: FittedBox(
                child: Text(
                  denominationModel.name ?? 'N/A',
                  style: context.textStyles.font18SemiBoldSecondaryColor,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: 12.allPadding,
              height: double.infinity,
              decoration: BoxDecoration(
                color: context.colors.backgroundFieldColor,
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(12.r),
                  bottomEnd: Radius.circular(12.r),
                ),
              ),
              child: Row(
                children: [
                  _CountButton(
                    icon: Icons.add_rounded,
                    onTap: _increment,
                  ),
                  10.horizontalSizedBox,
                  Text(
                    quantity.toString(),
                    style: context.textStyles.font17SemiBoldSecondaryColor
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  10.horizontalSizedBox,
                  _CountButton(
                    icon: Icons.remove_rounded,
                    onTap: _decrement,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CountButton extends StatelessWidget {
  const _CountButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          borderRadius: 13.allBorderRadius,
          color: const Color(0xff9b9b9b).withValues(alpha: 0.09),
        ),
        child: Icon(
          icon,
          color: context.colors.secondaryColor,
          size: 16.sp,
        ).center(),
      ),
    );
  }
}
