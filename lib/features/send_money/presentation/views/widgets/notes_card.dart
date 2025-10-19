import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/components/widgets/card_with_purple_shadow.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';

class NotesCard extends StatelessWidget {
  const NotesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWithPurpleShadow(
      child: Column(
        children: [
          CustomTextFieldWithLabel(
            label: context.addNotes,
            hintText: context.notesHint,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}
