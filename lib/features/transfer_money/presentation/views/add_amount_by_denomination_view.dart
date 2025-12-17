import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/features/transfer_money/presentation/views/widgets/all_denominations_bottom_sheet.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../core/helper/app_extention.dart';
import '../../../../generated/app_assets.dart';
import '../../data/models/transfer_money_request_params.dart';

class AddAmountByDenominationView extends StatelessWidget {
  const AddAmountByDenominationView({super.key,});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ادخل المبلغ بالفئات", style: context.textStyles.font18SemiBoldSecondaryColor,),
        centerTitle: true,
        leading:Padding(
        padding: const EdgeInsetsDirectional.only(start: 16),
        child: InkWell(
          onTap: () => context.pop(),
          child: CustomSvgBuilder(
            path: AppAssets.svgsArrowBtnIcon,
            width: 44,
            height: 44,
            color: context.colors.secondaryColor,
            fit: BoxFit.contain,
          ),
        ),
      ),
      ),
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("المبلغ قبل التحويل", style: context.textStyles.font16MediumSecondaryColor,),
            14.verticalSizedBox,
            AllDenominationsBottomSheet(amount: 100, onConfirm: (List<DenominationsRequestParams> denominations) {},showTitle: false,),
              Text("المبلغ بعد التحويل", style: context.textStyles.font16MediumSecondaryColor,),
            14.verticalSizedBox,
            AllDenominationsBottomSheet(amount: 100, onConfirm: (List<DenominationsRequestParams> denominations) {},showTitle: false,),
          ],
        ).allPadding(16),
      )
    );
  }
}