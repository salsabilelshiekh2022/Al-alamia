import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/utils/global_ui_utils.dart';
import '../../../../generated/app_assets.dart';
import '../../../send_money/presentation/views/widgets/send_money_bottom_sheet.dart';

class MainActionModel {
  final String title;
  final String iconPath;
  final void Function() onTap;

  MainActionModel({
    required this.title,
    required this.iconPath,
    required this.onTap,
  });
}

List<MainActionModel> mainActionsList({required BuildContext context}) => [
  MainActionModel(
    title: context.sendMoney,
    iconPath: AppAssets.svgsSendMoneyIcon,
    onTap: () {
      GlobalUiUtils.showBottomSheet(context, child: SendMoneyBottomSheet());
    },
  ),
  MainActionModel(
    title: context.currencyTransfer,
    iconPath: AppAssets.svgsPurpleTransfarIcon,
    onTap: () {
      context.pushNamed(Routes.transferCurrencyView);
    },
  ),
  MainActionModel(
    title: context.inOut,
    iconPath: AppAssets.svgsInOut,
    onTap: () {
      context.pushNamed(Routes.inAndOutTransactionView);
    },
  ),
];
