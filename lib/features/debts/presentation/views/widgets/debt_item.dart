import 'package:alalamia/core/enums/debets_enum.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/features/debts/data/models/debt_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/helper/app_extention.dart';
import '../../../../../core/helper/number_extentions.dart';
import '../../../../transactions/presentation/views/widgets/transactions_details/card_with_shadow.dart';

class DebtItem extends StatelessWidget {
  const DebtItem({
    super.key,
    required this.debtModel,
    required this.debetsTypeEnum,
  });
  final DebtModel debtModel;
  final DebetsTypeEnum debetsTypeEnum;

  @override
  Widget build(BuildContext context) {
    return CardWithShadow(
      borderRadius: 14,
      padding: 14,
      child: Column(
        children: [
          _buildStatus(context),
          20.verticalSizedBox,
          _buildUserPhoneAndAmount(context),
          9.verticalSizedBox,
          _buildUserNameAndDate(context),
          16.verticalSizedBox,
          debtModel.note == null
              ? SizedBox()
              : _buildNotes(context),
        ],
      ),
    );
  }

  Widget _buildNotes(BuildContext context) {
    return Container(
                padding: 10.allPadding,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: 10.allBorderRadius,
                  color: context.colors.backgroundFieldColor,
                ),
                child: Text(
                  "${context.purpose}: ${debtModel.note}",
                  style: context.textStyles.font14MediumGrayColor,
                ),
              );
  }

  Widget _buildUserNameAndDate(BuildContext context) {
    return Row(
          children: [
            Text(
              debetsTypeEnum == DebetsTypeEnum.debt_inside
                  ? debtModel.employee?.name ?? ""
                  : debtModel.user?.name ?? "",
              style: context.textStyles.font14MediumGrayColor,
            ),
            Spacer(),
            Text(
              DateFormat(
                'd MMMM yyyy',
                EasyLocalization.of(context)!.locale.languageCode,
              ).format(debtModel.createdAt ?? DateTime.now()),
              style: context.textStyles.font14MediumGrayColor,
            ),
          ],
        );
  }

  Widget _buildUserPhoneAndAmount(BuildContext context) {
    return Row(
          children: [
            Text(
              debetsTypeEnum == DebetsTypeEnum.debt_inside
                  ? debtModel.employee?.phone ?? ""
                  : debtModel.user?.phone ?? "",
              style: context.textStyles.font15SemiBoldSecondaryColor,
            ),
            Spacer(),
            Text(
              "${debtModel.amount?.toString()} ${debtModel.currency?.code ?? ""}",
              style: context.textStyles.font15SemiBoldSecondaryColor,
            ),
          ],
        );
  }

  Widget _buildStatus(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.5, vertical: 5),
          decoration: BoxDecoration(
            color: context.colors.primaryColor.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            debtModel.type?.translate(context) ?? "",
            style: context.textStyles.font14MediumPrimaryColor,
          ),
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.5, vertical: 5),
          decoration: BoxDecoration(
            color: debtModel.status?.chooseColor(context).withValues(alpha: 0.05) ?? Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            debtModel.status?.translate(context) ?? "",
            style: context.textStyles.font14MediumPrimaryColor.copyWith(
              color: debtModel.status?.chooseColor(context) ?? Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
