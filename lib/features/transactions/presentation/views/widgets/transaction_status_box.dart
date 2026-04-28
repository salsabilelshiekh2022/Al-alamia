import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/enums/status_enum.dart';

class TransactionStatusBox extends StatelessWidget {
  const TransactionStatusBox({super.key, required this.status});
  final StatusEnum status;





  @override
  Widget build(BuildContext context) {
    return Container(
     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12.5),
      decoration: BoxDecoration(
        color:status.chooseColor(context).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        status.translate(context),
        style: context.textStyles.font14MediumSecondaryColor.copyWith(
          color: status.chooseColor(context),
        ),
      ).center(),
    );
  }
}

