import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/features/transactions/data/models/transaction_model.dart';
import 'package:flutter/material.dart';

import '../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../generated/app_assets.dart';

class TransactionFromTo extends StatelessWidget {
  const TransactionFromTo({super.key, required this.transactionModel});
  final TransactionModel  transactionModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${context.from}:", style:  context.textStyles.font14RegularGrayColor,),
              Text(transactionModel.client!.fromClient!.name!, style:  context.textStyles.font14RegularSecondaryColor,).verticalPadding(8),
              Text(transactionModel.client!.fromClient!.phone!, style:  context.textStyles.font14RegularGrayColor,),
          ],
        ),
        CustomSvgBuilder(path: AppAssets.svgsDoubleArrowIcon, width: 24, height: 24,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${context.to}:", style:  context.textStyles.font14RegularGrayColor,),
              Text(transactionModel.client!.toClient!.name!, style:  context.textStyles.font14RegularSecondaryColor,).verticalPadding(8),
              Text(transactionModel.client!.toClient!.phone!, style:  context.textStyles.font14RegularGrayColor,),
          ],
        ),
      

      ],
    );
  }
}

