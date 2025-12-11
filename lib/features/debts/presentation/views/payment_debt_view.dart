import 'package:alalamia/core/components/widgets/custom_page.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'widgets/pay_debt_form.dart';

class PaymentDebtView extends StatelessWidget {
  const PaymentDebtView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: context.paymentDebt,
      hasActions: false,
      isBack: true,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      body: PayDebtForm(),
    );
  }
}
