import 'package:flutter/material.dart';

import '../helper/translation_extensions.dart';

enum StatusEnum {
  approved,
  waiting_approved,
  waiting_recieval,
  recieved,
  pending,
  completed,
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
    }
  }


}