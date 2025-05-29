import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gftr/View/Screens/Gftrs.dart';
import 'package:gftr/View/Screens/ManageBottom/gftrStoryViewPage.dart';
import 'package:gftr/View/Screens/ManageBottom/notificationpageview.dart';
import 'package:gftr/View/Screens/gftrStories.dart';
import 'package:gftr/View/Screens/give.dart';
import 'package:gftr/View/Screens/google.dart';
import 'package:gftr/View/Screens/inbox.dart';
import 'package:gftr/View/Widgets/bottomNavigationBar.dart';
import 'package:gftr/main.dart';
import 'package:open_app_settings/open_app_settings.dart' as setting;

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

  Future<String> getToken()async{
   String? fcmToken = Platform.isAndroid ?  await messaging.getToken() : await messaging.getAPNSToken();

   return fcmToken ?? "No Token";

  }

  // ───────────────────────── Android default channel ──────────────────────────
  static const AndroidNotificationChannel defaultChannel =
      AndroidNotificationChannel(
    'high_importance_channel', // MUST match <meta-data> value in AndroidManifest.xml
    'Default Notifications',
    description: 'General notifications for the app',
    importance: Importance.high,
  );


  void handleMessage(RemoteMessage? message) {
  if (message == null) return;

  Future.delayed(Duration(milliseconds: 200)).then((_) {
    notificationRouteKey.currentState?.pushNamed(
    NotificationPageView.inboxRouter
    );
  });
}


  // ────────────────────────── PUBLIC INITIALISER ──────────────────────────────
  /// Call once after login / on app start.
  Future<void> initialise(BuildContext context) async {
    // 1️⃣  Create the channel once.
    await flutterLocalNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(defaultChannel);

    // 2️⃣  iOS / Android foreground presentation.
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );


      FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
      FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // 3️⃣  Listen to messages (foreground & click-through).
    _firebaseNotificationsInitialization(context);
    await _setupInteractMessage(context: context);
  }

  // ─────────────────────── REQUEST PERMISSION (OPTIONAL) ──────────────────────
  Future<void> requestNotificationPermissions() async {
    try {
      final settings = await messaging.requestPermission();
      debugPrint('🔔 Permission status: ${settings.authorizationStatus}');
      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        await setting.OpenAppSettings();
      }
    } catch (e) {
      debugPrint('⚠️ requestNotificationPermissions: $e');
    }
  }

  // ───────────────────────── LOCAL NOTIFICATION HELPERS ───────────────────────
  Future<void> _initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('ic_notification'),
      iOS: DarwinInitializationSettings(),
    );

    await flutterLocalNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (_) => _handleMessage(context, message),
    );
  }

  Future<void> _showNotification(RemoteMessage remoteMessage) async {
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        defaultChannel.id,
        defaultChannel.name,
        channelDescription: defaultChannel.description,
        importance: Importance.high,
        priority: Priority.high,
        icon: 'ic_notification',
        ticker: 'ticker',
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await flutterLocalNotifications.show(
      remoteMessage.messageId.hashCode,
      remoteMessage.notification?.title ?? 'No Title',
      remoteMessage.notification?.body ?? 'No Body',
      details,
    );

  }

  // ───────────────────────────── MESSAGE LISTENERS ────────────────────────────
  void _firebaseNotificationsInitialization(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) async {
      print(message.data);
      debugPrint('🟢 (FG) ${message.notification?.title}');
      debugPrint('🟢 (FG) ${message.notification?.body}');
     
      await _initLocalNotifications(context, message);
      await _showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) => _handleMessage(context, message),
    );
  }

  Future<void> _setupInteractMessage(
      {required BuildContext context}) async {
    final initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) _handleMessage(context, initialMessage);
  }

  // ───────────────────────────── HANDLER ──────────────────────────────────────
  void _handleMessage(BuildContext context, RemoteMessage message) {
    // Example filter; adjust to your needs.
    if (message.notification?.body != null &&
        !message.notification!.body!.startsWith(
          'Dear user, we apologize for the inconvenience',
        )) {
      debugPrint('➡️ Navigate to notifications page');

      notificationRouteKey.currentState!.pushNamed(
        NotificationPageView.inboxRouter
      );
    }
  }
}
