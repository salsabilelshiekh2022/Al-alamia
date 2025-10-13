import 'package:flutter/material.dart';

extension AppNumberExtension on num {
  //****************  borderRadius ****************** */
  BorderRadius get allBorderRadius => BorderRadius.circular(toDouble());
  //************ Padding *********************/
  EdgeInsets get allPadding => EdgeInsets.all(toDouble());
  BorderRadius get bottomBorderRadius =>
      BorderRadius.vertical(bottom: Radius.circular(toDouble()));

  Widget get horizontalDivider => Divider(height: toDouble(), thickness: 1);
  Widget get horizontalSizedBox => SizedBox(width: toDouble());
  EdgeInsets get hPadding => EdgeInsets.symmetric(horizontal: toDouble());

  BorderRadius get topBorderRadius =>
      BorderRadius.vertical(top: Radius.circular(toDouble()));
  //***************  dividers ****************** */
  Widget get verticalDivider =>
      VerticalDivider(width: toDouble(), thickness: 1);

  //****************  SizedBox ****************** */
  Widget get verticalSizedBox => SizedBox(height: toDouble());
  EdgeInsets get vPadding => EdgeInsets.symmetric(vertical: toDouble());
}
