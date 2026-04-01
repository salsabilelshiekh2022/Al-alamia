import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/generated/app_assets.dart';
import 'package:flutter/material.dart';

import '../helper/translation_extensions.dart';

enum StatusEnum {
  approved,
  waiting_approval,
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
      case StatusEnum.waiting_approval:
        return context.waitingApproved;
      case StatusEnum.waiting_recieval:
        return context.waitingRecieval;
      case StatusEnum.recieved:
        return context.recivedd;
      case StatusEnum.pending:
        return context.hold;
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
      case StatusEnum.waiting_approval:
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
        return context.colors.orangeColor;
    }
  }

  String chooseImage() {
    switch (this) {
      case StatusEnum.approved:
        return AppAssets.svgsSuccess;
      case StatusEnum.waiting_approval:
        return AppAssets.svgsPending;
      case StatusEnum.waiting_recieval:
        return AppAssets.svgsPending;
      case StatusEnum.recieved:
        return AppAssets.svgsSuccess;
      case StatusEnum.pending:
        return AppAssets.svgsPending;
      case StatusEnum.completed:
        return AppAssets.svgsSuccess;
      case StatusEnum.canceled:
        return AppAssets.svgsCancelled;
      case StatusEnum.in_progress:
        return AppAssets.svgsWaiting;
    }
  }
}
