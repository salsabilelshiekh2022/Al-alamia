import 'package:alalamia/core/database/cache/cache_helper.dart';
import 'package:alalamia/core/database/cache/cache_services.dart';
import 'package:alalamia/features/notifications/data/repos/notifications_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_toggle_state.dart';

class NotificationToggleCubit extends Cubit<NotificationToggleState> {
  final NotificationsRepo _notificationsRepo;
  final CacheServices _cacheServices;

  NotificationToggleCubit({
    required NotificationsRepo notificationsRepo,
    required CacheServices cacheServices,
  }) : _notificationsRepo = notificationsRepo,
       _cacheServices = cacheServices,
       super(const NotificationToggleInitial()) {
    initializeFromCache();
  }

  void initializeFromCache() {
    final cachedValue = _cacheServices.getDataFromCache<bool>(
      boxName: CacheBoxes.metaBox,
      key: CacheKeys.notificationsEnabled,
    );

    emit(NotificationToggleInitial(isEnabled: cachedValue ?? true));
  }

  Future<void> toggleNotifications() async {
    if (state is NotificationToggleLoading) return;

    final previousValue = state.isEnabled;
    final nextValue = !previousValue;

    emit(NotificationToggleLoading(isEnabled: nextValue));

    final result = await _notificationsRepo.toggleNotification();

    result.fold(
      (failure) {
        emit(
          NotificationToggleError(
            isEnabled: previousValue,
            errorMessage: failure.message,
          ),
        );
      },
      (message) {
        _cacheServices.storeData<bool>(
          boxName: CacheBoxes.metaBox,
          key: CacheKeys.notificationsEnabled,
          data: nextValue,
        );

        emit(NotificationToggleSuccess(isEnabled: nextValue, message: message));
      },
    );
  }
}
