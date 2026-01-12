// notification.dart
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationService {
  // Call this once in main.dart or inside your app state
  static Future<void> setupFCM(BuildContext context) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // 1️⃣ Request notification permissions (Android 13+ / iOS)
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');

    // 2️⃣ Get device token for testing
    String? token = await messaging.getToken();
    print("📱 FCM Device Token: $token");

    // 3️⃣ Subscribe to topic
    await messaging.subscribeToTopic('monthly_reminder');
    print('✅ Subscribed to topic: monthly_reminder');

    // 4️⃣ Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('📥 Foreground message: ${message.notification?.title} - ${message.notification?.body}');
      print('Message data: ${message.data}');
      // Optional: show local notification here
    });

    // 5️⃣ Handle background messages (when user taps notification)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('📌 Notification clicked (background)');
      _handleNotificationTap(context);
    });

    // 6️⃣ Handle terminated app state
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      print('📌 Notification clicked (terminated)');
      _handleNotificationTap(context);
    }
  }

  static void _handleNotificationTap(BuildContext context) {
    // Navigate to a specific screen
    Navigator.of(context).pushNamed('/roleSelection');
  }
}
