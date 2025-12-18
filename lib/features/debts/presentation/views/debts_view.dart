import 'package:alalamia/core/enums/debets_enum.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/widgets/custom_app_bar.dart';
import '../../../../core/components/widgets/custom_currency_dropdown.dart';
import '../../../../core/components/widgets/main_button.dart';
import '../../../../core/helper/app_extention.dart';
import '../../../../core/helper/number_extentions.dart';
import '../../../../core/helper/widget_extentions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../generated/app_assets.dart';
import '../../../home/presentation/cubit/home_cubit.dart';

class DebtsView extends StatefulWidget {
  const DebtsView({super.key, required this.debetType});
  final DebetsTypeEnum debetType;

  @override
  State<DebtsView> createState() => _DebtsViewState();
}

class _DebtsViewState extends State<DebtsView> {
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
                  title: widget.debetType.translate(context),

                  isBack: true,
                ).onlyPadding(bottomPadding: 0),
                Text(
                  "50000",
                  style: context.textStyles.font24BoldSecondaryColor.copyWith(
                    color: context.colors.whiteColor,
                  ),
                ),
                8.verticalSizedBox,
                SizedBox(
                  width: 150.w,
                  child: CustomCurrencyDropdown(
                    items: context.read<HomeCubit>().state.currenciesList,
                    // selectedItem: selectedCurrency,
                    onChanged: (val) {
                      setState(() {
                        //     selectedCurrency = val;
                        //  context.read<ExpensesCubit>().getExpensesByCurrency(id: val!.id!);
                      });
                    },
                    color: Colors.white,
                    displayImageCurrency: false,
                  ),
                ),
                12.verticalSizedBox,
                Row(
                  children: [
                    Expanded(
                      child: MainButton(
                        title: context.requestDebt,
                        onTap: () => context.pushNamed(Routes.requestDeptView),
                        color: Colors.white.withValues(alpha: 0.08),
                        borderColor: context.colors.whiteColor.withValues(
                          alpha: 0.36,
                        ),
                        icon: AppAssets.svgsCash,
                      ),
                    ),
                    12.horizontalSizedBox,
                    Expanded(
                      child: MainButton(
                        title: context.paymentDebt,
                        onTap: () => context.pushNamed(Routes.paymentDeptView),
                        color: Colors.white.withValues(alpha: 0.08),
                        borderColor: context.colors.whiteColor.withValues(
                          alpha: 0.36,
                        ),
                        icon: AppAssets.svgsCash,
                      ),
                    ),
                  ],
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
                        context.transactions,
                        style: context.textStyles.font15SemiBoldSecondaryColor
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      18.verticalSizedBox,
                      // BlocBuilder<ExpensesCubit, ExpensesState>(
                      //   builder: (context, state) {
                      //     bool isLoading = state.expensesStatus.isLoading && state.expenses == null;
                      //     return Skeletonizer(
                      //       enabled: isLoading,
                      //       child: ListView.separated(
                      //         shrinkWrap: true,
                      //         padding: EdgeInsets.zero,
                      //         physics: const NeverScrollableScrollPhysics(),
                      //         separatorBuilder: (context, index) =>
                      //             16.verticalSizedBox,
                      //         itemCount: isLoading
                      //             ? 3
                      //             : state.expenses?.length ?? 0,
                      //         itemBuilder: (context, index) => ExpenseItem(
                      //           expenseModel: isLoading
                      //               ? dummyExpenseModel
                      //               : state.expenses![index]!,
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
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
