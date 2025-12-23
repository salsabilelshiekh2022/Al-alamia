import 'package:alalamia/core/components/widgets/custom_page.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/features/reports/presentation/views/widgets/reports_filter_type.dart';
import 'package:alalamia/generated/app_assets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/app_extention.dart';
import 'widgets/debts_in_reports.dart';
import 'widgets/deficit_and_surplus_widget.dart';
import 'widgets/expenses_in_reports.dart';
import 'widgets/wallet_in_reports.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: context.reports,
      hasActions: false,
      isBack: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReportsFilterType(),
          18.verticalSizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.imagesCalendar,
                width: 20,
                height: 20,
                fit: BoxFit.scaleDown,
              ),
              4.horizontalSizedBox,
              Text(
                DateFormat(
                  'EEEE, d MMMM yyyy',
                  EasyLocalization.of(context)!.locale.languageCode,
                ).format(DateTime.now()),
                style: context.textStyles.font14MediumPrimaryColor,
              ),
            ],
          ),
          8.verticalSizedBox,
          WalletInReports(),
          4.verticalSizedBox,
          ExpensesInReports(),
          4.verticalSizedBox,
          DebtsInReports(),
          14.verticalSizedBox,
          DeficitAndSurplusWidget(),
          100.verticalSizedBox,
        ],
      ),
    );
  }
}

