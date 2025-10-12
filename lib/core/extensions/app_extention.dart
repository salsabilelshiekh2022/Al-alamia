import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//! numbers Extension

extension AppNumberExtension on num {
  //****************  borderRadius ****************** */
  BorderRadius get allBorderRadius => BorderRadius.circular(toDouble().r);
  //************ Padding *********************/
  EdgeInsets get allPadding => EdgeInsets.all(toDouble().r);
  BorderRadius get bottomBorderRadius =>
      BorderRadius.vertical(bottom: Radius.circular(toDouble().r));

  Widget get horizontalDivider => Divider(height: toDouble().h, thickness: 1);
  Widget get horizontalSizedBox => SizedBox(width: toDouble().w);
  EdgeInsets get hPadding => EdgeInsets.symmetric(horizontal: toDouble().w);

  BorderRadius get topBorderRadius =>
      BorderRadius.vertical(top: Radius.circular(toDouble().r));
  //***************  dividers ****************** */
  Widget get verticalDivider =>
      VerticalDivider(width: toDouble().w, thickness: 1);

  //****************  SizedBox ****************** */
  Widget get verticalSizedBox => SizedBox(height: toDouble().h);
  EdgeInsets get vPadding => EdgeInsets.symmetric(vertical: toDouble().h);
}

//! Context Extension
extension ContextExtension on BuildContext {
  // ***Access the scaffold messenger for showing snack bars **
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  void pop<T>([T? result]) => Navigator.pop(this, result);

  Future<T?> push<T>(Widget page) {
    return Navigator.push(this, MaterialPageRoute(builder: (context) => page));
  }

  Future<T?> pushReplacement<T>(Widget page) {
    return Navigator.pushReplacement(
        this, MaterialPageRoute(builder: (context) => page));
  }

  Future<T?> pushAndRemoveUntil<T>(Widget page) {
    return Navigator.pushAndRemoveUntil(
        this, MaterialPageRoute(builder: (context) => page), (route) => false);
  }

  //**************** Navigation ****************** */
  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<T?> pushNamedAndRemoveUntil<T>(String routeName,
      {required RoutePredicate predicate, Object? arguments}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  Future<T?> pushReplacementNamed<T>(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }
}

//! ************ */ DateTime Extension *********************/
extension DateTimeExtension on DateTime {
  //************ */ format *********************/
  String format() {
    return '$day-$month-$year';
  }

  //************ */ isSameDay *********************/
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  //************ */ timeAgo *********************/
  String timeAgo({bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? 'مند اسبوع' : 'الاسبوع الماضي';
    } else if (difference.inDays >= 2) {
      return 'منذ ${difference.inDays} يوم';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? 'منذ 1 يوم' : 'الامس';
    } else if (difference.inHours >= 2) {
      return 'منذ ${difference.inHours} ساعة';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? 'منذ 1 ساعة' : 'ساعة واحدة مضت';
    } else if (difference.inMinutes >= 2) {
      return 'منذ ${difference.inMinutes} دقيقة';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? 'منذ دقية' : 'دقيقة واحدة مضت';
    } else if (difference.inSeconds >= 3) {
      return 'منذ ${difference.inSeconds} ثانية';
    } else {
      return 'الان';
    }
  }
}

//! String Extension`
extension StringExtension on String {
  //*** */ Capitalize the first letter of the string ********
  String capitalize() {
    if (isEmpty) {
      return '';
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  //******* */ Check if the string is a valid URL ********
  bool isValidURL() {
    final RegExp urlRegex = RegExp(
      r'^(https?:\/\/)?([a-zA-Z0-9.-]+)(:[0-9]+)?(\/.*)?$',
    );
    return urlRegex.hasMatch(this);
  }

  // ***************** localization ****************** */
  // String tr(BuildContext context) {
  // return AppLocalizations.of(context)?.translate(this) ?? this;
  // }

//*****************  check is string is English  ****************** */
  bool startsWithEnglishLetter() {
    if (isEmpty) {
      return false;
    }
    int firstCodeUnit = codeUnitAt(0);

    // Check if the first character is an English uppercase or lowercase letter
    return (firstCodeUnit >= 65 && firstCodeUnit <= 90) ||
        (firstCodeUnit >= 97 && firstCodeUnit <= 122);
  }
}

//! ************ */ TimeOfDay Extension *********************/
extension TimeOfDayExtension on TimeOfDay {
  //************ */ format with pm or am with 12h *********************/
  String formatTimeOfDay() {
    final hours = hour.toString().padLeft(2, '0');
    final minutes = minute.toString().padLeft(2, '0');
    final period = this.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hours:$minutes $period';
  }
}

//! WidgetExtension
extension WidgetExtension on Widget {
  Widget allPadding(double padding) =>
      Padding(padding: EdgeInsets.all(padding.r), child: this);
  //****************  center ****************** */
  Widget center() => Center(child: this);
  //*** */ Wrap the widget with a ClipRRect ********
  Widget clipRRect({BorderRadius borderRadius = BorderRadius.zero}) =>
      ClipRRect(
        borderRadius: borderRadius,
        child: this,
      );
  //************ Padding *********************/
  Widget horizontalPadding(double padding) => Padding(
      padding: EdgeInsets.symmetric(horizontal: padding.w), child: this);
  Widget onlyPadding(
          {double topPadding = 0,
          double bottomPadding = 0,
          double rightPadding = 0,
          double leftPadding = 0}) =>
      Padding(
          padding: EdgeInsets.only(
              bottom: bottomPadding.h,
              left: leftPadding.w,
              right: rightPadding.w,
              top: topPadding.h),
          child: this);
  Widget onlyPaddingDirectional(
          {double topPadding = 0,
          double bottomPadding = 0,
          double startPadding = 0,
          double endPadding = 0}) =>
      Padding(
          padding: EdgeInsetsDirectional.only(
              bottom: bottomPadding.h,
              end: endPadding.w,
              start: startPadding.w,
              top: topPadding.h),
          child: this);

  Widget verticalPadding(double padding) =>
      Padding(padding: EdgeInsets.symmetric(vertical: padding.h), child: this);
}

extension SizeExtension on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;
}

extension DateTimeFormaterExtension on DateTime? {
  String formatTime() {
    return DateFormat.yMMMMd('ar').format(
      this ?? DateTime.now(),
    );
  }
}
