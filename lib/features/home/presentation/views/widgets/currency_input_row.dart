import 'package:alalamia/core/components/widgets/custom_currency_dropdown.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/features/home/data/models/currency_model.dart';
import 'package:flutter/material.dart';

import 'calculator_text_field.dart';

class CurrencyInputRow extends StatelessWidget {
  const CurrencyInputRow({
    super.key,
    required this.currencies,
    this.selectedCurrency,
    required this.onCurrencyChanged,
    this.controller,
    this.onAmountChanged,
    this.enabled = true,
    this.dropdownFlex = 3,
    this.textFieldFlex = 2,
  });

  final List<CurrencyModel> currencies;
  final CurrencyModel? selectedCurrency;
  final ValueChanged<CurrencyModel?> onCurrencyChanged;
  final TextEditingController? controller;
  final ValueChanged<String>? onAmountChanged;
  final bool enabled;
  final int dropdownFlex;
  final int textFieldFlex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: dropdownFlex,
          child: CustomCurrencyDropdown(
            items: currencies,
            selectedItem: selectedCurrency,
            onChanged: onCurrencyChanged,
          ),
        ),
        12.horizontalSizedBox,
        Expanded(
          flex: textFieldFlex,
          child: CalculatorTextField(
            controller: controller,
            enabled: enabled,
            onChanged: onAmountChanged,
          ),
        ),
      ],
    );
  }
}
