import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

enum SupportTicketStatusEnum {
  open,
  closed;

  String translate(BuildContext context) {
    switch (this) {
      case SupportTicketStatusEnum.open:
        return context.open;
      case SupportTicketStatusEnum.closed:
        return context.closed;
    }
  }
}
