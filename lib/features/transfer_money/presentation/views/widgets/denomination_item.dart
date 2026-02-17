import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/general/data/models/denomination_model.dart';
import '../../../../../core/helper/app_extention.dart';
import '../../../../../core/helper/number_extentions.dart';
import '../../../../../core/helper/widget_extentions.dart';

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
            _buildQuantityInput(context),
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

  Widget _buildQuantityInput(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        height: double.infinity,
        decoration: BoxDecoration(
          color: context.colors.backgroundFieldColor,
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(12.r),
            bottomEnd: Radius.circular(12.r),
          ),
        ),
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
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            hintText: '0',
            hintStyle: context.textStyles.font17SemiBoldSecondaryColor.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.grey.withOpacity(0.5),
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
    );
  }
}
