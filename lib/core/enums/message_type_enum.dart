import 'package:flutter/material.dart';

enum MessageTypeEnum {
  sms,
  whatsapp;

  String get apiValue {
    switch (this) {
      case MessageTypeEnum.sms:
        return 'sms';
      case MessageTypeEnum.whatsapp:
        return 'whatsapp';
    }
  }

  String translate(BuildContext context) {
    switch (this) {
      case MessageTypeEnum.sms:
        return 'SMS';
      case MessageTypeEnum.whatsapp:
        return 'WhatsApp';
    }
  }

  IconData get icon {
    switch (this) {
      case MessageTypeEnum.sms:
        return Icons.message;
      case MessageTypeEnum.whatsapp:
        return Icons.chat;
    }
  }
}
