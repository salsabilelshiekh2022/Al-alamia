import 'package:flutter/material.dart';

class Validator {
  static bool passwordValidate(String pass) {
    String password = pass.trim();
    if (password.length >= 8) {
      return true;
    } else {
      return false;
    }
  }

  static String? validateAnotherField(String? value, BuildContext context) {
    if (value!.isEmpty) {
      return "context.fieldRequired";
    } else {
      return null;
    }
  }

  static String? validateEmail(String? value, BuildContext context) {
    if (value!.isEmpty) {
      return "S.of(context).field_is_required";
    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return " S.of(context).please_enter_valid_email";
    } else {
      return null;
    }
  }

  static String? validateName(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return "context.fieldRequired";
    } else if (value.length > 50) {
      return "S.of(context).max_characters_limit";
    } else if (!RegExp(r'^[\u0621-\u064A\u0660-\u0669a-zA-Z0-9\s]+$')
        .hasMatch(value)) {
      return "context.pleaseEnterValidName";
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value, BuildContext context) {
    if (value!.isEmpty) {
      return "S.of(context).field_is_required";
    } else {
      bool result = passwordValidate(value);
      if (result) {
        return null;
      } else {
        return "S.of(context).your_pass_should_contain_capital_small_special";
      }
    }
  }

  static String? validatePhone(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return "context.fieldRequired";
    }

    final ksaLocalRegex = RegExp(r'^5[0-9]{8}$');
    if (!ksaLocalRegex.hasMatch(value)) {
      return "context.pleaseEnterValidPhone";
    }

    return null;
  }
}
