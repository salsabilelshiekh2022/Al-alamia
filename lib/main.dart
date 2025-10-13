import 'package:alalamia/app/alalamia_app.dart';
import 'package:alalamia/core/utils/app_keys.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:requests_inspector/requests_inspector.dart';
import 'core/utils/service_init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServicesInit.init();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      startLocale: const Locale('ar'),
      child: RequestsInspector(
        hideInspectorBanner: true,
        navigatorKey: AppKeys.navigatorKey,
        enabled: true,
        child: AlalamiaApp(),
      ),
    ),
  );
}
