import 'package:alalamia/features/reports/data/models/reports_model.dart';
import 'package:alalamia/features/reports/presentation/cubit/reports_cubit.dart';
import 'package:alalamia/features/reports/presentation/cubit/reports_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/enums/request_status.dart';
import '../../../../../core/helper/app_extention.dart';
import '../../../../../core/helper/number_extentions.dart';
import '../../../../../core/helper/translation_extensions.dart';
import 'currency_balance_item_in_reports.dart';

class WalletInReports extends StatelessWidget {
  const WalletInReports({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.wallet,
          style: context.textStyles.font16SemiBoldSecondaryColor,
        ),
        12.verticalSizedBox,
        BlocBuilder<ReportsCubit, ReportsState>(
          builder: (context, state) {
            bool isLoading = state.requestStatus.isLoading;
            return Skeletonizer(
              enabled: isLoading,
              child: Column(
                children: List.generate(
                  isLoading ? 2 : state.reportsModel?.disk?.length ?? 0,
                  (index) => CurrencyBalanceItemInReports(
                   diskModel:isLoading ? dummyReportsModel.disk![index] : state.reportsModel!.disk![index],
                  ),
                ).toList(),
              ),
            );
          },
        ),
      ],
    );
  }
}
