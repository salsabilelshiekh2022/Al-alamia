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
import '../../../../../generated/app_assets.dart';

class WalletDetailsBottomSheet extends StatelessWidget {
  const WalletDetailsBottomSheet({
    super.key,
    required this.currencyName,
    required this.totalBalance,
  });

  final String currencyName;
  final String totalBalance;

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
              currencyName,
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
          totalBalance,
          style: context.textStyles.font24BoldSecondaryColor.copyWith(
            fontSize: 28,
          ),
        ),
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
}
