import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_text_style.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });
  final String imagePath;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final appTextStyles = Theme.of(context).extension<AppTextStyles>()!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          width: double.infinity,
          height: 224.0.h,
          fit: BoxFit.cover,
        ),
        16.verticalSpace,
        Text(title, style: appTextStyles.font16MediumSecondaryColor),
        6.verticalSpace,
        Text(
          description,
          style: appTextStyles.font14MediumSecondaryColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
