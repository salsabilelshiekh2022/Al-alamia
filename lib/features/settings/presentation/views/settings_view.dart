import 'package:alalamia/core/components/widgets/custom_page.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/features/settings/data/models/setting_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/settings/logout_section.dart';
import 'widgets/settings/setting_group.dart';
import 'widgets/settings/user_info_box.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomPage(
            title: context.settings,
            hasActions: false,
            isBack: false,
         topMargin: 25,
            body: Column(
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
                130.verticalSpace
              ],
            ),
          ),
          PositionedDirectional(
            top: 95.h,
            start: 24,
            end: 24,
            child: UserInfoBox(),
          ),
        ],
      ),
    );
  }
}

