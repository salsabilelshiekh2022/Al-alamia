import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../../generated/app_assets.dart';
import 'card_with_shadow.dart';
import 'info_widget.dart';

class BeneficiaryInfoCard extends StatelessWidget {
  const BeneficiaryInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWithShadow(child: Column(
      children: [
        Row(
          children: [
            CustomSvgBuilder(path: AppAssets.svgsCheckUserIcon, width: 24, height: 24, fit: BoxFit.scaleDown,),
            10.horizontalSpace,
            Text(context.beneficiary, style: context.textStyles.font16MediumSecondaryColor,),
          ],
        ),
        14.verticalSizedBox,
        InfoWidget( title: context.fullName, value: "احمد محمد", icon: AppAssets.svgsUser,),
        24.verticalSizedBox,
       InfoWidget(title:context.id, value: "123456789xx", icon: AppAssets.svgsIdIcon,),
        24.verticalSizedBox,
        InfoWidget( title: context.phone, value: "+20 115 4568 456", icon: AppAssets.svgsPhone,),
         24.verticalSizedBox,
        InfoWidget( title: context.phone2 , value: "+20 115 4568 456", icon: AppAssets.svgsAdditionalPhoneIcon,),
         24.verticalSizedBox,
        InfoWidget( title: context.address, value: "عنوان الشارع والرمز البريدي", icon: AppAssets.svgsMapIcon,),
      ],
    ));
  }
}

