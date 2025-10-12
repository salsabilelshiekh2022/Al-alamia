import 'package:flutter/material.dart';

abstract class AppSnackBar {
  static _snackBarBuilder(
      {required String message, required SnackBarStates state}) {
    return SnackBar(
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.all(8),
      content: Row(
        children: [
          Icon(state.icon, color: state.color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
            ),
          ),
        ],
      ),
      backgroundColor: state.color,
    );
  }

  static void showSnackBar(
      {required BuildContext context,
      required String message,
      required SnackBarStates state}) {
    state.switchCase(
      success: () {
        ScaffoldMessenger.of(context).showSnackBar(
          _snackBarBuilder(message: message, state: state),
        );
      },
      error: () {
        ScaffoldMessenger.of(context).showSnackBar(
          _snackBarBuilder(message: message, state: state),
        );
      },
      warning: () {
        ScaffoldMessenger.of(context).showSnackBar(
          _snackBarBuilder(message: message, state: state),
        );
      },
      info: () {
        ScaffoldMessenger.of(context).showSnackBar(
          _snackBarBuilder(message: message, state: state),
        );
      },
    );
  }
}

enum SnackBarStates {
  success,
  error,
  warning,
  info,
}

extension SnackBarStatesExtension on SnackBarStates {
  Color get color {
    switch (this) {
      case SnackBarStates.success:
        return Colors.green;
      case SnackBarStates.error:
        return Colors.red;
      case SnackBarStates.warning:
        return Colors.orange;
      case SnackBarStates.info:
        return Colors.blue;
    }
  }

  IconData get icon {
    switch (this) {
      case SnackBarStates.success:
        return Icons.check_circle;
      case SnackBarStates.error:
        return Icons.error;
      case SnackBarStates.warning:
        return Icons.warning;
      case SnackBarStates.info:
        return Icons.info;
    }
  }
}

extension BoolExtension on SnackBarStates {
  bool get isSuccess => this == SnackBarStates.success;
  bool get isError => this == SnackBarStates.error;
  bool get isWarning => this == SnackBarStates.warning;
  bool get isInfo => this == SnackBarStates.info;
}

// to handel switch cases
extension SnackBarStatesSwitch on SnackBarStates {
  void switchCase({
    required Function() success,
    required Function() error,
    required Function() warning,
    required Function() info,
  }) {
    switch (this) {
      case SnackBarStates.success:
        success();
        break;
      case SnackBarStates.error:
        error();
        break;
      case SnackBarStates.warning:
        warning();
        break;
      case SnackBarStates.info:
        info();
        break;
    }
  }
}
