import 'package:alalamia/core/components/widgets/custom_text_field.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/features/home/data/models/currency_model.dart';
import 'package:alalamia/generated/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrencySelectionBottomSheet extends StatefulWidget {
  const CurrencySelectionBottomSheet({
    super.key,
    required this.currencies,
    required this.onCurrencySelected,
    this.selectedCurrencyId,
  });

  final List<CurrencyModel> currencies;
  final ValueChanged<CurrencyModel> onCurrencySelected;
  final int? selectedCurrencyId;

  @override
  State<CurrencySelectionBottomSheet> createState() =>
      _CurrencySelectionBottomSheetState();
}

class _CurrencySelectionBottomSheetState
    extends State<CurrencySelectionBottomSheet> {
  late List<CurrencyModel> filteredCurrencies;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCurrencies = widget.currencies;
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredCurrencies = widget.currencies.where((currency) {
        final name = (currency.name ?? '').toLowerCase();
        final code = (currency.code ?? '').toLowerCase();
        return name.contains(query) || code.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.h,
      child: Column(
        children: [
          Text(
            context.currency,
            style: context.textStyles.font18BoldSecondaryColor,
          ),
          12.verticalSizedBox,
          CustomTextField(
            hintText: context.search,
            controller: searchController,
            prefixWidget: AppAssets.svgsSearchIcon,
            onChanged: (value) {},
          ),
          12.verticalSizedBox,
          Expanded(
            child: ListView.separated(
              itemCount: filteredCurrencies.length,
              separatorBuilder: (context, index) => 4.verticalSizedBox,
              itemBuilder: (context, index) {
                final currency = filteredCurrencies[index];
                final isSelected = widget.selectedCurrencyId == currency.id;

                return InkWell(
                  onTap: () => widget.onCurrencySelected(currency),
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    padding: isSelected ? 14.allPadding : 14.allPadding,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? context.colors.primaryColor.withValues(alpha: 0.1)
                          : context.colors.backgroundFieldColor,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: isSelected
                            ? context.colors.primaryColor
                            : context.colors.strokeColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            currency.name ?? '',
                            style: isSelected
                                ? context.textStyles.font16MediumPrimaryColor
                                : context.textStyles.font16MediumSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
