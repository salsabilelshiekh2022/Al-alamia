import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/components/widgets/card_with_purple_shadow.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';

/// Callback type for when notes change.
typedef OnNotesChanged = void Function(String notes);

class NotesSection extends StatefulWidget {
  const NotesSection({
    super.key,
    required this.controller,
    required this.onNotesChanged,
  });

  /// Controller for the notes text field.
  final TextEditingController controller;

  /// Callback that fires when notes change.
  final OnNotesChanged onNotesChanged;

  @override
  State<NotesSection> createState() => NotesSectionState();
}

class NotesSectionState extends State<NotesSection> {
  /// Returns the current notes value.
  String get notes => widget.controller.text;

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
    widget.onNotesChanged(widget.controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return CardWithPurpleShadow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFieldWithLabel(
            controller: widget.controller,
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
