import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'card_with_purple_shadow.dart';

class CustomDropDownCard extends StatefulWidget {
  const CustomDropDownCard({
    super.key,
    required this.dropDownItems,
    required this.onItemSelected,
    this.selectedValue = '',
  });

  final List<String> dropDownItems;
  final void Function(String) onItemSelected;
  final String selectedValue;

  @override
  State<CustomDropDownCard> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDownCard> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 150.h, minHeight: 60.h),
      child: CardWithWhiteShadow(
        child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            final item = widget.dropDownItems[index];
            final isSelected = item == widget.selectedValue;

            return InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                widget.onItemSelected(item);
              },
              child: Container(
                padding: isSelected ? 14.allPadding : 14.hPadding,
                decoration: BoxDecoration(
                  color: isSelected
                      ? context.colors.primaryColor.withValues(alpha: 0.04)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  item,
                  style: context.textStyles.font15MediumGrayColor.copyWith(
                    color: isSelected
                        ? context.colors.primaryColor
                        : context.colors.secondaryColor,
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => 16.verticalSizedBox,
          itemCount: widget.dropDownItems.length,
        ),
      ),
    );
  }
}
