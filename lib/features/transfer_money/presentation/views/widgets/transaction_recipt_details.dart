import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class TransactionReciptDetails extends StatelessWidget {
  const TransactionReciptDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 20.allPadding,
      margin: EdgeInsets.symmetric(horizontal: 16),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: context.colors.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadows: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 64,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.transactionDetails,
            style: context.textStyles.font16SemiBoldSecondaryColor,
          ),
          20.verticalSizedBox,
          _buildInfoRow(
            context,
            title: context.transactionNumber,
            value: "TXN-2024-031501",
          ),
          _buildInfoRow(
            context,
            title: context.date,
            value: "2024-10-05, 12:30 م",
          ),
          _buildInfoRow(context, title: context.resource, value: "22-544"),
          _buildInfoRow(context, title: context.destination, value: "56-456"),
          _buildInfoRow(context, title: context.sender, value: "احمد محمد"),
          _buildInfoRow(
            context,
            title: context.beneficiaryName,
            value: "احمد محمد",
          ),
          _buildBorder(context),
          _buildInfoRow(
            context,
            title: context.transeferedAmount,
            value: "EGP 4,850",
          ),
          _buildInfoRow(context, title: context.commission, value: "USD 15.00"),
          _buildInfoRow(
            context,
            title: context.exchangeRate,
            value: "EGP 48.50",
          ),
          _buildBorder(context),
          _buildTotal(context),
        ],
      ),
    );
  }

  Widget _buildTotal(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
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
            "EGP 4,865.00",
            style: context.textStyles.font16MediumPrimaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildBorder(BuildContext context) {
    return DottedBorder(
      options: CustomPathDottedBorderOptions(
        padding: EdgeInsets.zero,
        color: Color(0xff9B9B9B).withValues(alpha: 0.2),
        strokeWidth: 1.5,
        dashPattern: [5, 3],
        customPath: (size) => Path()
          ..moveTo(0, 0)
          ..lineTo(size.width, 0),
      ),
      child: SizedBox(width: double.infinity, height: 0),
    ).onlyPadding(bottomPadding: 22);
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required String title,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: context.textStyles.font15MediumGrayColor),
        Text(value, style: context.textStyles.font15MediumSecondaryColor),
      ],
    ).onlyPadding(bottomPadding: 22);
  }
}
