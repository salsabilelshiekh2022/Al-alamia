import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/features/home/data/models/denominations_model.dart';
import 'package:flutter/material.dart';

class DenominationListItem extends StatelessWidget {
  const DenominationListItem({super.key, required this.denomination});

  final DenominationsModel denomination;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              denomination.value ?? '0',
              textAlign: TextAlign.start,
              style: context.textStyles.font16SemiBoldSecondaryColor,
            ),
          ),
        ),
           Container(
                  width: 1,
                  height: 20,
                  color: context.colors.grayColor,
                ),
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.center,
            child: Text(
              '${denomination.quantity ?? 0}',
              textAlign: TextAlign.center,
              style: context.textStyles.font16SemiBoldSecondaryColor,
            ),
          ),
        ),
          Container(
                  width: 1,
                  height: 20,
                  color: context.colors.grayColor,
                ),
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerEnd,
            child: Text(
              '${denomination.total ?? 0}',
              textAlign: TextAlign.end,
              style: context.textStyles.font16SemiBoldSecondaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
