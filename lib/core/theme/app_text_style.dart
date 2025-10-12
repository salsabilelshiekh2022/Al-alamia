import 'package:flutter/material.dart';

class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyle font12RegularLabelColor;
 

  AppTextStyles({
   
    required this.font12RegularLabelColor,
 
  });

  @override
  ThemeExtension<AppTextStyles> copyWith() {
    // don t need to implement this
    throw UnimplementedError();
  }

  @override
  ThemeExtension<AppTextStyles> lerp(
      covariant ThemeExtension<AppTextStyles>? other, double t) {
    if (other is! AppTextStyles) {
      return this;
    } else {
      return AppTextStyles(
       
        font12RegularLabelColor: TextStyle.lerp(
            font12RegularLabelColor, other.font12RegularLabelColor, t)!,
        
      );
    }
  }
}
