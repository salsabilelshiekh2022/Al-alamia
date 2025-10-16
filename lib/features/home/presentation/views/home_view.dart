import 'package:alalamia/core/components/widgets/custom_cache_network_image.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../generated/app_assets.dart';
import 'widgets/currency_calculator_section.dart';
import 'widgets/send_money_and_transfer_currency_box.dart';
import 'widgets/wallets_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
                        color: context.colors.whiteColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          40.verticalSizedBox,
                          WalletsSections(),
                          24.verticalSizedBox,
                          CurrencyCalculatorSection(),
                          120.verticalSizedBox,
                        ],
                      ),
                    ),
                    SendMoneyAndTransferCurrencyBox(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildHomeAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "${context.hello}, أحمد محمد",
        style: context.textStyles.font16SemiBoldWhiteColor,
      ),
      leading: CustomCachedImageWidget(
        path:
            "https://i.pinimg.com/736x/ce/d4/4a/ced44a15c6f187b76d6479a03bdd773f.jpg",
        width: 44,
        height: 44,
        fit: BoxFit.scaleDown,
      ).clipRRect(borderRadius: BorderRadius.circular(1000.r)),
      actions: [
        InkWell(
          onTap: () {},
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
