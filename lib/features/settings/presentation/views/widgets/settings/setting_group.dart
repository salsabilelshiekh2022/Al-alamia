import 'package:alalamia/core/components/widgets/custom_svg_builder.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/models/setting_item_model.dart';

class SettingGroup extends StatelessWidget {
  const SettingGroup({
    super.key,
    required this.title,
    required this.settingItems,
  });
  final String title;
  final List<SettingItemModel> settingItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: context.colors.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Color(0xff6E0084).withValues(alpha: 0.2),
            blurRadius: 20.r,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.textStyles.font15SemiBoldSecondaryColor),
          20.verticalSpace,
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return SettingItemWidget(settingItem: settingItems[index]);
            },
            separatorBuilder: (context, index) => 23.verticalSpace,
            itemCount: settingItems.length,
          ),
        ],
      ),
    );
  }
}

class SettingItemWidget extends StatelessWidget {
  const SettingItemWidget({super.key, required this.settingItem});
  final SettingItemModel settingItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: settingItem.onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSvgBuilder(
            path: settingItem.iconPath,
            width: 24,
            height: 24,
            color: context.colors.secondaryColor,
          ),
          15.horizontalSpace,
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  settingItem.title,
                  style: context.textStyles.font14RegularSecondaryColor,
                ),
                if (settingItem.subtitle != null &&
                    settingItem.subtitle!.isNotEmpty) ...[
                  5.verticalSpace,
                  Text(
                    settingItem.subtitle!,
                    style: context.textStyles.font13RegularPrimaryColor
                        .copyWith(color: context.colors.grayColor),
                  ),
                ],
              ],
            ),
          ),

          Icon(
            Icons.arrow_forward_ios_sharp,
            color: context.colors.grayColor,
            size: 20,
          ),
        ],
      ),
    );
  }
}
