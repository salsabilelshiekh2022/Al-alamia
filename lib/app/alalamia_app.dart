import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/routes/app_router.dart';
import '../core/theme/app_themes.dart';
import '../core/utils/app_constatnts.dart';
import '../core/utils/app_keys.dart';
import '../features/splash/presentations/views/splash_view.dart';

class AlalamiaApp extends StatelessWidget {
  const AlalamiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
     
     designSize: const Size(390, 840),
     
      splitScreenMode: true,
      child: MaterialApp(
        navigatorKey: AppKeys.navigatorKey,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: AppConstants.appName,
        darkTheme: AppThemes().darkTheme,
        theme: AppThemes().lightTheme,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.generateRoute,
        home: const SplashView(),
      ),
    );
  }
}
