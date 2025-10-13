import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDash extends StatelessWidget {
  const CustomDash({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3,
      width: 48.w,
      decoration: BoxDecoration(
        color: Color(0xffADAAAA).withValues(alpha: 0.24),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
