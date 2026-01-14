import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/components/widgets/empty_widget.dart';
import '../../../../../core/helper/widget_extentions.dart';
import '../../../../../generated/app_assets.dart';
import '../../../data/models/notification_model.dart';
import '../../cubit/notification_cubit.dart';
import '../../cubit/notification_state.dart';
import 'notification_card.dart';

class NotificationsList extends StatefulWidget {
  const NotificationsList({super.key});

  @override
  State<NotificationsList> createState() => _NotificationsListState();
}

class _NotificationsListState extends State<NotificationsList> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    context.read<NotificationCubit>().fetchNotifications();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<NotificationCubit>().loadMore();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        bool isInitialLoading =
            state.isLoading && state.notificationList.isEmpty;

        if (state.isSuccess && state.notificationList.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              65.verticalSizedBox,
              EmptyWidget(
                imagePath: AppAssets.imagesEmptyNotification,
                title: context.notFoundNotifications,
                description: context.notFoundNotificationsDescription,
              ).center(),
            ],
          );
        }

        return RefreshIndicator(
          onRefresh: () =>
              context.read<NotificationCubit>().refreshNotifications(),
          child: ListView.separated(
            controller: _scrollController,
            padding: EdgeInsets.zero,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              if (isInitialLoading) {
                return Skeletonizer(
                  enabled: true,
                  child: NotificationCard(
                    notification: dummyNotificationModel,
                  ),
                );
              }

              if (index < state.notificationList.length) {
                return NotificationCard(
                  notification: state.notificationList[index],
                );
              }

             
              if (state.isLoadingMore) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return const SizedBox.shrink();
            },
            separatorBuilder: (_, index) {
              return 16.verticalSizedBox;
            },
            itemCount: isInitialLoading
                ? 5
                : state.notificationList.length +
                    (state.isLoadingMore || state.hasReachedMax ? 1 : 0),
          ),
        );
      },
    );
  }
}
