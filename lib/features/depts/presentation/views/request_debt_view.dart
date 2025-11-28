import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

class RequestDebtView extends StatelessWidget {
  const RequestDebtView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.requestDebt,
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
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.request_quote_outlined,
                size: 80,
                color: context.colors.primaryColor,
              ),
              const SizedBox(height: 24),
              Text(
                context.requestDebt,
                style: context.textStyles.font18SemiBoldSecondaryColor,
              ),
              const SizedBox(height: 16),
              Text(
                'Request debt functionality will be implemented here',
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
