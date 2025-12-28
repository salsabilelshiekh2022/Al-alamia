import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

enum NotificationsEnum { public, transactions;

  String translate(BuildContext context) {
    switch (this) {
      case NotificationsEnum.public:
        return context.public;
      case NotificationsEnum.transactions:
        return context.transactions;
    }
  } }

