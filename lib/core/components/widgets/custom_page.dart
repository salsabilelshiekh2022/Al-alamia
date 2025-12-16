import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../generated/app_assets.dart';
import 'custom_app_bar.dart';

class CustomPage extends StatelessWidget {
  const CustomPage({
    super.key,
    required this.title,
    required this.hasActions,
    required this.isBack,
    required this.body, this.padding, this.topMargin,
  });

  final String title;
  final bool hasActions;
  final bool isBack;
  final Widget body;
  final EdgeInsetsGeometry? padding;
  final double? topMargin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppAssets.imagesBackground,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
         
          SingleChildScrollView(
            child: Column(
              children: [
                CustomAppBar(
                  title: title,
                  hasActions: hasActions,
                  isBack: isBack,
                ).onlyPadding(bottomPadding: 24),
                Container(
                  margin: EdgeInsets.only(top: topMargin ?? 0),
                  padding:padding ?? const EdgeInsets.all(24),
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 130.h,
                  ),
                  decoration: BoxDecoration(
                    color: context.colors.whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: body,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
