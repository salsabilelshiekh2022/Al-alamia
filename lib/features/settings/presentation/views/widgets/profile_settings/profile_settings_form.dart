import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../../core/database/cache/cache_helper.dart';
import '../../../../../../core/database/cache/cache_services.dart';
import '../../../../../../core/di/dependency_injection.dart';
import '../../../../../../core/helper/app_extention.dart';
import '../../../../../../generated/app_assets.dart';
import '../../../../../auth/data/models/user_model.dart';

class ProfileSettingsForm extends StatelessWidget {
  const ProfileSettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
  final UserModel user =  getIt<CacheServices>().getDataFromCache(boxName: CacheBoxes.userModelBox, key: 'user' ,);

    return Form(
      child: Column(
        children: [
          CustomTextFieldWithLabel(
            initialValue: user.userName,
            label: context.fullName,
            hintText: context.fullNameHint,
            prefixWidget: AppAssets.svgsUserIcon,
            isReadOnly: true,
            enabled: false,
          ),
          20.verticalSpace,
          CustomTextFieldWithLabel(
            label: context.phone,
            hintText: context.phoneHint,
            prefixWidget: AppAssets.svgsPhone,
             initialValue: user.userPhone,
              isReadOnly: true,
            enabled: false,
          ),
            20.verticalSpace,
          CustomTextFieldWithLabel(
            label: context.salary,
            hintText: context.salary,
            prefixWidget: AppAssets.svgsWallet,
             initialValue: user.userSalary,
             isReadOnly: true,
            enabled: false,
          ),
          20.verticalSpace,
          Row(
            children: [
              Expanded(
                child: RewardedBox(
                  color: context.colors.greenColor,
                  title: context.rewarded,
                  value: user.rewarded.toString(),
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: RewardedBox(
                  color: context.colors.redColor,
                  title: context.penalized,
                  value: user.penalized.toString(),
                ),
              ),
            ],
          )

        ],
      ),
    );
  }
}

class RewardedBox extends StatelessWidget {
  const RewardedBox({
    super.key, required this.color, required this.title, required this.value,
  });
  final Color color;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8.r),
        border: BorderDirectional(
          start: BorderSide(color: color, width: 2),
        ),
    
       
      ),
      child:Row(
        children: [
          Text(title, style: context.textStyles.font14SemiBoldSecondaryColor,),
          Spacer(),
          Text(value, style: context.textStyles.font17SemiBoldSecondaryColor.copyWith(
            color: color
          ),),
    
        ],
      ),
    );
  }
}
