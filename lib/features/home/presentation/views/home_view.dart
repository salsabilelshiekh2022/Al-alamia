import 'package:alalamia/core/components/widgets/custom_cache_network_image.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../generated/app_assets.dart';

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
                AppBar(
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
                        children: [
                          40.verticalSizedBox,
                          WalletsSections(),
                          // 20.verticalSizedBox,
                          // SenderInfoCard(),
                          // 20.verticalSizedBox,
                          // BeneficiaryInfoCard(),
                          // 20.verticalSizedBox,
                          // TransactionInfoCard(),
                          // 32.verticalSizedBox,
                          // MainButton(
                          //   title: context.receivedDone,
                          //   onTap: () {
                          //     context.pop();
                          //   },
                          // ),
                        ],
                      ),
                    ),
                    PositionedDirectional(
                      top: 20,
                      start: 16,
                      end: 16,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 13,
                          horizontal: 55,
                        ),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: const Color(0x2800840F),
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          shadows: [
                            BoxShadow(
                              color: Color(0x07000000),
                              blurRadius: 25,
                              offset: Offset(0, 11),
                              spreadRadius: 0,
                            ),
                            BoxShadow(
                              color: Color(0x07000000),
                              blurRadius: 45,
                              offset: Offset(0, 45),
                              spreadRadius: 0,
                            ),
                            BoxShadow(
                              color: Color(0x05000000),
                              blurRadius: 61,
                              offset: Offset(0, 101),
                              spreadRadius: 0,
                            ),
                            BoxShadow(
                              color: Color(0x00000000),
                              blurRadius: 72,
                              offset: Offset(0, 180),
                              spreadRadius: 0,
                            ),
                            BoxShadow(
                              color: Color(0x00000000),
                              blurRadius: 79,
                              offset: Offset(0, 280),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                
                              },
                              child: Column(
                                children: [
                                  CustomSvgBuilder(
                                    path: AppAssets.svgsSendMoneyIcon,
                                    width: 24,
                                    height: 24,
                                    fit: BoxFit.contain,
                                  ),
                                  6.verticalSizedBox,
                                  Text(
                                    context.sendMoney,
                                    style: context
                                        .textStyles
                                        .font13SemiBoldPrimaryColor,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  CustomSvgBuilder(
                                    path: AppAssets.svgsPurpleTransfarIcon,
                                    width: 24,
                                    height: 24,
                                    fit: BoxFit.contain,
                                  ),
                                  6.verticalSizedBox,
                                  Text(
                                    context.currencyTransfer,
                                    style: context
                                        .textStyles
                                        .font13SemiBoldPrimaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class WalletsSections extends StatelessWidget {
  const WalletsSections({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       
        Text(
          context.wallets,
          style: context.textStyles.font16SemiBoldSecondaryColor,
        ),
        20.verticalSpace,
        WalletsList(),
      ],
    );
  }
}

class WalletsList extends StatelessWidget {
  const WalletsList({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
      childAspectRatio: 1.4,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12
      ), itemBuilder: (context, index) => WalletCard(), itemCount: 6,);
  }


}


class WalletCard extends StatelessWidget {
  const WalletCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 19, left: 6, right: 6, bottom: 16),
      decoration: BoxDecoration(
        color: context.colors.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: context.colors.strokeColor, width: 1),
      ) ,
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(AppAssets.imagesFlag, width: 18, height: 12),
              6.horizontalSpace,
              Text(context.dollar, style: context.textStyles.font13SemiBoldPrimaryColor.copyWith(
                color: context.colors.grayColor,
              ),),
              
            ],
          ),
          //10.verticalSizedBox,
              Text("\$2,654.30", style: context.textStyles.font16SemiBoldSecondaryColor,),
        ],
      ),
    );
  }
}