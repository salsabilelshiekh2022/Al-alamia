import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/custom_drop_down_card.dart';
import '../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../generated/app_assets.dart';
import '../../cubit/home_state.dart';
import 'calculator_text_field.dart';

class CurrencyCalculator extends StatelessWidget {
  const CurrencyCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 20.allPadding,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
          Text(context.amount, style: context.textStyles.font15MediumGrayColor),
          16.verticalSizedBox,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CurrencyDrobDownForCalculator(),
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
              CurrencyDrobDownForCalculator(),
              12.horizontalSpace,
              CalculatorTextField(),
            ],
          ),
        ],
      ),
    );
  }
}

class CurrencyDrobDownForCalculator extends StatefulWidget {
  const CurrencyDrobDownForCalculator({super.key});

  @override
  State<CurrencyDrobDownForCalculator> createState() =>
      _CurrencyDrobDownForCalculatorState();
}

class _CurrencyDrobDownForCalculatorState
    extends State<CurrencyDrobDownForCalculator> {
  bool isDropDownOpen = false;
  int? selectedCurrencyId;

  late TextEditingController currencyController;

  void _onItemSelected(String selectedItem) {
    final homeCubit = context.read<HomeCubit>();
    final selectedCurrency = homeCubit.state.currenciesList.firstWhere(
      (currency) => currency.name == selectedItem,
    );

    setState(() {
      isDropDownOpen = false;
      currencyController.text = selectedItem;
      selectedCurrencyId = selectedCurrency.id;
    });
  }

  @override
  void initState() {
    currencyController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    currencyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: 10.allPadding,
              decoration: BoxDecoration(
                color: context.colors.backgroundFieldColor,
                borderRadius: 10.allBorderRadius,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AppAssets.imagesFlag,
                    width: 26,
                    height: 26,
                    fit: BoxFit.fill,
                  ).clipRRect(borderRadius: BorderRadius.circular(13)),
                  11.horizontalSpace,
                  Text(
                    context.dollar,
                    style: context.textStyles.font14MediumPrimaryColor,
                  ),
                  10.horizontalSpace,
                  InkWell(
                    onTap: () {
                      setState(() {
                        isDropDownOpen = !isDropDownOpen;
                      });
                    },
                    child: Icon(
                      isDropDownOpen
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: isDropDownOpen
                          ? context.colors.primaryColor
                          : Color(0xff3C3C3C),
                    ),
                  ),
                ],
              ),
            ),

            if (isDropDownOpen)
              SizedBox(
                width: context.width * 0.4,
                child: CustomDropDownCard(
                  dropDownItems: state.currenciesList
                      .map((e) => e.name)
                      .whereType<String>()
                      .toList(),
                  selectedValue: currencyController.text,
                  onItemSelected: _onItemSelected,
                ),
              ).onlyPadding(topPadding: 6),
          ],
        );
      },
    );
  }
}
