import 'package:alalamia/core/components/widgets/custom_page.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/utils/global_ui_utils.dart';
import 'package:alalamia/features/send_money/presentation/views/widgets/send_money_successfully_dialog.dart';
import 'package:flutter/material.dart';
import '../../../../core/components/widgets/main_button.dart';
import 'widgets/fee_details_card.dart';
import 'widgets/notes_card.dart';
import 'widgets/transaction_details_card.dart';

class SendMoneySecondStepView extends StatelessWidget {
  const SendMoneySecondStepView({super.key});
 

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: context.sendMoney,
      hasActions: false,
      isBack: true,
      body: Column(
        children: [
          _stepHeader(context),
          12.verticalSizedBox,
          _progressBar(context),
          24.verticalSizedBox,
          TransactionDetailsCard(),
          20.verticalSizedBox,
          NotesCard(),
          20.verticalSizedBox,
          FeeDetailsCard(),
          24.verticalSizedBox,
          MainButton(
            title: context.confirm,
            onTap: () {
              context.pop();
              context.pop();
              GlobalUiUtils.showCustomDialog(
                context,
                child: SendMoneySuccessfullyDialog(),
              );
            },
          ),
          32.verticalSizedBox,
        ],
      ),
    );
  }

  Widget _progressBar(BuildContext context) {
    return Container(
      height: 10,
      width: context.width,
      decoration: BoxDecoration(
        borderRadius: 24.allBorderRadius,
        gradient: context.colors.navigationGradientColor,
      ),
    );
  }

  Row _stepHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "2 ${context.from} 2",
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
