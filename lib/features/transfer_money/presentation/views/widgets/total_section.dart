import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/features/home/data/models/currency_model.dart';
import 'package:alalamia/features/home/presentation/cubit/home_cubit.dart';
import 'package:alalamia/features/home/presentation/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TotalSection extends StatelessWidget {
  const TotalSection({
    super.key,
    required this.total,
    required this.exchangePrice,
    required this.fromCurrency,
    required this.toCurrency,
  });
  final String total;
  final num exchangePrice;
  final CurrencyModel fromCurrency;
  final CurrencyModel toCurrency;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 15, bottom: 15, left: 28, right: 28),
          decoration: BoxDecoration(
            color: context.colors.primaryColor.withValues(alpha: 0.03),
            border: Border.all(
              color: context.colors.primaryColor.withValues(alpha: 0.3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              Text(
                " ${toCurrency.code} $total ",
                style: context.textStyles.font22BoldPrimaryColor,
              ),
              12.verticalSizedBox,
              Text(
                "${context.exchangeRate} : ١  ${fromCurrency.name} =  ${context.read<HomeCubit>().state.transferCurrency?.exchangePriceUsed?.toStringAsFixed(2)} ${toCurrency.name}",
                style: context.textStyles.font14MediumSecondaryColor,
              ),
            ],
          ),
        );
      },
    );
  }
}
