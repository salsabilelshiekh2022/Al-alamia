import 'package:alalamia/core/enums/debets_enum.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/routes/routes.dart';
import 'package:alalamia/features/debts/presentation/views/widgets/debt_card_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/components/widgets/main_button.dart';

class DebtsBottomSheet extends StatefulWidget {
  const DebtsBottomSheet({super.key});

  @override
  State<DebtsBottomSheet> createState() => _DebtsBottomSheetState();
}

class _DebtsBottomSheetState extends State<DebtsBottomSheet> {
  DebetsEnum? selectedDebt = DebetsEnum.requestDebt;

  void _onDebtSelected(DebetsEnum debt) {
    setState(() {
      selectedDebt = debt;
    });
  }

  void _navigateToDebtView() {
    if (selectedDebt == null) return;
    context.pop();
    final route = selectedDebt == DebetsEnum.requestDebt
        ? Routes.requestDeptView
        : Routes.paymentDeptView;
    context.pushNamed(route);
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
          context.requestPaymentDebt,
          style: context.textStyles.font15RegularGrayColor,
          textAlign: TextAlign.center,
        ),
        32.verticalSizedBox,
        Row(
          children: [
            Expanded(
              child: DebtCardWidget(
                debets: DebetsEnum.requestDebt,
                isSelected: selectedDebt == DebetsEnum.requestDebt,
                onTap: () => _onDebtSelected(DebetsEnum.requestDebt),
              ),
            ),
            16.horizontalSizedBox,
            Expanded(
              child: DebtCardWidget(
                debets: DebetsEnum.paymentDebt,
                isSelected: selectedDebt == DebetsEnum.paymentDebt,
                onTap: () => _onDebtSelected(DebetsEnum.paymentDebt),
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
