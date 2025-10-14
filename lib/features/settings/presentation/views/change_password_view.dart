import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/widgets/custom_page.dart';
import 'widgets/change_password/change_password_form.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: context.changePassword,
      hasActions: false,
      isBack: true,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      body: ChangePasswordForm(),
    );
  }
}

