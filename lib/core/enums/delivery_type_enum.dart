import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

enum DeliveryTypeEnum {
  inside,
  outside; 

  String translate(BuildContext context) {
    switch (this) {
      case DeliveryTypeEnum.inside:
        return context.internalDelivery;
      case DeliveryTypeEnum.outside:
        return context.externalDelivery;
    }
  }
}