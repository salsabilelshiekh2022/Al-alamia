import 'package:alalamia/core/helper/app_extention.dart';
import 'package:flutter/material.dart';

import '../helper/translation_extensions.dart';

enum StatusEnum {
  approved,
  waiting_approved,
  waiting_recieval,
  recieved,
  pending,
  completed,
  in_progress,
  canceled;
  
  String translate(BuildContext context) {
    switch (this) {
      case StatusEnum.approved:
        return context.approved;
      case StatusEnum.waiting_approved:
        return context.waitingApproved;
      case StatusEnum.waiting_recieval:
        return context.waitingRecieval;
      case StatusEnum.recieved:
        return context.recivedd;
      case StatusEnum.pending:
        return context.pendingg;
      case StatusEnum.completed:
        return context.completed;
      case StatusEnum.canceled:
        return context.canceled;
      case StatusEnum.in_progress:
        return context.pendingg;   
    }
  }

   Color chooseColor(BuildContext context) {
    switch (this) {
      case StatusEnum.approved:
        return context.colors.greenColor;
      case StatusEnum.waiting_approved:
        return context.colors.yellowColor;
      case StatusEnum.waiting_recieval:
        return context.colors.yellowColor;
      case StatusEnum.recieved:
        return context.colors.greenColor;
      case StatusEnum.pending:
        return context.colors.yellowColor;
      case StatusEnum.completed:
        return context.colors.greenColor;
      case StatusEnum.canceled:
        return context.colors.redColor;
        case StatusEnum.in_progress:
        return context.colors.yellowColor;
    }
  }


}