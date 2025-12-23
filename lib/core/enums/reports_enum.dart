import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

enum ReportsEnum {
  day, month;

String translate(BuildContext context) {
    switch (this) {
      case ReportsEnum.day:
        return context.todayAccount;
      case ReportsEnum.month:
        return context.monthlyAccount;
    }
  }


}