import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/components/widgets/card_with_purple_shadow.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';

class NotesCard extends StatefulWidget {
  const NotesCard({super.key});

  @override
  State<NotesCard> createState() => _NotesCardState();
}

class _NotesCardState extends State<NotesCard> {
  late TextEditingController notesController;
  @override
  void initState() {
    notesController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return CardWithPurpleShadow(
      child: Column(
        children: [
          CustomTextFieldWithLabel(
            controller: notesController,
            label: context.addNotes,
            hintText: context.notesHint,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}
