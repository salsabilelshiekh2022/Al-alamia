import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/features/home/data/models/currency_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'currency_calculator.dart';

class CurrencyCalculatorSection extends StatefulWidget {
  const CurrencyCalculatorSection({super.key, required this.fromCurrencies, required this.toCurrencies});
  final List<CurrencyModel> fromCurrencies ;
  final List<CurrencyModel> toCurrencies ;

  @override
  State<CurrencyCalculatorSection> createState() =>
      _CurrencyCalculatorSectionState();
}

class _CurrencyCalculatorSectionState extends State<CurrencyCalculatorSection> {
  late TextEditingController _amountController;
  late TextEditingController _resultController;

  @override
  void initState() {
    _amountController = TextEditingController();
    _resultController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _resultController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.currencyCalculator,
          style: context.textStyles.font16SemiBoldSecondaryColor,
        ),
        14.verticalSpace,
        CurrencyCalculator(
          amountController: _amountController,
          resultController: _resultController,
          fromCurrencies: widget.fromCurrencies,
          toCurrencies: widget.toCurrencies,
        ),
      ],
    );
  }
}
