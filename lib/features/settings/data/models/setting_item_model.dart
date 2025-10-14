import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/routes/routes.dart';
import 'package:alalamia/generated/app_assets.dart';
import 'package:flutter/material.dart';



class SettingItemModel {
  final String title;
  final String iconPath;
  final String? subtitle;
  final void Function()? onTap;
  final bool? isNotification;

  SettingItemModel({
    required this.title,
    required this.iconPath,
    this.onTap,
    this.isNotification = false,
    this.subtitle,
  });
}

List<SettingItemModel> fristSettingGroup(BuildContext context) => [
  SettingItemModel(
    title: context.profileAccount,
    iconPath: AppAssets.svgsUser,
    subtitle: context.updateProfile,
    onTap: () {
     context.pushNamed(Routes.profileSettingsView);
    },
  ),
  SettingItemModel(
    title: context.changePassword,
    iconPath: AppAssets.svgsBlackLockIcon,
    subtitle: context.updateSecurity,
    onTap: () {
      context.pushNamed(Routes.changePasswordView);
    },
  ),

];

List<SettingItemModel> secoundSettingGroup(BuildContext context) => [
  SettingItemModel(
    title: context.notifications,
    iconPath: AppAssets.svgsBell,
    isNotification: true,
    onTap: () {
      
    },
  ),
 SettingItemModel(
    title: context.language,
    iconPath: AppAssets.svgsWorldIcon,
   subtitle: context.arabic,
    onTap: () {
      
    },
  ),
];
List<SettingItemModel> thirdSettingGroup(BuildContext context) => [
  SettingItemModel(
    title: context.support,
    iconPath: AppAssets.svgsSupportIcon,
   
    onTap: () {
      
    },
  ),
 SettingItemModel(
    title: context.aboutApp,
    iconPath: AppAssets.svgsInfoIcon,
  
    onTap: () {
      
    },
  ),
];