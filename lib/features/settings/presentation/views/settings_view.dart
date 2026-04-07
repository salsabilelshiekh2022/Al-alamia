import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/components/widgets/app_snack_bar.dart';
import 'package:alalamia/core/database/cache/cache_services.dart';
import 'package:alalamia/core/di/dependency_injection.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/features/notifications/data/repos/notifications_repo.dart';
import 'package:alalamia/features/settings/data/models/setting_item_model.dart';
import 'package:alalamia/features/settings/presentation/cubit/notification_toggle_cubit.dart';
import 'package:alalamia/features/settings/presentation/cubit/notification_toggle_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/widgets/custom_app_bar.dart';
import '../../../../generated/app_assets.dart';
import 'widgets/settings/logout_section.dart';
import 'widgets/settings/setting_group.dart';
import 'widgets/settings/user_info_box.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  void _onNotificationToggleStateChanged(
    BuildContext context,
    NotificationToggleState state,
  ) {
    if (state is NotificationToggleSuccess) {
      final successMessage =
          state.message != null && state.message!.trim().isNotEmpty
          ? state.message!
          : context.success;

      AppSnackBar.showSnackBar(
        context: context,
        message: successMessage,
        state: SnackBarStates.success,
      );
      return;
    }

    if (state is NotificationToggleError) {
      AppSnackBar.showSnackBar(
        context: context,
        message: state.errorMessage,
        state: SnackBarStates.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationToggleCubit(
        notificationsRepo: getIt<NotificationsRepo>(),
        cacheServices: getIt<CacheServices>(),
      ),
      child: BlocListener<NotificationToggleCubit, NotificationToggleState>(
        listenWhen: (previous, current) =>
            current is NotificationToggleSuccess ||
            current is NotificationToggleError,
        listener: _onNotificationToggleStateChanged,
        child: Scaffold(
          body: Stack(
            children: [
              Image.asset(
                AppAssets.imagesBackground,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    CustomAppBar(
                      title: context.settings,
                      hasActions: false,
                      isBack: false,
                    ).onlyPadding(bottomPadding: 24),

                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 25),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 35,
                          ),
                          width: double.infinity,
                          constraints: BoxConstraints(
                            minHeight:
                                MediaQuery.of(context).size.height - 130.h,
                          ),
                          decoration: BoxDecoration(
                            color: context.colors.backgroundColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          child: Column(
                            children: [
                              50.verticalSpace,
                              SettingGroup(
                                title: context.accountSettings,
                                settingItems: fristSettingGroup(context),
                              ),
                              20.verticalSpace,
                              SettingGroup(
                                title: context.appSettings,
                                settingItems: secoundSettingGroup(context),
                              ),
                              20.verticalSpace,
                              SettingGroup(
                                title: context.other,
                                settingItems: thirdSettingGroup(context),
                              ),
                              20.verticalSpace,
                              LogoutSection(),
                              130.verticalSpace,
                            ],
                          ),
                        ),

                        PositionedDirectional(
                          top: -10,
                          start: 16,
                          end: 16,
                          child: UserInfoBox(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
