import 'package:alalamia/core/enums/debets_enum.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class DebtCardWidget extends StatelessWidget {
  const DebtCardWidget({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.debets, required this.imagePath,
  });
  final DebetsTypeEnum debets;
  final bool isSelected;
  final VoidCallback onTap;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: isSelected
                ? BorderSide(color: context.colors.primaryColor)
                : BorderSide.none,
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x11000000),
              blurRadius: 48,
              offset: Offset(0, 0),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            SvgPicture.asset(
           imagePath,
              width: 40,
              height: 32,
              colorFilter: ColorFilter.mode(isSelected ? context.colors.primaryColor : context.colors.grayColor, BlendMode.srcIn),
            ),
            16.verticalSizedBox,
            Text(
              debets.translate(context),
              style: context.textStyles.font16SemiBoldSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
