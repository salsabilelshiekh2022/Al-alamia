import 'package:alalamia/core/components/widgets/custom_text_field.dart';
import 'package:alalamia/core/general/data/models/expenses_type_model.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/generated/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpensesTypeSelectionBottomSheet extends StatefulWidget {
  const ExpensesTypeSelectionBottomSheet({
    super.key,
    required this.expensesTypes,
    required this.onExpensesTypeSelected,
    this.selectedExpensesTypeId,
  });

  final List<ExpensesTypeModel?> expensesTypes;
  final ValueChanged<ExpensesTypeModel> onExpensesTypeSelected;
  final int? selectedExpensesTypeId;

  @override
  State<ExpensesTypeSelectionBottomSheet> createState() =>
      _ExpensesTypeSelectionBottomSheetState();
}

class _ExpensesTypeSelectionBottomSheetState
    extends State<ExpensesTypeSelectionBottomSheet> {
  late List<ExpensesTypeModel?> filteredExpensesTypes;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredExpensesTypes = widget.expensesTypes;
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
      filteredExpensesTypes = widget.expensesTypes.where((type) {
        if (type == null) return false;
        final name = (type.name ?? '').toLowerCase();
        return name.contains(query);
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
            context.expenseType,
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
              itemCount: filteredExpensesTypes.length,
              separatorBuilder: (context, index) => 4.verticalSizedBox,
              itemBuilder: (context, index) {
                final type = filteredExpensesTypes[index];
                if (type == null) return const SizedBox();
                final isSelected = widget.selectedExpensesTypeId == type.id;

                return InkWell(
                  onTap: () => widget.onExpensesTypeSelected(type),
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    padding: 14.allPadding,
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
                            type.name ?? '',
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
