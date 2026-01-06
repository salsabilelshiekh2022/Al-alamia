import 'package:alalamia/core/helper/app_extention.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/card_with_gray_border.dart';
import '../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../generated/app_assets.dart';
import '../../../data/models/notification_model.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.notification});
  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return CardWithGrayBorder(
      child: Row(
        children: [
          CustomSvgBuilder(
            path: AppAssets.svgsPurpleStarIcon,
            width: 30,
            height: 30,
            fit: BoxFit.scaleDown,
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: context.textStyles.font14SemiBoldSecondaryColor,
                ),
                5.verticalSpace,
                Text(
                  notification.body,
                  maxLines: 2,
                  style: context.textStyles.font14RegularGrayColor.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          35.verticalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TransactionStatusBox(status: StatusEnum.pending),
              // 22.verticalSpace,
              Text(
                DateFormat(
                      'dd-MM-yyyy, hh:mm a',
                      EasyLocalization.of(context)!.locale.languageCode,
                    )
                    .format(
                      DateFormat(
                        'dd-MM-yyyy HH:mm:ss',
                      ).parse(notification.createdAt),
                    )
                    .toString(),
                style: context.textStyles.font14MediumGrayColor.copyWith(
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
