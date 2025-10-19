import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

import '../../generated/app_assets.dart';

enum RegistrationMethodsEnum {
  employee,
  accountant,
  admin;

  String translate(BuildContext context) {
    switch (this) {
      case RegistrationMethodsEnum.employee:
        return context.employee;
      case RegistrationMethodsEnum.accountant:
        return context.accountant;
      case RegistrationMethodsEnum.admin:
        return context.admin;
    }
  }

  String chooseImage(BuildContext context) {
    switch (this) {
      case RegistrationMethodsEnum.employee:
        return AppAssets.svgsPurpleUsersIcon;
      case RegistrationMethodsEnum.accountant:
        return AppAssets.svgsCalcIcon;
      case RegistrationMethodsEnum.admin:
        return AppAssets.svgsManagerIcon;
    }
  }
}
