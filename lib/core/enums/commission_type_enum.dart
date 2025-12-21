
// ignore_for_file: constant_identifier_names

import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

enum CommissionTypeEnum { added_value, deducted_value, none;

  String getCommissionType(BuildContext context) {
    switch (this) {
      case CommissionTypeEnum.added_value:
        return context.addedValue;
      case CommissionTypeEnum.deducted_value:
        return context.deductedValue;
      case CommissionTypeEnum.none:
        return context.none;
    }
  }
 }
