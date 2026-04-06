import 'package:alalamia/core/helper/app_extention.dart';
import 'package:flutter/material.dart';

import '../../../generated/app_assets.dart';
import 'custom_svg_builder.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.hasActions = false,
    this.isBack = false, this.actionWidget,
  });
  final String title;
  final bool hasActions;
  final bool isBack;
  final Widget? actionWidget;

   @override

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: context.textStyles.font18SemiBoldWhiteColor),
      leading: isBack
          ? CustomBackButton()
          : null,
      actions: hasActions
          ? [
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 16),
                child:actionWidget ?? InkWell(
                  child: CustomSvgBuilder(
                    path: AppAssets.svgsLangBtnIcon,
                    width: 44,
                    height: 44,
                  ),
                ),
              ),
            ]
          : [],
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsetsDirectional.only(start: 16),
        child: InkWell(
          onTap: () => context.pop(),
          child: CustomSvgBuilder(
            path: AppAssets.svgsArrowBtnIcon,
            width: 44,
            height: 44,
            fit: BoxFit.contain,
          ),
        ),
      );
  }
}
