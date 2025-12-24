import 'package:alalamia/features/reports/presentation/cubit/reports_cubit.dart';
import 'package:alalamia/features/reports/presentation/cubit/reports_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/enums/request_status.dart';
import '../../../../../core/helper/app_extention.dart';
import '../../../../../core/helper/number_extentions.dart';
import '../../../../../core/helper/translation_extensions.dart';
import '../../../../../core/helper/widget_extentions.dart';
import '../../../data/models/reports_model.dart';

class ExpensesInReports extends StatefulWidget {
  const ExpensesInReports({super.key});

  @override
  State<ExpensesInReports> createState() => _ExpensesInReportsState();
}

class _ExpensesInReportsState extends State<ExpensesInReports> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsCubit, ReportsState>(
      builder: (context, state) {
        bool isLoading = state.requestStatus.isLoading;
        return Skeletonizer(enabled: isLoading, child: ExpenseItemInReports(
          model: isLoading ? dummyReportsModel.expenses! : state.reportsModel!.expenses!,
          branchCurrency: isLoading ? dummyReportsModel.branchCurrency! : state.reportsModel!.branchCurrency!,
        ));
      },
    ).onlyPadding(bottomPadding: 10);
  }
}

class ExpenseItemInReports extends StatefulWidget {
  const ExpenseItemInReports({super.key, required this.model, required this.branchCurrency});
  final Expenses model ;
  final BranchCurrency branchCurrency;

  @override
  State<ExpenseItemInReports> createState() => _ExpenseItemInReportsState();
}

class _ExpenseItemInReportsState extends State<ExpenseItemInReports> {
  bool openDrowpdown = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          openDrowpdown = !openDrowpdown;
        });
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 44,
              offset: Offset(0, 0),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  context.expenses,
                  style: context.textStyles.font16MediumSecondaryColor,
                ),
                Spacer(),
                Text(
                  "${widget.model.total} ${widget.branchCurrency.code?? ""}",
                  style: context.textStyles.font16SemiBoldSecondaryColor
                      .copyWith(
                        fontWeight: FontWeight.w500,
                        color: context.colors.grayColor,
                      ),
                ),
                6.horizontalSizedBox,
            widget.model.items!.isNotEmpty ?   Icon(
                  openDrowpdown
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down_rounded,
                  size: 24.w,
                  color: context.colors.grayColor,
                ) : SizedBox(),
              ],
            ),
            openDrowpdown ? _buildBalanceData(context) : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceData(BuildContext context) {
    return Column(
      children: [
        Divider(color: context.colors.strokeColor, thickness: 1, height: 24.h),
        Column(
          children: List.generate(
            widget.model.items?.length ?? 0,
            (index) => _buildItem(context, widget.model.items![index]),
          ),
        )
      ],
    );
  }

  Row _buildItem(BuildContext context, ExpenseItem item) {
    return Row(
        children: [
          Text(
            item.notes ?? "",
            style: context.textStyles.font14MediumSecondaryColor,
          ),
          Spacer(),
          Text(
            "${item.amount} ${widget.branchCurrency.code ?? ""}",
            style: context.textStyles.font16SemiBoldSecondaryColor.copyWith(
              color: context.colors.redColor,
            ),
          ),
        ],
      );
  }
}
