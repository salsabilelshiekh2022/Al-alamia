import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/components/widgets/card_with_purple_shadow.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../../generated/app_assets.dart';

/// Callback type for when amount by char changes.
typedef OnAmountByCharChanged = void Function(String amountByChar);

class AmountSection extends StatefulWidget {
  const AmountSection({
    super.key,
    required this.controller,
    required this.onAmountByCharChanged,
  });

  /// Controller for the amount by char text field.
  final TextEditingController controller;

  /// Callback that fires when amount by char changes.
  final OnAmountByCharChanged onAmountByCharChanged;

  @override
  State<AmountSection> createState() => AmountSectionState();
}

class AmountSectionState extends State<AmountSection> {
  /// Returns the current amount by char value.
  String get amountByChar => widget.controller.text;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_notifyParent);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_notifyParent);
    super.dispose();
  }

  void _notifyParent() {
    widget.onAmountByCharChanged(widget.controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return CardWithPurpleShadow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.amount,
            style: context.textStyles.font17SemiBoldSecondaryColor,
          ),
          12.verticalSizedBox,
          CustomTextFieldWithLabel(
            controller: widget.controller,
            label: context.amountByChar,
            hintText: context.amountHint,
            isRequired: true,
            prefixWidget: AppAssets.svgsDollarIcon,
            keyboardType: TextInputType.text,
            validator: (val) => Validator.validateAnotherField(val, context),
          ),
        ],
      ),
    );
  }
}
