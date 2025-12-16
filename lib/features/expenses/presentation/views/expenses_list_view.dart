import 'package:alalamia/core/components/widgets/custom_currency_dropdown.dart';
import 'package:alalamia/core/components/widgets/main_button.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/features/home/presentation/cubit/home_cubit.dart';
import 'package:alalamia/features/transactions/presentation/views/widgets/transactions_details/card_with_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/widgets/custom_app_bar.dart';
import '../../../../core/helper/app_extention.dart';
import '../../../../core/helper/translation_extensions.dart';
import '../../../../core/helper/widget_extentions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../generated/app_assets.dart';

class ExpensesListView extends StatelessWidget {
  const ExpensesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundImage(),

          SingleChildScrollView(
            child: Column(
              children: [
                CustomAppBar(
                  title: context.expenses,

                  isBack: true,
                ).onlyPadding(bottomPadding: 16),
                Text(
                  "\$5,000.00",
                  style: context.textStyles.font24BoldSecondaryColor.copyWith(
                    color: context.colors.whiteColor,
                  ),
                ),
                12.verticalSizedBox,
                SizedBox(
                  width: 150.w,
                  child: CustomCurrencyDropdown(
                    items: context.read<HomeCubit>().state.currenciesList,
                    onChanged: (val) {},
                    color: Colors.white,
                    displayImageCurrency: false,
                  ),
                ),
                26.verticalSizedBox,
                MainButton(
                  title: context.addExpenses,
                  onTap: () => context.pushNamed(Routes.expensesView),
                  color: Colors.white.withValues(alpha: 0.08),
                  borderColor: context.colors.whiteColor.withValues(alpha: 0.36),
                  icon: AppAssets.svgsCash,
                ).horizontalPadding(16),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.all(24),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.expense, style: context.textStyles.font15SemiBoldSecondaryColor.copyWith(
                          fontWeight: FontWeight.bold
                        ),),
                        18.verticalSizedBox,
                        ExpenseItem(),
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

  Image _buildBackgroundImage() {
    return Image.asset(
      AppAssets.imagesBackground,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }
}


class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWithShadow(borderRadius: 12,padding: 14,
    child: Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: context.colors.greenColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child:Text("مقبولة",style: context.textStyles.font14MediumGrayColor.copyWith(
                color: context.colors.greenColor
              ),),
            ),
            Spacer(),
            Text("15 يناير 2025",style: context.textStyles.font14MediumGrayColor,),
          ],
        ),
        
      ],
    ),);
  }
}