import 'package:alalamia/core/enums/commission_type_enum.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommissionTypeSelectionBottomSheet extends StatelessWidget {
  const CommissionTypeSelectionBottomSheet({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  final CommissionTypeEnum? selectedType;
  final ValueChanged<CommissionTypeEnum> onTypeSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.h,
      child: Column(
        children: [
          Text(
            context.commissionType, 
            style: context.textStyles.font18BoldSecondaryColor,
          ),
          16.verticalSizedBox,
          Expanded(
            child: ListView.separated(
              itemCount: CommissionTypeEnum.values.length,
              separatorBuilder: (context, index) => 8.verticalSizedBox,
              itemBuilder: (context, index) {
                final type = CommissionTypeEnum.values[index];
                final isSelected = selectedType == type;

                return InkWell(
                  onTap: () => onTypeSelected(type),
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
                    child: Text(
                      type.getCommissionType(context),
                      style: isSelected
                          ? context.textStyles.font16MediumPrimaryColor
                          : context.textStyles.font16MediumSecondaryColor,
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
