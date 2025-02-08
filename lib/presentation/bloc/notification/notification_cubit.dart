import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/repository/notification_repo.dart';
import '../../../data/models/notification_model.dart';

import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository _notificationRepository;

  NotificationCubit(this._notificationRepository)
      : super(NotificationState(notificationModel: []));

  void initialize() {
    _notificationRepository.getNotificationsStream().listen((notifications) {
      final updatedNotifications =
          List<NotificationModel>.from(state.notificationModel)
            ..addAll(notifications);
      emit(NotificationState(notificationModel: updatedNotifications));
    });

    _notificationRepository
        .getOpenedAppNotificationsStream()
        .listen((notifications) {
      final updatedNotifications =
          List<NotificationModel>.from(state.notificationModel)
            ..addAll(notifications);
      emit(NotificationState(notificationModel: updatedNotifications));
    });
  }
}
