import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

enum DebetsEnum {
  requestDebt,
  paymentDebt;

  String translate(BuildContext context) {
    switch (this) {
      case DebetsEnum.requestDebt:
        return context.requestDebt;
      case DebetsEnum.paymentDebt:
        return context.paymentDebt;
    }
  }
}
