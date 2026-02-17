import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/general/data/models/denomination_model.dart';
import '../../../../../core/helper/app_extention.dart';
import '../../../../../core/helper/number_extentions.dart';

class DenominationItem extends StatefulWidget {
  const DenominationItem({
    super.key,
    required this.denominationModel,
    this.onQuantityChanged,
    this.isEnabled = true,
    this.maxQuantity,
  });

  final DenominationModel denominationModel;

  /// Callback triggered when quantity changes, passes the new absolute quantity.
  final void Function(int quantity)? onQuantityChanged;

  /// When false, the item is visually dimmed and input is disabled.
  final bool isEnabled;

  /// Maximum allowed quantity based on remaining amount.
  final int? maxQuantity;

  @override
  State<DenominationItem> createState() => _DenominationItemState();
}

class _DenominationItemState extends State<DenominationItem> {
  late TextEditingController _quantityController;
  late FocusNode _focusNode;
  int _currentQuantity = 0;

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController(text: '0');
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleQuantityChange(String value) {
    if (value.isEmpty) {
      _updateQuantity(0);
      return;
    }

    final quantity = int.tryParse(value) ?? 0;
    final maxAllowed = widget.maxQuantity ?? 999;
    final validQuantity = quantity.clamp(0, maxAllowed);

    if (validQuantity != quantity) {
      _quantityController.text = validQuantity.toString();
      _quantityController.selection = TextSelection.fromPosition(
        TextPosition(offset: _quantityController.text.length),
      );
    }

    _updateQuantity(validQuantity);
  }

  void _updateQuantity(int quantity) {
    if (_currentQuantity != quantity) {
      setState(() {
        _currentQuantity = quantity;
      });
      widget.onQuantityChanged?.call(quantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isTotallyDisabled = !widget.isEnabled && _currentQuantity == 0;
    final bool hasValue = _currentQuantity > 0;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: isTotallyDisabled ? 0.5 : 1.0,
      child: Container(
        decoration: BoxDecoration(
          color: hasValue
              ? context.colors.secondaryColor.withOpacity(0.05)
              : context.colors.backgroundFieldColor,
          borderRadius: 12.allBorderRadius,
          border: Border.all(
            color: hasValue
                ? context.colors.secondaryColor.withOpacity(0.3)
                : context.colors.strokeColor,
            width: hasValue ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            _buildDenominationValue(context, hasValue),
            _buildQuantityInput(context, hasValue),
          ],
        ),
      ),
    );
  }

  Widget _buildDenominationValue(BuildContext context, bool hasValue) {
    return Expanded(
      flex: 1,
      child: Container(
        height: double.infinity,
        padding: 12.allPadding,
        decoration: BoxDecoration(
          color: hasValue
              ? context.colors.secondaryColor.withOpacity(0.15)
              : context.colors.strokeColor,
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(12.r),
            bottomStart: Radius.circular(12.r),
          ),
        ),
        child: Center(
          child: FittedBox(
            child: Text(
              widget.denominationModel.value.toString(),
              style: context.textStyles.font18SemiBoldSecondaryColor.copyWith(
                fontWeight: hasValue ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityInput(BuildContext context, bool hasValue) {
    return Expanded(
      flex: 2,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        height: double.infinity,
        decoration: BoxDecoration(
          color: hasValue
              ? context.colors.secondaryColor.withOpacity(0.05)
              : context.colors.backgroundFieldColor,
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(12.r),
            bottomEnd: Radius.circular(12.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (hasValue)
              Icon(
                Icons.receipt_long,
                size: 16.sp,
                color: context.colors.secondaryColor.withOpacity(0.6),
              ),
            if (hasValue) 6.horizontalSizedBox,
            Flexible(
              child: TextField(
                controller: _quantityController,
                focusNode: _focusNode,
                enabled: widget.isEnabled || _currentQuantity > 0,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                style: context.textStyles.font17SemiBoldSecondaryColor.copyWith(
                  fontWeight: hasValue ? FontWeight.w600 : FontWeight.w500,
                  color: hasValue
                      ? context.colors.secondaryColor
                      : Colors.grey.withOpacity(0.5),
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  hintText: '0',
                  hintStyle: context.textStyles.font17SemiBoldSecondaryColor
                      .copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                ),
                onChanged: _handleQuantityChange,
                onTap: () {
                  if (_quantityController.text == '0') {
                    _quantityController.clear();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
