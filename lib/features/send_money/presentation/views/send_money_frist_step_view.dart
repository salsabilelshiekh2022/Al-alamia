import 'package:alalamia/core/components/widgets/custom_page.dart';
import 'package:alalamia/core/components/widgets/main_button.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/routes/routes.dart';
import 'widgets/beneficiary_data_card.dart';
import 'widgets/sender_data_card.dart';

class SendMoneyFristStepView extends StatelessWidget {
  const SendMoneyFristStepView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: context.sendMoney,
      hasActions: false,
      isBack: true,
      padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      body: Column(
        children: [
          _stepHeader(context),

          12.verticalSizedBox,
          _progressBar(context),
          24.verticalSizedBox,

          SenderDataCard(),
          20.verticalSizedBox,
          BeneficiaryDataCard(),
          24.verticalSizedBox,
          MainButton(
            title: context.next,
            onTap: () {
              context.pushNamed(Routes.sendMoneySecondStepView);
            },
          ),
          32.verticalSizedBox,
        ],
      ),
    );
  }

  Stack _progressBar(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 10,
          decoration: BoxDecoration(
            borderRadius: 24.allBorderRadius,
            color: Color(0xffE2E2E2),
          ),
        ),
        Container(
          height: 10,
          width: context.width * 0.5,
          decoration: BoxDecoration(
            borderRadius: 24.allBorderRadius,
            gradient: context.colors.navigationGradientColor,
          ),
        ),
      ],
    );
  }

  Row _stepHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "1 ${context.from} 2",
          style: context.textStyles.font14SemiBoldPrimaryColor.copyWith(
            color: Color(0xff3E1A74).withValues(alpha: 0.8),
          ),
        ),
        Text(
          context.transactionDetails,
          style: context.textStyles.font14SemiBoldPrimaryColor.copyWith(
            color: Color(0xff3E1A74).withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}
