import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/widgets/card_with_purple_shadow.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../data/models/send_money_form_data.dart';
import '../../cubit/send_money_cubit.dart';

class NotesCard extends StatefulWidget {
  const NotesCard({super.key});

  @override
  State<NotesCard> createState() => _NotesCardState();
}

class _NotesCardState extends State<NotesCard> {
  late TextEditingController notesController;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SendMoneyCubit>();
    notesController =
        TextEditingController(text: cubit.state.formData?.note ?? '');
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  void _updateFormData() {
    final cubit = context.read<SendMoneyCubit>();
    final currentFormData = cubit.state.formData ?? SendMoneyFormData.empty();
    cubit.updateFormData(
      currentFormData.copyWith(note: notesController.text),
    );
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
            onChanged: (_) => _updateFormData(),
          ),
        ],
      ),
    );
  }
}
