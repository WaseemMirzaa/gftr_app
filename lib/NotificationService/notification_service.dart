import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gftr/View/Screens/ManageBottom/notificationpageview.dart';
import 'package:gftr/main.dart';

/// Handles all notification-related work.
class NotificationServices {
  NotificationServices._(); // private ctor for singleton
  static final NotificationServices _instance = NotificationServices._();
  factory NotificationServices() => _instance;

  /// Firebase Messaging
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  /// Local notifications
  final FlutterLocalNotificationsPlugin flutterLocalNotifications =
      FlutterLocalNotificationsPlugin();

  /// Notification channel (Android only)
  static const AndroidNotificationChannel defaultChannel =
      AndroidNotificationChannel(
    'high_importance_channel',
    'Default Notifications',
    description: 'General notifications for the app',
    importance: Importance.max,
    playSound: true,
  );

  Future<String> getToken() async {
    // For both iOS and Android, use getToken() which returns the FCM token
    String? fcmToken = await messaging.getToken();
    print('🔑 FCM Token retrieved: $fcmToken');
    return fcmToken ?? "No Token";
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    try {
      // Add a small delay to ensure the app is ready for navigation
      Future.delayed(const Duration(milliseconds: 500)).then((_) {
        if (notificationRouteKey.currentState != null &&
            notificationRouteKey.currentState!.mounted) {
          notificationRouteKey.currentState
              ?.pushNamed(NotificationPageView.inboxRouter);
        }
      });
    } catch (e) {
      debugPrint('⚠️ Error handling notification navigation: $e');
    }
  }

  /// Call once after login / on app start.
  Future<void> initialise(BuildContext context) async {
    await Firebase.initializeApp();

    // 1. Create notification channel (Android)
    await _createNotificationChannel();

    // 2. Initialize local notifications
    await _initLocalNotifications(context);

    // 3. Set notification presentation options
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // 4. Request permissions
    await requestNotificationPermissions();

    // 5. Set up message handlers
    _setUpFirebaseListeners(context);
  }

  Future<void> _createNotificationChannel() async {
    if (Platform.isAndroid) {
      await flutterLocalNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(defaultChannel);
    }
  }

  Future<void> _initLocalNotifications(BuildContext context) async {
    const androidSettings = AndroidInitializationSettings('ic_notification');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await flutterLocalNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (payload) {
        handleMessage(null);
      },
    );
  }

  Future<void> requestNotificationPermissions() async {
    try {
      print('🔔 Requesting notification permissions...');

      // Handle Android 13+ permissions
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt >= 33) {
          final granted = await flutterLocalNotifications
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.requestNotificationsPermission();

          if (granted != true) {
            await AppSettings.openAppSettings(
                type: AppSettingsType.notification);
          }
        }
      }

      // For iOS, request local notification permissions first
      if (Platform.isIOS) {
        final bool? result = await flutterLocalNotifications
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            );
        print('🍎 iOS Local notification permission: $result');
      }

      // Request Firebase permissions
      final settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
        criticalAlert: false,
      );

      print('🔔 Firebase permission status: ${settings.authorizationStatus}');

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('✅ User granted permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        print('⚠️ User granted provisional permission');
      } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
        print('❌ User denied permission');
        await AppSettings.openAppSettings(type: AppSettingsType.notification);
      } else {
        print('❓ Permission status: ${settings.authorizationStatus}');
      }
    } catch (e) {
      print('⚠️ requestNotificationPermissions error: $e');
    }
  }

  void _setUpFirebaseListeners(BuildContext context) {
    // Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      debugPrint('🟢 (FG) ${message.notification?.title}');
      debugPrint('🟢 (FG) ${message.notification?.body}');
      await _showNotification(message);
    });

    // When app is opened from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) handleMessage(message);
    });

    // When app is in background and opened
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

  Future<void> _showNotification(RemoteMessage remoteMessage) async {
    final notification = remoteMessage.notification;
    print('📱 Attempting to show notification: ${notification?.title}');

    if (notification == null) {
      print('⚠️ Notification is null, cannot display');
      return;
    }

    final androidDetails = AndroidNotificationDetails(
      defaultChannel.id,
      defaultChannel.name,
      channelDescription: defaultChannel.description,
      importance: Importance.max,
      priority: Priority.high,
      icon: 'ic_notification',
      ticker: 'ticker',
    );

    final iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'default',
      badgeNumber: 1,
      subtitle: 'GFTR Notification',
      threadIdentifier: 'gftr_notifications',
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    try {
      await flutterLocalNotifications.show(
        remoteMessage.hashCode,
        notification.title ?? 'No Title',
        notification.body ?? 'No Body',
        details,
        payload: remoteMessage.data.toString(),
      );
      print('✅ Notification shown successfully: ${notification.title}');
    } catch (e) {
      print('❌ Error showing notification: $e');
    }
  }
}

// Top-level background handler (must be outside class)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print('🔵 Background message received: ${message.messageId}');
  print('🔵 Title: ${message.notification?.title}');
  print('🔵 Body: ${message.notification?.body}');
  print('🔵 Data: ${message.data}');

  // Show local notification for background messages
  final notificationService = NotificationServices();
  await notificationService._showNotification(message);
}
