import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Timer? _repeatingTimer;

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
          requestSoundPermission: true,
          requestBadgePermission: true,
          requestAlertPermission: true,
        );

    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
        );

    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // Handle notification tapped logic here
      },
    );
  }

  Future<void> showInstantNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'instant_channel_id',
          'Instant Notifications',
          channelDescription: 'Channel for instant notifications',
          importance: Importance.max,
          priority: Priority.high,
        );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      id: 0,
      title: 'Instant Notification',
      body: 'This is an instant notification',
      notificationDetails: platformChannelSpecifics,
    );
  }

  Future<void> showScheduledNotification() async {
    print('Scheduling notification in 5 seconds using Future.delayed...');
    Future.delayed(const Duration(seconds: 10), () async {
      await flutterLocalNotificationsPlugin.show(
        id: 1,
        title: 'Scheduled Notification',
        body: 'This notification appeared after 10 seconds!',
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'scheduled_channel_id',
            'Scheduled Notifications',
            channelDescription: 'Channel for scheduled notifications',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
      );
      print('Scheduled notification fired!');
    });
  }

  Future<void> showRepeatingNotification() async {
    // Cancel any existing repeating timer
    _repeatingTimer?.cancel();
    print('Setting up repeating notification using Timer.periodic...');
    _repeatingTimer = Timer.periodic(const Duration(minutes: 1), (timer) async {
      await flutterLocalNotificationsPlugin.show(
        id: 2,
        title: 'Repeating Notification',
        body: 'Notification #${timer.tick} - repeats every minute',
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'repeating_channel_id',
            'Repeating Notifications',
            channelDescription: 'Channel for repeating notifications',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
      );
      print('Repeating notification #${timer.tick} fired!');
    });
  }

  Future<void> showBigTextNotification() async {
    const BigTextStyleInformation
    bigTextStyleInformation = BigTextStyleInformation(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris '
      'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in '
      'reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
      htmlFormatBigText: true,
      contentTitle: 'Big Text Notification',
      htmlFormatContentTitle: true,
      summaryText: 'summary <i>text</i>',
      htmlFormatSummaryText: true,
    );

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'big_text_channel_id',
          'Big Text Notifications',
          channelDescription: 'Channel for big text notifications',
          styleInformation: bigTextStyleInformation,
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      id: 3,
      title: 'Big Text Notification',
      body: 'Expand to see more text',
      notificationDetails: platformChannelSpecifics,
    );
  }

  Future<void> cancelAllNotifications() async {
    _repeatingTimer?.cancel();
    _repeatingTimer = null;
    await flutterLocalNotificationsPlugin.cancelAll();
    print('All notifications and timers cancelled.');
  }
}
