import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';


enum TransactionsEnum { received, sent;

  String translate(BuildContext context) {
    switch (this) {
      case TransactionsEnum.received:
        return context.recived;
      case TransactionsEnum.sent:
        return context.sent;
    }
  } }




