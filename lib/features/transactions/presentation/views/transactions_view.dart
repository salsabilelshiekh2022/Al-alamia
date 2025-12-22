import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/widgets/custom_app_bar.dart';
import '../../../../generated/app_assets.dart';
import 'widgets/filter_box.dart';
import 'widgets/search_box.dart';
import 'widgets/transactions_filter_type.dart';
import 'widgets/transactions_list.dart';

class TransactionsView extends StatelessWidget {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppAssets.imagesBackground,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                CustomAppBar(
                  title: context.transactions,
                  hasActions: false,
                  isBack: false,
                ).onlyPadding(bottomPadding: 24),

                Row(
                  children: [
                    Expanded(child: SearchBox()),
                    12.horizontalSpace,
                    FilterBox(),
                  ],
                ).horizontalPadding(16),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 35),
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 130.h,
                  ),
                  decoration: BoxDecoration(
                    color: context.colors.whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      TransactionsFilterType(),
                      16.verticalSizedBox,
                      TransactionsList(),
                      80.verticalSizedBox,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}







