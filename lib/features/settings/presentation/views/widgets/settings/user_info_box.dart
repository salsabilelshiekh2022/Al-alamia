import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/database/cache/cache_helper.dart';
import '../../../../../../core/database/cache/cache_services.dart';
import '../../../../../../core/di/dependency_injection.dart';
import '../../../../../auth/data/models/user_model.dart';

class UserInfoBox extends StatelessWidget {
  const UserInfoBox({super.key});

  @override
  Widget build(BuildContext context) {
  final UserModel user =  getIt<CacheServices>().getDataFromCache(boxName: CacheBoxes.userModelBox, key: 'user' ,);

    return Container(
      padding: 15.allPadding,
      decoration: BoxDecoration(
        color: context.colors.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        // boxShadow: [
        //   BoxShadow(
        //     color: Color(0xff6E0084).withValues(alpha: 0.2),
        //     blurRadius: 20.r,
        //     offset: const Offset(0, 0),
        //   ),
        // ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.userName ?? "",
                style: context.textStyles.font13SemiBoldPrimaryColor.copyWith(
                  color: context.colors.secondaryColor,
                ),
              ),
              5.verticalSpace,
              Text(
                user.branch?.name ?? "",
                style: context.textStyles.font14RegularGrayColor,
              ),
              5.verticalSpace,
              Text(
                user.userPhone ?? "",
                style: context.textStyles.font14RegularGrayColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
