import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/custom_currency_dropdown.dart';
import '../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../generated/app_assets.dart';
import '../../../data/models/currency_model.dart';
import '../../cubit/home_state.dart';
import 'calculator_text_field.dart';

class CurrencyCalculator extends StatefulWidget {
  const CurrencyCalculator({super.key});

  @override
  State<CurrencyCalculator> createState() => _CurrencyCalculatorState();
}

class _CurrencyCalculatorState extends State<CurrencyCalculator> {
  CurrencyModel? fromCurrency;
  CurrencyModel? toCurrency;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Container(
          padding: 20.allPadding,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x11000000),
                blurRadius: 44,
                offset: Offset(0, 0),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                context.amount,
                style: context.textStyles.font15MediumGrayColor,
              ),
              16.verticalSizedBox,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: CustomCurrencyDropdown(
                      items: state.currenciesList,
                      selectedItem: fromCurrency,
                      onChanged: (value) {
                        setState(() {
                          fromCurrency = value;
                        });
                      },
                    ),
                  ),
                  12.horizontalSpace,
                  CalculatorTextField(),
                ],
              ),
              35.verticalSpace,
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Divider(color: context.colors.strokeColor),
                  PositionedDirectional(
                    top: -13,
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        borderRadius: 19.allBorderRadius,
                        color: context.colors.primaryColor,
                      ),
                      child: CustomSvgBuilder(
                        path: AppAssets.svgsTransfarIcon,
                        width: 21,
                        height: 21,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ],
              ),
              5.verticalSizedBox,
              Text(
                context.transeferedAmount,
                style: context.textStyles.font15MediumGrayColor,
              ),
              16.verticalSizedBox,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: CustomCurrencyDropdown(
                      items: state.currenciesList,
                      selectedItem: toCurrency,
                      onChanged: (value) {
                        setState(() {
                          toCurrency = value;
                        });
                      },
                    ),
                  ),
                  12.horizontalSpace,
                  CalculatorTextField(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
