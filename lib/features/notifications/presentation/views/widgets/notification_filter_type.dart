import 'package:alalamia/core/enums/notifications_enum.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationFilterType extends StatefulWidget {
  const NotificationFilterType({super.key});

  @override
  State<NotificationFilterType> createState() => _NotificationFilterTypeState();
}

class _NotificationFilterTypeState extends State<NotificationFilterType> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 6.allPadding,
      width: double.infinity,
      height: 45.h,
      decoration: BoxDecoration(
        color: context.colors.backgroundFieldColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: List.generate(
          NotificationsEnum.values.length,
          (index) => Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 2),
                padding: 5.allPadding,
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? context.colors.whiteColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: Text(
                    NotificationsEnum.values[index].translate(context),
                    style: selectedIndex == index
                        ? context.textStyles.font16MediumPrimaryColor
                        : context.textStyles.font16MediumSecondaryColor.copyWith(
                              color: context.colors.grayColor,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}