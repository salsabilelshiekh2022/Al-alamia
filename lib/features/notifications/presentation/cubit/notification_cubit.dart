import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/enums/request_status.dart';
import '../../data/repos/notifications_repo.dart';
import 'notification_state.dart';

@injectable
class NotificationCubit extends Cubit<NotificationState> {
  final NotificationsRepo notificationsRepo;
  NotificationCubit({required this.notificationsRepo})
      : super(NotificationState());

  Future<void> fetchNotifications() async {
    emit(state.copyWith(getNotificationsStatus: RequestStatus.loading));
    final result = await notificationsRepo.fetchNotifications();
    result.fold(
      (failure) => emit(state.copyWith(getNotificationsStatus: RequestStatus.error)),
      (notifications) => emit(
        state.copyWith(
          getNotificationsStatus: RequestStatus.success,
          notifications: notifications,
        ),
      ),
    );
  }
}
