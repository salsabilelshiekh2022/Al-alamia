import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

enum LanguageEnum {
  english,
  arabic;

  String translate(BuildContext context) {
    switch (this) {
      case LanguageEnum.english:
        return context.english;
      case LanguageEnum.arabic:
        return context.arabic;
    }
  }
}
