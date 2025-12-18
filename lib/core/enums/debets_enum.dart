import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

enum DebetsEnum {
  add_debt,
  pay_debt;

  String translate(BuildContext context) {
    switch (this) {
      case DebetsEnum.add_debt:
        return context.requestDebt;
      case DebetsEnum.pay_debt:
        return context.paymentDebt;
    }
  }
}


enum DebetsTypeEnum {
  debt_inside,
  debt_outside;

  String translate(BuildContext context) {
    switch (this) {
      case DebetsTypeEnum.debt_inside:
        return context.debtIn;
      case DebetsTypeEnum.debt_outside:
        return context.debtOut;
    }
  }
}