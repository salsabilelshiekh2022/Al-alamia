import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/components/widgets/custom_cache_network_image.dart';
import '../../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../../core/components/widgets/main_button.dart';
import '../../../../../../generated/app_assets.dart';

class ProfileSettingsForm extends StatelessWidget {
  const ProfileSettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Stack(
            children: [
              CustomCachedImageWidget(
                path:
                    "https://i.pinimg.com/736x/5f/94/15/5f9415114f1e9bf75b48d52221e15414.jpg",
                width: 104,
                height: 104,
              ).clipRRect(borderRadius: BorderRadius.circular(52)),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: () {},
                  child: CustomSvgBuilder(
                    path: AppAssets.svgsEditIcon,
                    width: 32,
                    height: 32,
                  ),
                ),
              ),
            ],
          ),
          40.verticalSpace,
          CustomTextFieldWithLabel(
            label: context.fullName,
            hintText: context.fullNameHint,
            prefixWidget: AppAssets.svgsUserIcon,
          ),
          20.verticalSpace,
          CustomTextFieldWithLabel(
            label: context.phone,
            hintText: context.phoneHint,
            prefixWidget: AppAssets.svgsPhone,
          ),
          32.verticalSpace,
          MainButton(
            title: context.saveChanges,
            onTap: () {
              context.pop();
            },
          ),
        ],
      ),
    );
  }
}
