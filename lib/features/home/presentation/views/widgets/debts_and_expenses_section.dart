import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/utils/global_ui_utils.dart';
import '../../../../../generated/app_assets.dart';
import '../../../../debts/presentation/views/debts_bottom_sheet.dart';

class DebtsAndExpensesSection extends StatelessWidget {
  const DebtsAndExpensesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildItem(
          context,
          title: context.expenses,
          icon: AppAssets.svgsCash,
          onTap: () {
            context.pushNamed(Routes.
            expensesListView);
          },
        ),
        12.horizontalSizedBox,
        _buildItem(
          context,
          title: context.debts,
          icon: AppAssets.svgsWallet,
          onTap: () =>
              GlobalUiUtils.showBottomSheet(context, child: DebtsBottomSheet()),
        ),
      ],
    );
  }

  Widget _buildItem(
    BuildContext context, {
    required String title,
    required String icon,
    required void Function() onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: 16.vPadding,
          decoration: BoxDecoration(
            color: context.colors.primaryColor.withValues(alpha: 0.1),
            borderRadius: 12.allBorderRadius,
            border: Border.all(
              color: context.colors.primaryColor.withValues(alpha: 0.16),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomSvgBuilder(
                path: icon,
                width: 24,
                height: 24,
                color: context.colors.primaryColor,
              ),
              6.horizontalSizedBox,
              Text(title, style: context.textStyles.font14SemiBoldPrimaryColor),
            ],
          ),
        ),
      ),
    );
  }
}
