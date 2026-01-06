import 'package:alalamia/core/components/widgets/card_with_purple_shadow.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
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
    required this.onChanged, this.color, this.displayImageCurrency =true,
  });

  final List<CurrencyModel> items;
  final CurrencyModel? selectedItem;
  final ValueChanged<CurrencyModel?> onChanged;
  final Color? color;
  final bool displayImageCurrency;

  static const double _popupMaxHeight = 180;
  static const double _itemPadding = 14;
  static const double _dropdownBorderRadius = 10;
  static const double _imageSize = 22;
 

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<CurrencyModel>(
      items: (_, __) => items,
      selectedItem: selectedItem,
      onChanged: onChanged,
      itemAsString: _getItemDisplayName,
      compareFn: _areItemsEqual,
      suffixProps: _buildSuffixProps(),
      decoratorProps: _buildDecoratorProps(),
      popupProps: _buildPopupProps(context),
      dropdownBuilder: _buildDropdownBuilder(context),
    );
  }

  String _getItemDisplayName(CurrencyModel item) => item.name ?? '';

  bool _areItemsEqual(CurrencyModel item1, CurrencyModel item2) =>
      item1.id == item2.id;

  DropdownSuffixProps _buildSuffixProps() => const DropdownSuffixProps(
    dropdownButtonProps: DropdownButtonProps(isVisible: false),
  );

  DropDownDecoratorProps _buildDecoratorProps() => DropDownDecoratorProps(
    decoration: const InputDecoration(
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      contentPadding: EdgeInsets.zero,
    ),
  );

  PopupProps<CurrencyModel> _buildPopupProps(BuildContext context) =>
      PopupProps.menu(
        fit: FlexFit.loose,
        constraints: BoxConstraints(maxHeight: _popupMaxHeight.h),
        menuProps: MenuProps(
          borderRadius: BorderRadius.circular(12.r),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        containerBuilder: (context, child) => CardWithWhiteShadow(child: child),
        itemBuilder: (context, item, isSelected, __) =>
            _buildPopupItem(context, item, isSelected),
      );

  Widget _buildPopupItem(
    BuildContext context,
    CurrencyModel item,
    bool isSelected,
  ) {
    return Container(
      padding: EdgeInsets.all(_itemPadding.r),
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
  }

  DropdownSearchBuilder<CurrencyModel> _buildDropdownBuilder(
    BuildContext context,
  ) {
    return (context, selectedItem) {
      return Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color:color != null ? Colors.white.withValues(alpha: 0.12) : context.colors.backgroundFieldColor,
          borderRadius: BorderRadius.circular(_dropdownBorderRadius.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
          if (selectedItem?.image != null && displayImageCurrency)  _buildCurrencyImage(selectedItem!),
         displayImageCurrency ?   SizedBox(width: 11.w) : const SizedBox.shrink(),
            _buildCurrencyName(context, selectedItem),
            SizedBox(width: 10.w),
             Icon(Icons.keyboard_arrow_down, color: color ?? Color(0xff3C3C3C)),
          ],
        ),
      );
    };
  }

  Widget _buildCurrencyImage(CurrencyModel currency) {
    return ClipRRect(
      borderRadius: 12.allBorderRadius,
      child: SvgPicture.network(
        currency.image!,
        width: 20,
        height: 20,
        fit: BoxFit.scaleDown,
      ),
    );
  }

  Widget _buildCurrencyName(BuildContext context, CurrencyModel? currency) {
    return Expanded(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          currency?.name ?? context.dollar,
          style: context.textStyles.font14MediumPrimaryColor.copyWith(
            color: color?? context.colors.primaryColor,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
