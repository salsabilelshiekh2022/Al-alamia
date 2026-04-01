import 'package:alalamia/core/components/widgets/card_with_gray_border.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/features/home/presentation/cubit/home_cubit.dart';
import 'package:alalamia/features/home/presentation/cubit/home_state.dart';
import 'package:alalamia/features/home/presentation/views/widgets/denominations_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../core/helper/widget_extentions.dart';
import '../../../../../generated/app_assets.dart';

class WalletDetailsBottomSheet extends StatefulWidget {
  const WalletDetailsBottomSheet({
    super.key,
    required this.currencyName,
    required this.totalBalance,
  });

  final String currencyName;
  final String totalBalance;

  @override
  State<WalletDetailsBottomSheet> createState() =>
      _WalletDetailsBottomSheetState();
}

class _WalletDetailsBottomSheetState extends State<WalletDetailsBottomSheet> {
  bool showBalanceDetails = false;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomSvgBuilder(
                path: AppAssets.svgsPurpleDoller,
                width: 22,
                height: 22,
              ),
              8.horizontalSpace,
              Text(
                widget.currencyName,
                style: context.textStyles.font16SemiBoldSecondaryColor,
              ),
            ],
          ),
          24.verticalSizedBox,
          Text(
            context.totalBalance,
            style: context.textStyles.font15MediumGrayColor,
          ),
          14.verticalSizedBox,
          Text(
            widget.totalBalance,
            style: context.textStyles.font24BoldSecondaryColor.copyWith(
              fontSize: 28,
            ),
          ),
          6.verticalSizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.balanceDetails,
                style: context.textStyles.font14MediumPrimaryColor,
              ),
              4.horizontalSpace,
              InkWell(
                onTap: () {
                  setState(() {
                    showBalanceDetails = !showBalanceDetails;
                  });
                },
                child: Icon(
                  showBalanceDetails
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size: 20,
                  color: context.colors.primaryColor,
                ),
              ),
            ],
          ),
          showBalanceDetails
              ? _buildBalanceDetails(context)
              : const SizedBox.shrink(),
          32.verticalSizedBox,
          Expanded(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return DenominationsListView();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceDetails(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            CardWithGrayBorder(
              color: context.colors.backgroundFieldColor,
              child: Column(
                children: [
               Row(
      children: [
        Text(context.baseBalance, style: context.textStyles.font14MediumGrayColor),
        Spacer(),
        Text(state.denominationsMeta?.balanceDetails?.baseBalance ?? '----', style: context.textStyles.font17SemiBoldSecondaryColor),
      ],
    )
                ],
              ),
            ),
            12.verticalSizedBox,
            Row(
              children: [
                Expanded(
                  child: CardWithGrayBorder(
                    color: context.colors.backgroundFieldColor,
                    child: Column(
                      children: [
                        _buildInfoRow(
                          context,
                          state,
                          title: "العمولة",
                          value:
                              state
                                  .denominationsMeta
                                  ?.balanceDetails
                                  ?.commissionValue ??
                              '----',
                        ),
                      ],
                    ),
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: CardWithGrayBorder(
                    color: context.colors.backgroundFieldColor,
                    child: Column(
                      children: [
                        _buildInfoRow(
                          context,
                          state,
                          title: "القيمة المعلقة",
                          value:
                              state
                                  .denominationsMeta
                                  ?.balanceDetails
                                  ?.pendingBalance.toString() ??
                              '----',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            12.verticalSizedBox,
             Row(
              children: [
                Expanded(
                  child: CardWithGrayBorder(
                    color: context.colors.backgroundFieldColor,
                    child: Column(
                      children: [
                        _buildInfoRow(
                          context,
                          state,
                          title: "العجز",
                          value:
                              state
                                  .denominationsMeta
                                  ?.balanceDetails
                                  ?.deficitBalance ??
                              '----',
                        ),
                      ],
                    ),
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: CardWithGrayBorder(
                    color: context.colors.backgroundFieldColor,
                    child: Column(
                      children: [
                        _buildInfoRow(
                          context,
                          state,
                          title: "الفائض",
                          value:
                              state
                                  .denominationsMeta
                                  ?.balanceDetails
                                  ?.surplusBalance.toString() ??
                              '----',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ).onlyPadding(topPadding: 20);
  }

  Row _buildInfoRow(
    BuildContext context,
    HomeState state, {
    required String? title,
    required String value,
  }) {
    return Row(
      children: [
        Text(title ?? '', style: context.textStyles.font14MediumGrayColor.copyWith(fontSize: 12)),
        Spacer(),
        Expanded(child: Center(child: Text(value, style: context.textStyles.font14SemiBoldSecondaryColor))),
      ],
    );
  }
}
