import 'package:alalamia/core/general/cubit/general_cubit.dart';
import 'package:alalamia/core/general/cubit/general_state.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/widgets/card_with_purple_shadow.dart';

class FeeDetailsCard extends StatelessWidget {
  const FeeDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeneralCubit, GeneralState>(
      builder: (context, state) {
        return CardWithPurpleShadow(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.chargeDetails,
                style: context.textStyles.font16SemiBoldSecondaryColor,
              ),
              12.verticalSizedBox,
              _buildInfo(
                context,
                title: context.transferAmount,
                value: state.feeDetails?.convertedAmount?.toString() ?? "0.00",
              ),
              _buildInfo(
                context,
                title: context.commission,
                value: state.feeDetails?.commissionAmount?.toString() ?? "0.00",
              ),
             _buildInfo(
                    context,
                    title: context.exchangeRate,
                    value:
                       state.feeDetails?.exchangePrice?.toString()
                             ??
                        "0.00",
                  ),
                
              
              Divider(color: context.colors.grayColor.withValues(alpha: 0.35)),
              12.verticalSizedBox,
              Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                decoration: BoxDecoration(
                  color: context.colors.primaryColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: context.colors.primaryColor.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.total,
                      style: context.textStyles.font15MediumPrimaryColor,
                    ),
                    Text(
                      state.feeDetails?.finalAmount?.toString() ?? "0.00",
                      style: context.textStyles.font16MediumPrimaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfo(
    BuildContext context, {
    required String title,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: context.textStyles.font15MediumGrayColor),
        Text(
          value,
          style: context.textStyles.font17MediumPrimaryColor.copyWith(
            color: context.colors.secondaryColor,
          ),
        ),
      ],
    ).onlyPadding(bottomPadding: 20);
  }
}
