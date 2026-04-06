import 'package:alalamia/core/components/widgets/custom_page.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/features/reports/presentation/cubit/reports_cubit.dart';
import 'package:alalamia/features/reports/presentation/cubit/reports_state.dart';
import 'package:alalamia/features/reports/presentation/views/widgets/reports_filter_type.dart';
import 'package:alalamia/generated/app_assets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/app_extention.dart';
import 'widgets/debts_in_reports.dart';
import 'widgets/expenses_in_reports.dart';
import 'widgets/wallet_in_reports.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  Future<void> _selectDate(BuildContext context) async {
    final reportsCubit = context.read<ReportsCubit>();
    final currentDate = reportsCubit.state.selectedDate ?? DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      locale: EasyLocalization.of(context)!.locale,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: context.colors.primaryColor,
              onPrimary: context.colors.whiteColor,
              onSurface: context.colors.primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      reportsCubit.updateSelectedDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: context.reports,
      hasActions: false,
      isBack: false,
      actionWidget: InkWell(
     child: Image.asset(AppAssets.svgsShareIcon
     ),),
      body: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReportsFilterType(),
          18.verticalSizedBox,
          BlocBuilder<ReportsCubit, ReportsState>(
            builder: (context, state) {
              final displayDate = state.selectedDate ?? DateTime.now();

              return InkWell(
                onTap: () => _selectDate(context),
                child: Row(
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
                      ).format(displayDate),
                      style: context.textStyles.font14MediumPrimaryColor,
                    ),
                  ],
                ),
              );
            },
          ),
          8.verticalSizedBox,
          WalletInReports(),
          4.verticalSizedBox,
          ExpensesInReports(),
          4.verticalSizedBox,
          DebtsInReports(),
          // 14.verticalSizedBox,
          // DeficitAndSurplusWidget(),
          100.verticalSizedBox,
        ],
      ),
    );
  }
}
