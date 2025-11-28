import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

class PaymentDebtView extends StatelessWidget {
  const PaymentDebtView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.paymentDebt,
          style: context.textStyles.font18SemiBoldSecondaryColor,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: context.colors.secondaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.payment_outlined,
                size: 80,
                color: context.colors.primaryColor,
              ),
              const SizedBox(height: 24),
              Text(
                context.paymentDebt,
                style: context.textStyles.font18SemiBoldSecondaryColor,
              ),
              const SizedBox(height: 16),
              Text(
                'Payment debt functionality will be implemented here',
                style: context.textStyles.font15RegularGrayColor,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
