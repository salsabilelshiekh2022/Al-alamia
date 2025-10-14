import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/widgets/custom_page.dart';
import 'widgets/profile_settings/profile_settings_form.dart';

class ProfileSettingView extends StatelessWidget {
  const ProfileSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: context.profileSettings,
      hasActions: false,
      isBack: true,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      body: ProfileSettingsForm(),
    );
  }
}

