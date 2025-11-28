import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/features/home/data/models/main_action_model.dart';
import 'package:flutter/material.dart';

import '../../../../../core/components/widgets/custom_svg_builder.dart';

class MainActionWidget extends StatelessWidget {
  const MainActionWidget({super.key, required this.mainActionModel});
  final MainActionModel mainActionModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: mainActionModel.onTap,
        child: Column(
          children: [
            CustomSvgBuilder(
              path: mainActionModel.iconPath,
              width: 24,
              height: 24,
              fit: BoxFit.contain,
              color: context.colors.primaryColor,
            ),
            6.verticalSizedBox,
            Text(
              mainActionModel.title,
              style: context.textStyles.font13SemiBoldPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
