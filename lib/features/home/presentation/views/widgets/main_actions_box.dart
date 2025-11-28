import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/features/home/data/models/main_action_model.dart';
import 'package:alalamia/features/home/presentation/views/widgets/main_action_widget.dart';
import 'package:flutter/material.dart';

class MainActionsBox extends StatelessWidget {
  const MainActionsBox({super.key});

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      top: 20,
      start: 16,
      end: 16,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 13, horizontal: 26),
        decoration: ShapeDecoration(
          color: context.colors.whiteColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: const Color(0x2800840F)),
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: context.colors.whiteShadowsBox,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MainActionWidget(
              mainActionModel: mainActionsList(context: context)[0],
            ),
            MainActionWidget(
              mainActionModel: mainActionsList(context: context)[1],
            ),
            MainActionWidget(
              mainActionModel: mainActionsList(context: context)[2],
            ),
            MainActionWidget(
              mainActionModel: mainActionsList(context: context)[3],
            ),
          ],
        ),
      ),
    );
  }
}
