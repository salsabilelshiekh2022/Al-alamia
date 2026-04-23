import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/features/transactions/presentation/cubit/transactions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../../generated/app_assets.dart';
import '../../../cubit/transactions_state.dart';
import 'card_with_shadow.dart';
import 'total_section.dart';

class TransactionInfoCard extends StatelessWidget {
  const TransactionInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsCubit, TransactionsState>(
      builder: (context, state) {
        bool isInOutTransaction =
            state.transactionDetails?.details?.transactionType?.toLowerCase() ==
            'in_out';
        return isInOutTransaction ? buildInOutTransactionCard(context) : CardWithShadow(
          child: Column(
            children: [
              Row(
                children: [
                  CustomSvgBuilder(
                    path: AppAssets.svgsTransactionInfoIcon,
                    width: 24,
                    height: 24,
                    fit: BoxFit.scaleDown,
                  ),
                  10.horizontalSpace,
                  Text(
                    context.transactionInfo,
                    style: context.textStyles.font16MediumSecondaryColor,
                  ),
                ],
              ),
              17.verticalSizedBox,
              _buildInfoRow(
                context: context,
                title: context.transactionCode,
                value:
                    state.transactionDetails?.details?.transactionUuid ?? '--',
              ),
              14.verticalSizedBox,
              _buildInfoRow(
                context: context,
                title: context.transactionType,
                value:
                    state.transactionDetails?.details?.transactionType ?? '--',
              ),
              Divider(color: context.colors.strokeColor).verticalPadding(14),
              _buildInfoRow(
                context: context,
                title: context.commission,
                value:
                    state.transactionDetails?.details?.totalCommissionValue ??
                    '--',
              ),
              14.verticalSizedBox,
              _buildInfoRow(
                context: context,
                title: context.commissionType,
                value:
                    state.transactionDetails?.details?.commissionType
                        ?.getCommissionType(context) ??
                    '--',
              ),
              14.verticalSizedBox,
              _buildInfoRow(
                context: context,
                title: context.amountSent,
                value: state.transactionDetails?.details?.amountSent ?? '--',
              ),
              14.verticalSizedBox,
              _buildInfoRow(
                context: context,
                title: context.amountByChar,
                value:
                    state.transactionDetails?.details?.amountCharacter ?? '--',
              ),
              14.verticalSizedBox,
              _buildInfoRow(
                context: context,
                title: context.exchangeRate,
                value: state.transactionDetails?.details?.exchangeRate ?? '--',
              ),
              14.verticalSizedBox,
              _buildInfoRow(
                context: context,
                title: context.fee,
                value:
                    state.transactionDetails?.details?.transferFees
                        .toString() ??
                    '--',
              ),
              Divider(color: context.colors.strokeColor).verticalPadding(14),
              TotalSection(
                value:
                    state.transactionDetails?.details?.totalAmount
                        ?.toStringAsFixed(2) ??
                    '--',
              ),
            ],
          ),
        );
      },
    );
  }

  Row _buildInfoRow({
    required BuildContext context,
    required String title,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.textStyles.font16MediumSecondaryColor.copyWith(
            color: context.colors.grayColor,
          ),
        ),
        Text(value, style: context.textStyles.font16MediumSecondaryColor),
      ],
    );
  }

  Widget buildInOutTransactionCard(BuildContext context) {
    return BlocBuilder<TransactionsCubit, TransactionsState>(
      builder: (context, state) {
        return CardWithShadow(
          child: Column(
            children: [
              Row(
                children: [
                  CustomSvgBuilder(
                    path: AppAssets.svgsTransactionInfoIcon,
                    width: 24,
                    height: 24,
                    fit: BoxFit.scaleDown,
                  ),
                  10.horizontalSpace,
                  Text(
                    context.transactionInfo,
                    style: context.textStyles.font16MediumSecondaryColor,
                  ),
                ],
              ),
              17.verticalSizedBox,
              _buildInfoRow(
                context: context,
                title: context.transactionCode,
                value:
                    state.transactionDetails?.details?.transactionUuid ?? '--',
              ),
              14.verticalSizedBox,
              _buildInfoRow(
                context: context,
                title: context.transactionType,
                value:
                   "دخول / خروج",
              ),
            ],
          ),
        );
      },
    );
  }
}
