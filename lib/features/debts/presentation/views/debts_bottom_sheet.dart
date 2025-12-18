import 'package:alalamia/core/enums/debets_enum.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/routes/routes.dart';
import 'package:alalamia/features/debts/presentation/views/widgets/debt_card_widget.dart';
import 'package:alalamia/generated/app_assets.dart';
import 'package:flutter/material.dart';

import '../../../../../core/components/widgets/main_button.dart';

class DebtsBottomSheet extends StatefulWidget {
  const DebtsBottomSheet({super.key});

  @override
  State<DebtsBottomSheet> createState() => _DebtsBottomSheetState();
}

class _DebtsBottomSheetState extends State<DebtsBottomSheet> {
  DebetsTypeEnum? selectedDebt = DebetsTypeEnum.debt_inside;

  void _onDebtSelected(DebetsTypeEnum debt) {
    setState(() {
      selectedDebt = debt;
    });
  }

  void _navigateToDebtView() {
    if (selectedDebt == null) return;
    context.pop();
    final route = selectedDebt == DebetsTypeEnum.debt_inside
        ? Routes.debtsView
        : Routes.debtsView;
    context.pushNamed(route, arguments: selectedDebt);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.debts,
          style: context.textStyles.font18SemiBoldSecondaryColor,
        ),
        8.verticalSizedBox,
        Text(
          context.requestDebtInOut,
          style: context.textStyles.font15RegularGrayColor,
          textAlign: TextAlign.center,
        ),
        32.verticalSizedBox,
        Row(
          children: [
            Expanded(
              child: DebtCardWidget(
                imagePath:AppAssets.svgsSendMoneyIcon ,
                debets: DebetsTypeEnum.debt_inside,
                isSelected: selectedDebt == DebetsTypeEnum.debt_inside,
                onTap: () => _onDebtSelected(DebetsTypeEnum.debt_inside),
              ),
            ),
            16.horizontalSizedBox,
            Expanded(
              child: DebtCardWidget(
                  imagePath:AppAssets.svgsSendMoneyIcon ,
                debets: DebetsTypeEnum.debt_outside,
                isSelected: selectedDebt == DebetsTypeEnum.debt_outside,
                onTap: () => _onDebtSelected(DebetsTypeEnum.debt_outside),
              ),
            ),
          ],
        ),
        40.verticalSizedBox,
        MainButton(title: context.next, onTap: _navigateToDebtView),
        32.verticalSizedBox,
      ],
    );
  }
}
