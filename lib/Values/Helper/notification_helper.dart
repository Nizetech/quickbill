import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/notification.dart';

class NotificationHelper {
  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', //id
    'Orders Notifications', // title
    description: 'This channel is used for importance notification.',
    importance: Importance.high, showBadge: true, playSound: true,
  );

  Future<void> handleMessage(RemoteMessage message) async {
    // ignore: unnecessary_null_comparison
    RemoteNotification? notification =
        message.notification;
    if (notification != null) {
      plugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          iOS: const DarwinNotificationDetails(
            sound: 'default',
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            importance: Importance.high,
            channelDescription: channel.description,
            enableVibration: true,
            icon: 'drawable/logo',
          ),
        ),
      );
    }
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Got a new message on Foreground! $message');
      Get.to(const NotificationScreen());
      // open the app and navigate to the notification screen
    });
  }

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('drawable/logo');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final InitializationSettings initializationSettings =
        const InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await plugin.initialize(initializationSettings);

    // Create notification channel for Android
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    androidImplementation?.createNotificationChannel(channel);
  }
}
