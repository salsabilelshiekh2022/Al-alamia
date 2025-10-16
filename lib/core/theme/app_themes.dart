import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_constatnts.dart';
import 'app_colors_schemes.dart';
import 'app_text_style_schemes.dart';

class AppThemes {
  static final AppThemes _instance = AppThemes._internal();

  factory AppThemes() {
    return _instance;
  }

  AppThemes._internal();

  ThemeData get lightTheme {
    final appLightColors = AppColorsSchemes.light;
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppConstants.fontName,
      colorScheme: ColorScheme.fromSeed(
        seedColor: appLightColors.primaryColor,
        primary: appLightColors.primaryColor,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
      ),
      iconTheme: IconThemeData(color: appLightColors.secondaryColor),
      textTheme: ThemeData().textTheme.apply(
        fontFamily: GoogleFonts.getFont(AppConstants.fontName).fontFamily,
      ),
      extensions: <ThemeExtension<dynamic>>[
        appLightColors,
        AppTextStylesSchemes.light,
      ],
    );
  }

  ThemeData get darkTheme {
    return lightTheme;
  }
}
