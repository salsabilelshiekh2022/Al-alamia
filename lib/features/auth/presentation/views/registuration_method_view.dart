import 'package:alalamia/core/components/widgets/custom_page.dart';
import 'package:alalamia/core/components/widgets/custom_svg_builder.dart';
import 'package:alalamia/core/components/widgets/main_button.dart';
import 'package:alalamia/core/enums/registration_methods_enum.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:flutter/material.dart';

import '../../../../core/routes/routes.dart';

class RegisturationMethodView extends StatelessWidget {
  const RegisturationMethodView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: context.login,
      hasActions: false,
      isBack: false,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      body: Column(
        children: [
          Text(
            context.chooseAccountType,
            style: context.textStyles.font15MediumSecondaryColor,
            textAlign: TextAlign.center,
          ).horizontalPadding(50),
          40.verticalSizedBox,
          RegisturationMethodItem(),
          32.verticalSizedBox,
          MainButton(
            title: context.confirm,
            onTap: () {
              context.pushNamed(Routes.signUpView);
            },
          ),
        ],
      ),
    );
  }
}

class RegisturationMethodItem extends StatefulWidget {
  const RegisturationMethodItem({super.key});

  @override
  State<RegisturationMethodItem> createState() =>
      _RegisturationMethodItemState();
}

class _RegisturationMethodItemState extends State<RegisturationMethodItem> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(RegistrationMethodsEnum.values.length, (index) {
        return InkWell(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            padding: 16.allPadding,
            decoration: BoxDecoration(
              color: context.colors.whiteColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: selectedIndex == index
                    ? context.colors.primaryColor
                    : Color(0xff9B9B9B).withValues(alpha: 0.16),
              ),
            ),
            child: Row(
              children: [
                CustomSvgBuilder(
                  path: RegistrationMethodsEnum.values[index].chooseImage(
                    context,
                  ),
                  width: 32,
                  height: 32,
                  fit: BoxFit.scaleDown,
                ),
                14.horizontalSizedBox,
                Text(
                  RegistrationMethodsEnum.values[index].translate(context),
                  style: context.textStyles.font16SemiBoldSecondaryColor,
                ),
                Spacer(),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selectedIndex == index
                          ? context.colors.primaryColor
                          : context.colors.grayColor,
                    ),
                  ),
                  child: selectedIndex == index
                      ? Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: context.colors.primaryColor,
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ).center()
                      : null,
                ),
              ],
            ),
          ),
        ).onlyPadding(bottomPadding: 14);
      }),
    );
  }
}
