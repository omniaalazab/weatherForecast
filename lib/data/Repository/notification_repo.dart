import 'package:firebase_messaging/firebase_messaging.dart';
import '../models/notification_model.dart';

class NotificationRepository {
  Stream<List<NotificationModel>> getNotificationsStream() {
    return FirebaseMessaging.onMessage.map((RemoteMessage message) {
      if (message.notification != null) {
        return [
          NotificationModel(
            title: message.notification!.title ?? 'No Title',
            body: message.notification!.body ?? 'No Body',
            date: message.sentTime,
            imagePath: message.data['image'] ??
                'https://www.svgrepo.com/show/29731/sunny.svg',
          )
        ];
      }
      return [];
    });
  }

  Stream<List<NotificationModel>> getOpenedAppNotificationsStream() {
    return FirebaseMessaging.onMessageOpenedApp.map((RemoteMessage message) {
      if (message.notification != null) {
        return [
          NotificationModel(
            title: message.notification!.title ?? 'No Title',
            body: message.notification!.body ?? 'No Body',
            date: message.sentTime,
            imagePath: message.data['image'] ??
                'https://www.svgrepo.com/show/29731/sunny.svg',
          )
        ];
      }
      return [];
    });
  }
}
