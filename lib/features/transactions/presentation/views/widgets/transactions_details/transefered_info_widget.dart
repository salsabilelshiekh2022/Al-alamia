import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../../generated/app_assets.dart';
import '../../../cubit/transactions_cubit.dart';
import '../../../cubit/transactions_state.dart';
import 'card_with_shadow.dart';

class TransferredAmountInfoWidget extends StatelessWidget {
  const TransferredAmountInfoWidget({super.key});

  static const double _horizontalPadding = 30.0;
  static const double _verticalSpacing = 10.0;
  static const double _sectionSpacing = 20.0;
  static const double _dividerPadding = 14.0;
  static const double _iconSize = 20.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsCubit, TransactionsState>(
      builder: (context, state) {
        final details = state.transactionDetails;
        bool isInOutTransaction = state.transactionDetails?.details?.transactionType?.toLowerCase() == 'in_out';
        
        return   isInOutTransaction  ?   _buildInOutTransactionCard(context) : CardWithShadow(
          child: Column(
            children: [
              _buildAmountSection(context, details),
              _sectionSpacing.verticalSizedBox,
              _buildDivider(context),
              _buildBranchSection(context, details),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAmountSection(BuildContext context, dynamic details) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildAmountColumn(
          context,
          label: context.transeferedAmount,
          amount: details?.amount ?? '--',
          currency: details?.currency ?? '--',
        ),
        _buildArrowIcon(context),
        _buildAmountColumn(
          context,
          label: context.amount,
          amount: details?.amount ?? '--',
          currency: details?.toCurrency ?? '--',
        ),
      ],
    ).horizontalPadding(_horizontalPadding);
  }

  Widget _buildAmountColumn(
    BuildContext context, {
    required String label,
    required String amount,
    required String currency,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: context.textStyles.font15MediumGrayColor,
        ),
        _verticalSpacing.verticalSizedBox,
        Text(
          amount,
          style: context.textStyles.font14RegularSecondaryColor,
        ),
        _verticalSpacing.verticalSizedBox,
        Text(
          currency,
          style: context.textStyles.font14RegularSecondaryColor,
        ),
      ],
    );
  }

  Widget _buildBranchSection(BuildContext context, dynamic details) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildBranchColumn(
          context,
          branchName: details?.fromBranch.name ?? '--',
        ),
        _buildArrowIcon(context),
        _buildBranchColumn(
          context,
          branchName: details?.toBranch.name ?? '--',
        ),
      ],
    ).horizontalPadding(_horizontalPadding);
  }

  Widget _buildBranchColumn(
    BuildContext context, {
    required String branchName,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomSvgBuilder(
          path: AppAssets.svgsMapIcon,
          width: _iconSize,
          height: _iconSize,
          fit: BoxFit.scaleDown,
        ),
        _verticalSpacing.verticalSizedBox,
        Text(
          branchName,
          style: context.textStyles.font14RegularSecondaryColor,
        ),
      ],
    );
  }

  Widget _buildArrowIcon(BuildContext context) {
    return Icon(
      Icons.arrow_forward_sharp,
      color: context.colors.primaryColor,
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(
      color: context.colors.strokeColor,
      thickness: 1,
    ).verticalPadding(_dividerPadding).horizontalPadding(_sectionSpacing);
  }

  Widget _buildInOutTransactionCard(BuildContext context) {
    return BlocBuilder<TransactionsCubit, TransactionsState>(
      builder: (context, state) {
        return CardWithShadow(
          child: Column(
            children: [
              Text("المبلغ المرسل", style: context.textStyles.font15MediumGrayColor),
              14.verticalSizedBox,
              Text(state.transactionDetails?.amount ?? '--', style: context.textStyles.font24BoldSecondaryColor),
               6.verticalSizedBox,
               Text(state.transactionDetails?.currency ?? '--', style: context.textStyles.font14RegularPrimaryColor),
                _buildDivider(context),
                _buildBranchSection(context, context.watch<TransactionsCubit>().state.transactionDetails),
            ],
          )  );
      },
    );
  }
}

