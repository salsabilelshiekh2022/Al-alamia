import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

enum TransactionsStatusEnum {
  pending,
  success,
  failed;

 String translate(BuildContext context) {
    switch (this) {
      case TransactionsStatusEnum.pending:
        return context.pending;
      case TransactionsStatusEnum.success:
        return context.success;
      case TransactionsStatusEnum.failed:
        return context.failed;
    }
  }
}
