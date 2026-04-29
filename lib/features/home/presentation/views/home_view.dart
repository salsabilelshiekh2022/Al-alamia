import 'package:alalamia/core/di/dependency_injection.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/core/routes/routes.dart';
import 'package:alalamia/features/auth/data/models/user_model.dart';
import 'package:alalamia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../core/database/cache/cache_helper.dart';
import '../../../../core/database/cache/cache_services.dart';
import '../../../../generated/app_assets.dart';
import '../cubit/home_cubit.dart';
import 'widgets/calculator/currency_calculator_section.dart';
import 'widgets/debts_and_expenses_section.dart';
import 'widgets/main_actions_box.dart';
import 'widgets/wallets_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<HomeCubit>().getBranchCurrencies();
        await context.read<AuthCubit>().getProfile();
        await context.read<HomeCubit>().getCurrenciesByBranch();
        await context.read<HomeCubit>().getCurrencies();
      },

      child: Scaffold(
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
                  _buildHomeAppBar(
                    context,
                  ).horizontalPadding(16).onlyPadding(topPadding: 16),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 35,
                        ),
                        width: double.infinity,
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height - 130.h,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xfff5f7f9),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            25.verticalSizedBox,
                            WalletsSections(),
                            20.verticalSizedBox,
                            DebtsAndExpensesSection(),
                            20.verticalSizedBox,
                            CurrencyCalculatorSection(
                              fromCurrencies: context
                                  .read<HomeCubit>()
                                  .state
                                  .currenciesList,
                              toCurrencies: context
                                  .read<HomeCubit>()
                                  .state
                                  .currenciesList,
                            ),
                            120.verticalSizedBox,
                          ],
                        ),
                      ),
                      MainActionsBox(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildHomeAppBar(BuildContext context) {
    final UserModel user = getIt<CacheServices>().getDataFromCache(
      boxName: CacheBoxes.userModelBox,
      key: 'user',
    );
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${context.hello}, ${user.userName}",
            style: context.textStyles.font14SemiBoldPrimaryColor.copyWith(
              color: Colors.white,
            ),
          ),
          4.verticalSizedBox,
          Row(
            children: [
              CustomSvgBuilder(
                path: AppAssets.svgsMapIcon,
                width: 16,
                height: 16,
                fit: BoxFit.contain,
                color: Colors.white,
              ),
              4.horizontalSizedBox,
              Text(
                user.branch?.name ?? "",
                style: context.textStyles.font16SemiBoldWhiteColor,
              ),
            ],
          ),
        ],
      ),
      actions: [
        InkWell(
          onTap: () {
            context.pushNamed(Routes.chatSupportView);
          },
          child: CustomSvgBuilder(
            path: AppAssets.svgsSupportBtn,
            width: 44,
            height: 44,
          ),
        ),
      ],
    );
  }
}
