
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../generated/app_assets.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: context.search,
          hintStyle: context.textStyles.font15MediumGrayColor.copyWith(
            color: context.colors.whiteColor,
          ),
          filled: true,
          fillColor: context.colors.whiteColor.withValues(alpha: 0.12),
          border: _buildBorder(context),
          enabledBorder: _buildBorder(context),
          focusedBorder: _buildBorder(context, color: context.colors.whiteColor),

          prefixIcon: CustomSvgBuilder(path: AppAssets.svgsSearchIcon, width: 20, height: 20, fit: BoxFit.scaleDown),
        ),
      ),
    );
  }

  OutlineInputBorder _buildBorder(BuildContext context, {Color? color}) {
    return OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color:color ?? context.colors.whiteColor.withValues(alpha: 0.22), width: 1),
        );
  }
}

