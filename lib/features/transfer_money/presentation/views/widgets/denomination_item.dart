import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/general/data/models/denomination_model.dart';
import '../../../../../core/helper/app_extention.dart';
import '../../../../../core/helper/number_extentions.dart';
import '../../../../../core/helper/widget_extentions.dart';

class DenominationItem extends StatefulWidget {
  const DenominationItem({
    super.key,
    required this.denominationModel,
    this.onCountChanged,
    this.isEnabled = true,
  });
  
  final DenominationModel denominationModel;
  final void Function(int change)? onCountChanged;

  /// When false, the item is visually dimmed and the add button is disabled.
  final bool isEnabled;

  @override
  State<DenominationItem> createState() => _DenominationItemState();
}

class _DenominationItemState extends State<DenominationItem> {
  int count = 0;

  void _incrementCount() {
    if (!widget.isEnabled) return;
    setState(() {
      count++;
    });
    widget.onCountChanged?.call(1);
  }

  void _decrementCount() {
    if (count > 0) {
      setState(() {
        count--;
      });
      widget.onCountChanged?.call(-1);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Only dim the entire widget if the user has none AND cannot add any.
    final bool isTotallyDisabled = !widget.isEnabled && count == 0;

    return Opacity(
      opacity: isTotallyDisabled ? 0.5 : 1.0,
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.backgroundFieldColor,
          borderRadius: 12.allBorderRadius,
          border: Border.all(color: context.colors.strokeColor, width: 1),
        ),
        child: Row(
          children: [
            _buildDenominationValue(context),
            _buildCounterSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDenominationValue(BuildContext context) {
    return Expanded(
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
            widget.denominationModel.value.toString(),
            style: context.textStyles.font18SemiBoldSecondaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildCounterSection(BuildContext context) {
    return Expanded(
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCountButton(
              context: context,
              icon: Icons.add_rounded,
              onTap: widget.isEnabled ? _incrementCount : null,
              isEnabled: widget.isEnabled,
            ),
            Text(
              count.toString(),
              style: context.textStyles.font17SemiBoldSecondaryColor
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            _buildCountButton(
              context: context,
              icon: Icons.remove_rounded,
              onTap: count > 0 ? _decrementCount : null,
              isEnabled: count > 0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCountButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback? onTap,
    required bool isEnabled,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(13.r),
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13.r),
          color: const Color(0xff9b9b9b).withValues(alpha: 0.09),
        ),
        child: Icon(
          icon,
          color: isEnabled ? context.colors.secondaryColor : Colors.grey,
          size: 16.sp,
        ).center(),
      ),
    );
  }
}