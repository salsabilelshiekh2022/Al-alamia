import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/enums/request_status.dart';
import '../../data/models/notification_model.dart';
import '../../data/repos/notifications_repo.dart';
import 'notification_state.dart';

@injectable
class NotificationCubit extends Cubit<NotificationState> {
  final NotificationsRepo notificationsRepo;
  NotificationCubit({required this.notificationsRepo})
      : super(const NotificationState());

  Future<void> fetchNotifications() async {
    emit(state.copyWith(status: RequestStatus.loading));
    final result = await notificationsRepo.fetchNotifications(page: 1);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: RequestStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (notifications) {
        final hasReachedMax = _checkIfReachedMax(notifications);
        emit(
          state.copyWith(
            status: RequestStatus.success,
            notifications: notifications,
            notificationList: notifications.notificationsList ?? [],
            currentPage: 1,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
    );
  }

  Future<void> loadMore() async {
    if (state.hasReachedMax || state.isLoadingMore) return;

    emit(state.copyWith(status: RequestStatus.loadingMore));

    final nextPage = state.currentPage + 1;
    final result = await notificationsRepo.fetchNotifications(page: nextPage);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: RequestStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (notifications) {
        final newNotifications = notifications.notificationsList ?? [];
        final updatedList = List<NotificationModel>.from(state.notificationList)
          ..addAll(newNotifications);

        final hasReachedMax =
            _checkIfReachedMax(notifications) || newNotifications.isEmpty;

        emit(
          state.copyWith(
            status: RequestStatus.success,
            notifications: notifications,
            notificationList: updatedList,
            currentPage: nextPage,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
    );
  }

  Future<void> refreshNotifications() async {
    emit(state.copyWith(status: RequestStatus.refreshing));

    final result = await notificationsRepo.fetchNotifications(page: 1);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: RequestStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (notifications) {
        final hasReachedMax = _checkIfReachedMax(notifications);
        emit(
          state.copyWith(
            status: RequestStatus.success,
            notifications: notifications,
            notificationList: notifications.notificationsList ?? [],
            currentPage: 1,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
    );
  }

  bool _checkIfReachedMax(NotificationsResponseModel notifications) {
    if (notifications.meta == null) return true;

    final currentPage = notifications.meta!.currentPage ?? 1;
    final lastPage = notifications.meta!.lastPage ?? 1;

    return currentPage >= lastPage;
  }
}
