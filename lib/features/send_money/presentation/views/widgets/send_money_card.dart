import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/enums/delivery_type_enum.dart';


class SendMoneyCardWidget extends StatelessWidget {
  const SendMoneyCardWidget({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.type, required this.imagePath,
  });
  final DeliveryTypeEnum type;
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
              type.translate(context),
              style: context.textStyles.font16SemiBoldSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
