import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

enum DeliveryTypeEnum {
  internalDelivery,
  externalDelivery; 

  String translate(BuildContext context) {
    switch (this) {
      case DeliveryTypeEnum.internalDelivery:
        return context.internalDelivery;
      case DeliveryTypeEnum.externalDelivery:
        return context.externalDelivery;
    }
  }
}