import 'package:alalamia/core/di/dependency_injection.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/utils/global_ui_utils.dart';
import 'package:alalamia/features/home/data/models/currency_model.dart';
import 'package:alalamia/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'wallet_details_bottom_sheet.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({super.key, required this.currencyModel});
  final CurrencyModel currencyModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final cubit = getIt<HomeCubit>();
        cubit.getDenominationsOfCurrency(currencyId: currencyModel.id!);
        GlobalUiUtils.showBottomSheet(
          context,
          child: BlocProvider.value(
            value: cubit,
            child: WalletDetailsBottomSheet(
              currencyName: currencyModel.currencyName!,
              totalBalance: currencyModel.balance ?? "0.0",
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(top: 19, left: 6, right: 6, bottom: 16),
        decoration: BoxDecoration(
          color: context.colors.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: context.colors.strokeColor, width: 1),
        ),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.network(
                  currencyModel.currencyImage!,
                  width: 18,
                  height: 12,
                ),
                6.horizontalSpace,
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      currencyModel.currencyName!,
                      style: context.textStyles.font13SemiBoldPrimaryColor
                          .copyWith(color: context.colors.grayColor),
                    ),
                  ),
                ),
              ],
            ),
            20.verticalSizedBox,
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  currencyModel.balance!,
                  style: context.textStyles.font16SemiBoldSecondaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
