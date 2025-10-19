import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/features/settings/data/models/setting_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/widgets/custom_app_bar.dart';
import '../../../../generated/app_assets.dart';
import 'widgets/settings/logout_section.dart';
import 'widgets/settings/setting_group.dart';
import 'widgets/settings/user_info_box.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

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
                  title: context.settings,
                  hasActions: false,
                  isBack: false,
                ).onlyPadding(bottomPadding: 24),

                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 25),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 35,
                      ),
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
                      child: Column(
                        children: [
                          50.verticalSpace,
                          SettingGroup(
                            title: context.accountSettings,
                            settingItems: fristSettingGroup(context),
                          ),
                          20.verticalSpace,
                          SettingGroup(
                            title: context.appSettings,
                            settingItems: secoundSettingGroup(context),
                          ),
                          20.verticalSpace,
                          SettingGroup(
                            title: context.other,
                            settingItems: thirdSettingGroup(context),
                          ),
                          20.verticalSpace,
                          LogoutSection(),
                          130.verticalSpace,
                        ],
                      ),
                    ),

                    PositionedDirectional(
                      top: -10,
                      start: 16,
                      end: 16,
                      child: UserInfoBox(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
