import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/features/transactions/presentation/cubit/transactions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/enums/transactions_enum.dart';

class TransactionsFilterType extends StatefulWidget {
  const TransactionsFilterType({super.key});

  @override
  State<TransactionsFilterType> createState() => _TransactionsFilterTypeState();
}

class _TransactionsFilterTypeState extends State<TransactionsFilterType> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 6.allPadding,
      width: double.infinity,
      height: 45.h,
      decoration: BoxDecoration(
        color: context.colors.backgroundFieldColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: List.generate(
          TransactionsEnum.values.length,
          (index) => Expanded(
            child: InkWell(
              onTap: () {
                final cubit = context.read<TransactionsCubit>();
                setState(() {
                  selectedIndex = index;
                });
                cubit.getTransactionList(
                  transaction: TransactionsEnum.values[index],
                  status: cubit.statusFilters,
                  fromDate: cubit.fromDateFilter,
                  toDate: cubit.toDateFilter,
                  search: cubit.searchFilter,
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 2),
                padding: 5.allPadding,
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? context.colors.whiteColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: Text(
                    TransactionsEnum.values[index].translate(context),
                    style: selectedIndex == index
                        ? context.textStyles.font16MediumPrimaryColor
                        : context.textStyles.font16MediumSecondaryColor
                              .copyWith(color: context.colors.grayColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
