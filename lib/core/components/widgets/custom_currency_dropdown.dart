import 'package:alalamia/core/components/widgets/currency_selection_bottom_sheet.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/utils/global_ui_utils.dart';
import 'package:alalamia/features/home/data/models/currency_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomCurrencyDropdown extends StatelessWidget {
  const CustomCurrencyDropdown({
    super.key,
    required this.items,
    this.selectedItem,
    required this.onChanged,
    this.color,
    this.displayImageCurrency = true,
  });

  final List<CurrencyModel> items;
  final CurrencyModel? selectedItem;
  final ValueChanged<CurrencyModel?> onChanged;
  final Color? color;
  final bool displayImageCurrency;

  static const double _dropdownBorderRadius = 10;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GlobalUiUtils.showBottomSheet(
          context,
          child: CurrencySelectionBottomSheet(
            currencies: items,
            selectedCurrencyId: selectedItem?.id,
            onCurrencySelected: (currency) {
              onChanged(currency);
              Navigator.pop(context);
            },
          ),
        );
      },
      borderRadius: BorderRadius.circular(_dropdownBorderRadius.r),
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: color != null
              ? Colors.white.withValues(alpha: 0.12)
              : context.colors.backgroundFieldColor,
          borderRadius: BorderRadius.circular(_dropdownBorderRadius.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selectedItem?.image != null && displayImageCurrency)
              _buildCurrencyImage(selectedItem!),
            displayImageCurrency
                ? SizedBox(width: 11.w)
                : const SizedBox.shrink(),
            _buildCurrencyName(context, selectedItem),
            SizedBox(width: 10.w),
            Icon(Icons.keyboard_arrow_down, color: color ?? Color(0xff3C3C3C)),
          ],
        ),
      ),
    );
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
            color: color ?? context.colors.primaryColor,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

