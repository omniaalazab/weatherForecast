import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/view_model/notification/notification_state.dart';
import '../../../data/models/notification_model.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationState(notificationModel: []));

  void initialize() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        final notifications =
            List<NotificationModel>.from(state.notificationModel);
        notifications.add(
          NotificationModel(
            title: message.notification!.title ?? 'No Title',
            body: message.notification!.body ?? 'No Body',
            date: message.sentTime,
            imagePath: message.data['image'] ??
                'https://img.freepik.com/free-photo/young-beautiful-woman-pink-warm-sweater-natural-look-smiling-portrait-isolated-long-hair_285396-896.jpg?size=626&ext=jpg&ga=GA1.1.2008272138.1723075200&semt=ais_hybrid',
          ),
        );
        emit(NotificationState(notificationModel: notifications));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        final notifications =
            List<NotificationModel>.from(state.notificationModel);
        notifications.add(
          NotificationModel(
            title: message.notification!.title ?? 'No Title',
            body: message.notification!.body ?? 'No Body',
            date: message.sentTime,
            imagePath: message.data['image'] ??
                'https://img.freepik.com/free-photo/young-beautiful-woman-pink-warm-sweater-natural-look-smiling-portrait-isolated-long-hair_285396-896.jpg?size=626&ext=jpg&ga=GA1.1.2008272138.1723075200&semt=ais_hybrid',
          ),
        );
        emit(NotificationState(notificationModel: notifications));
      }
    });
  }
}
// class NotificationCubit extends Cubit<NotificationState> {
//   NotificationCubit() : super(NotificationState(notificationModel: []));

//   void addNotification(RemoteMessage message) {
//     print('Adding Notification:');
//     print('Title: ${message.notification?.title}');
//     print('Body: ${message.notification?.body}');
//     print('Data: ${message.data}');

//     if (message.notification != null) {
//       final notifications =
//           List<NotificationModel>.from(state.notificationModel);
//       notifications.insert(
//         0,
//         NotificationModel(
//           title: message.notification!.title ?? 'No Title',
//           body: message.notification!.body ?? 'No Body',
//           date: DateTime.now(),
//           imagePath: message.data['image'] ??
//               'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS993qPHcVfih2gFjy5g6KAYy8wzeTL_Ta38A&s',
//         ),
//       );

//       print('Notifications after adding: ${notifications.length}');
//       emit(NotificationState(notificationModel: notifications));
//     }
//   }

//   void initialize() {
//     print('Initializing NotificationCubit');
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Foreground message received');
//       addNotification(message);
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('Message opened app');
//       addNotification(message);
//     });
//   }
// }
