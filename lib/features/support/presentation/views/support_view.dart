import 'package:alalamia/core/components/widgets/main_button.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/widgets/custom_page.dart';
import 'widgets/tickets_list.dart';

class SupportView extends StatelessWidget {
  const SupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: "الدعم الفني",
      hasActions: false,
      isBack: true,
      body: Column(
        children: [
          TicketsList(),
          32.verticalSizedBox,
          MainButton(title: context.addComplaint, onTap: () {}),
        ],
      ),
    );
  }
}
