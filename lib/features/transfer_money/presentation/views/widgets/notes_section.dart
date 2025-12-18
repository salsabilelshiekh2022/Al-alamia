import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/components/widgets/card_with_purple_shadow.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';

/// Section for entering optional notes for the transfer.
class NotesSection extends StatelessWidget {
  const NotesSection({
    super.key,
    required this.notesController,
  });

  final TextEditingController notesController;

  @override
  Widget build(BuildContext context) {
    return CardWithPurpleShadow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFieldWithLabel(
            controller: notesController,
            label: context.addNotes,
            hintText: context.notesHint,
            maxLines: 3,
            keyboardType: TextInputType.text,
          ),
        ],
      ),
    );
  }
}