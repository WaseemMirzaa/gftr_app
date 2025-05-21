// ignore_for_file: avoid_print
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

/// 🔹 Background FCM handler (runs on both iOS & Android)
@pragma('vm:entry-point')          // <-- required on iOS after iOS 14 +
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('📩 BG Notification');
  _prettyLog(message);
}

/// Helper to log RemoteMessage nicely
void _prettyLog(RemoteMessage m) {
  print('📌 Title : ${m.notification?.title}');
  print('📌 Body  : ${m.notification?.body}');
  print('📌 Data  : ${m.data}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.max,
  );

  /* ───────────────────────────────────── Notifications bootstrap ─────────── */

  Future<String> initNotifications() async {
    // 1️⃣  Permissions
    final settings = await _firebaseMessaging.requestPermission(
      alert: true, badge: true, sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      print('🚫 Notifications permission denied');
      return 'Permission Denied';
    }

    // 2️⃣  FCM/APNs token
    final fcmToken = Platform.isAndroid
        ? await _firebaseMessaging.getToken()
        : await _firebaseMessaging.getAPNSToken();

    // 3️⃣  Listeners
    FirebaseMessaging.onMessageOpenedApp.listen(_handleFCMOpen);
    _firebaseMessaging.getInitialMessage().then(_handleFCMOpen);

    await _initLocalNotifications();   // local-notif plumbing
    await _initPushNotification();     // foreground FCM handler

    print(" fcmToken : $fcmToken");
    return fcmToken ?? 'No Token';
  }

  /* ───────────────────────────────────── Local-notifications plumbing ────── */

  Future<void> _initLocalNotifications() async {
    // iOS-specific: ask for permission *again* for local alerts (iOS quirk).
    final iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,

      // Fires when a local notif is tapped while app **is in foreground**
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        print('🔔 (FG-tap) LocalNotification → payload: $payload');
      },
    );

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    await _localNotifications.initialize(
       InitializationSettings(android: androidInit, iOS: iosInit),

      // Fires when user taps a notif from tray / Notification Center
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print('🔔 (TAP) iOS NotificationResponse → payload: ${response.payload}');
      },
    );

    // Android needs an explicit channel; iOS ignores this call
    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidChannel);
  }

  /* ───────────────────────────────────── FCM foreground handler ──────────── */

  Future<void> _initPushNotification() async {
    FirebaseMessaging.onMessage.listen((message) {
      _prettyLog(message);           // print payload on **all** platforms
      _showLocal(message);           // mirror as local notif so iOS shows banner
    });
  }

  /* ───────────────────────────────────── Helpers ─────────────────────────── */

  void _showLocal(RemoteMessage m) {
    final n = m.notification;
    if (n == null) return;

    _localNotifications.show(
      n.hashCode,
      n.title,
      n.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannel.id,
          _androidChannel.name,
          channelDescription: _androidChannel.description,
          importance: Importance.max,
          priority: Priority.high,
          icon: 'logo',
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: m.data.toString(),   // 🔑 becomes response.payload above
    );
  }

  /// Fired when user taps an FCM-delivered notification (cold-start / bg).
  void _handleFCMOpen(RemoteMessage? message) {
    if (message == null) return;
    print('🛫 Opened-via-FCM → payload: ${message.data}');
    // navKey.currentState?.pushNamed(..., arguments: message);
  }

  /* ───────────────────────────────────── Manual local-notification API ──── */

  void showLocalNotification(String title, String body, {String? payload}) {
    _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          channelDescription: 'This channel is used for important notifications',
          importance: Importance.max,
          priority: Priority.high,
          icon: 'logo',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: payload,
    );
  }
}


Future<void> requestAndroidNotificationPermission() async {
  if (Platform.isAndroid && await Permission.notification.isDenied) {
    final status = await Permission.notification.request();
    if (status.isGranted) {
      print('✅ Notification permission granted on Android');
    } else {
      print('🚫 Notification permission denied on Android');
    }
  }
}
