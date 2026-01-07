import 'package:alalamia/core/components/widgets/custom_text_field.dart';
import 'package:alalamia/core/general/data/models/branch_model.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/generated/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BranchSelectionBottomSheet extends StatefulWidget {
  const BranchSelectionBottomSheet({
    super.key,
    required this.branches,
    required this.onBranchSelected,
    this.selectedBranchId,
  });

  final List<BranchModel?> branches;
  final ValueChanged<BranchModel> onBranchSelected;
  final int? selectedBranchId;

  @override
  State<BranchSelectionBottomSheet> createState() =>
      _BranchSelectionBottomSheetState();
}

class _BranchSelectionBottomSheetState
    extends State<BranchSelectionBottomSheet> {
  late List<BranchModel?> filteredBranches;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredBranches = widget.branches;
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
      filteredBranches = widget.branches.where((branch) {
        if (branch == null) return false;
        final name = (branch.name ?? '').toLowerCase();
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
            context.destination,
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
              itemCount: filteredBranches.length,
              separatorBuilder: (context, index) => 4.verticalSizedBox,
              itemBuilder: (context, index) {
                final branch = filteredBranches[index];
                if (branch == null) return const SizedBox();
                final isSelected = widget.selectedBranchId == branch.id;

                return InkWell(
                  onTap: () => widget.onBranchSelected(branch),
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
                            branch.name ?? '',
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
