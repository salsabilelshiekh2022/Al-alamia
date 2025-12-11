import 'package:alalamia/core/components/widgets/card_with_purple_shadow.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/features/home/data/models/currency_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomCurrencyDropdown extends StatelessWidget {
  const CustomCurrencyDropdown({
    super.key,
    required this.items,
    this.selectedItem,
    required this.onChanged,
  });

  final List<CurrencyModel> items;
  final CurrencyModel? selectedItem;
  final ValueChanged<CurrencyModel?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<CurrencyModel>(
      items: (filter, loadProps) => items,
      selectedItem: selectedItem,
      onChanged: onChanged,
      itemAsString: (item) => item.name ?? '',
      compareFn: (item1, item2) => item1.id == item2.id,
      suffixProps: const DropdownSuffixProps(
        dropdownButtonProps: DropdownButtonProps(isVisible: false),
      ),
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
      ),
      popupProps: PopupProps.menu(
        fit: FlexFit.loose,
        constraints: BoxConstraints(maxHeight: 180.h),
        menuProps: MenuProps(
          borderRadius: BorderRadius.circular(12),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        containerBuilder: (context, child) {
          return CardWithWhiteShadow(child: child);
        },
        itemBuilder: (context, item, isSelected, isHovered) {
          return Container(
            padding: 14.allPadding,
            decoration: BoxDecoration(
              color: selectedItem == item
                  ? context.colors.primaryColor.withValues(alpha: 0.04)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              item.name ?? '',
              style: context.textStyles.font15MediumGrayColor.copyWith(
                color: selectedItem == item
                    ? context.colors.primaryColor
                    : context.colors.secondaryColor,
              ),
            ),
          );
        },
      ),
      dropdownBuilder: (context, selectedItem) {
        return Container(
          padding: 10.allPadding,
          decoration: BoxDecoration(
            color: context.colors.backgroundFieldColor,
            borderRadius: 10.allBorderRadius,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selectedItem?.image != null) ...[
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SvgPicture.network(
                    selectedItem!.image!,
                    width: 22,
                    height: 22,
                    fit: BoxFit.contain,
                  ).clipRRect(borderRadius: BorderRadius.circular(11)),
                ),
              ],
              11.horizontalSpace,
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    selectedItem?.name ?? context.dollar,
                    style: context.textStyles.font14MediumPrimaryColor,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              10.horizontalSpace,
              Icon(Icons.keyboard_arrow_down, color: Color(0xff3C3C3C)),
            ],
          ),
        );
      },
    );
  }
}
