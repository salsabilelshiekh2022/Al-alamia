import 'package:alalamia/features/send_money/presentation/views/widgets/send_money_card.dart';
import 'package:flutter/material.dart';

import '../../../../../core/components/widgets/main_button.dart';
import '../../../../../core/enums/delivery_type_enum.dart';
import '../../../../../core/helper/app_extention.dart';
import '../../../../../core/helper/number_extentions.dart';
import '../../../../../core/helper/translation_extensions.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../generated/app_assets.dart';

class SendMoneyBottomSheet extends StatefulWidget {
  const SendMoneyBottomSheet({super.key});

  @override
  State<SendMoneyBottomSheet> createState() =>
      _SendMoneyBottomSheetState();
}

class _SendMoneyBottomSheetState extends State<SendMoneyBottomSheet> {
  DeliveryTypeEnum? selectedDeliveryType = DeliveryTypeEnum.inside;

  void _onTabSelected(DeliveryTypeEnum type) {
    setState(() {
      selectedDeliveryType = type;
    });
  }

  void _navigateToSendMoneyView() {
    if (selectedDeliveryType == null) return;
    context.pop();
    final route = selectedDeliveryType == DeliveryTypeEnum.inside
        ? Routes.sendMoneyFristStepView
        : Routes.sendMoneyFristStepView;
    context.pushNamed(route, arguments: selectedDeliveryType );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.sendMoney,
          style: context.textStyles.font18SemiBoldSecondaryColor,
        ),
        8.verticalSizedBox,
        Text(
          context.internalExternalDelivery,
          style: context.textStyles.font15RegularGrayColor,
          textAlign: TextAlign.center,
        ),
        32.verticalSizedBox,
        Row(
          children: [
            Expanded(
              child: SendMoneyCardWidget(
                imagePath: AppAssets.svgsSendMoneyIcon,
                type: DeliveryTypeEnum.inside,
                isSelected: selectedDeliveryType == DeliveryTypeEnum.inside,
                onTap: () => _onTabSelected(DeliveryTypeEnum.inside),
              ),
            ),
            16.horizontalSizedBox,
            Expanded(
              child: SendMoneyCardWidget(
                imagePath: AppAssets.svgsSendMoneyIcon,
                type: DeliveryTypeEnum.outside,
                isSelected: selectedDeliveryType == DeliveryTypeEnum.outside,
                onTap: () => _onTabSelected(DeliveryTypeEnum.outside),
              ),
            ),
          ],
        ),
        40.verticalSizedBox,
        MainButton(title: context.next, onTap: _navigateToSendMoneyView),
        32.verticalSizedBox,
      ],
    );
  }
}
