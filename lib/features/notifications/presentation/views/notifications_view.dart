import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/widgets/custom_app_bar.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../generated/app_assets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/notification_cubit.dart';
import 'widgets/notifications_list.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NotificationCubit>(),
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              AppAssets.imagesBackground,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                CustomAppBar(
                  title: context.notifications,
                  hasActions: false,
                  isBack: false,
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 30),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 35),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: context.colors.backgroundColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: const NotificationsList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


