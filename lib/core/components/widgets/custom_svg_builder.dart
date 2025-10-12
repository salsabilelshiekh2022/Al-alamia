import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgBuilder extends StatelessWidget {
  const CustomSvgBuilder(
      {super.key,
      required this.path,
      this.color,
      this.width,
      this.height,
      this.fit});

  final String path;
  final Color? color;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 28.0.w,
      height: height ?? 28.0.h,
      child: SvgPicture.asset(
        path,
        fit: fit ?? BoxFit.cover,
        width: width ?? 28.0.w,
        height: height ?? 28.0.h,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      ),
    );
  }
}
