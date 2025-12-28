import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/components/widgets/empty_widget.dart';
import '../../../../../core/enums/request_status.dart';
import '../../../../../core/helper/widget_extentions.dart';
import '../../../../../generated/app_assets.dart';
import '../../../data/models/notification_model.dart';
import '../../cubit/notification_cubit.dart';
import '../../cubit/notification_state.dart';
import 'notification_card.dart';

class NotificationsList extends StatelessWidget {
  const NotificationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        bool isLoading =
            state.getNotificationsStatus.isLoading &&
            state.notifications == null;
        bool isEmpty =
            !isLoading &&
            (state.notifications == null || state.notifications!.isEmpty);
        return Skeletonizer(
          enabled: isLoading,
          child: isEmpty
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      65.verticalSizedBox,
                                      EmptyWidget(
                                        imagePath:
                                            AppAssets.imagesEmptyNotification,
                                        title: context.notFoundNotifications,
                                        description: context
                                            .notFoundNotificationsDescription,
                                      ).center(),
                                    ],
                                  )
                                : ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => NotificationCard(
              notification: isLoading
                  ? dummyNotificationModel
                  : state.notifications![index]!,
            ),
            itemCount: isLoading ? 5 : state.notifications!.length,
            separatorBuilder: (context, index) => 16.verticalSizedBox,
          ),
        );
      },
    );
  }
}
