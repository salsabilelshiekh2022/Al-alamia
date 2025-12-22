import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';


enum TransactionsEnum { recieving, sending, transferMoney;

  String translate(BuildContext context) {
    switch (this) {
      case TransactionsEnum.recieving:
        return context.recived;
      case TransactionsEnum.sending:
        return context.sent;
      case TransactionsEnum.transferMoney:
        return context.currencyTransfer;
    }
  } }




