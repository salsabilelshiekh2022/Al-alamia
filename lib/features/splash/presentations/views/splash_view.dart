import 'package:alalamia/core/database/cache/cache_services.dart';
import 'package:alalamia/core/di/dependency_injection.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/database/cache/cache_helper.dart';
import '../../../../core/routes/routes.dart';
import '../../../../generated/app_assets.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      final UserModel? user = getIt<CacheServices>().getDataFromCache(
        boxName: CacheBoxes.userModelBox,
        key: 'user',
      );
      context.pushReplacementNamed(
        user?.token == null ? Routes.loginView : Routes.mainNavigationView,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppAssets.imagesLogo,
          width: 300.w,
          height: 100.h,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
