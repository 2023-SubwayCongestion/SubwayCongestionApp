
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:subway_congestion/firebase_options.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:subway_congestion/key.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> saveTokenToDatabase(String token) async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    String userId = user.uid;

    try {
      CollectionReference tokens = FirebaseFirestore.instance.collection('user_data');

      // 토큰이 이미 있는지 확인합니다.
      var isTokenExists = await tokens.where('token', isEqualTo: token).get();

      // 이미 있는 토큰이 아니면 저장합니다.
      if (isTokenExists.docs.isEmpty) {
        // 토큰과 사용자 ID를 함께 저장하려면 다음과 같이 작성하세요.
        await tokens.add({ 'token': token, 'userId': userId });

        print('새 토큰을 데이터베이스에 저장합니다: $token');
      } else {
        print('이미 존재하는 토큰입니다.');
      }
    } catch (e) {
      print('새 토큰을 데이터베이스에 저장하는 데 실패했습니다: $e');
    }
  } else {
    print('로그인한 사용자가 없습니다.');
  }
}



Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handle a background message : ${message.messageId}");
  print("Background Message data: ${message.notification}");
}

Future<String?> fcmSetting() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    carPlay: true,
    criticalAlert: true,
    provisional: false,
    sound: true,
  );

  print("User granted permission: ${settings.authorizationStatus}");

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'subway_congestion',
    'subway_congestion',
    description: '지하철 혼잡도',
    importance: Importance.max,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    print("Got a message whilst in the foreground!");
    print("Message data: ${message.notification}");

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: android.smallIcon,
          ),
        ),
      );

      print("Message also contained a notification: ${message.notification}");
    }
  });

  String? firebaseToken = await messaging.getToken(vapidKey: FIREBASE_PUSH_KEY);
  print("firebaseToken: ${firebaseToken}");

  if (firebaseToken != null) {
    // 토큰을 데이터베이스에 저장합니다.
    await saveTokenToDatabase(firebaseToken);

    // 새 토큰이 생성될 때마다 업데이트합니다.
    messaging.onTokenRefresh.listen((String token) {
      saveTokenToDatabase(token);
    });
  }

  return firebaseToken;
}



// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("Handle a background message : ${message.messageId}");
// }
//
// Future<String?> fcmSetting() async {
//   //firebase core 기능 사용을 위한 필수 초기화
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//   await messaging.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//
//
//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     announcement: false,
//     carPlay: true,
//     criticalAlert: true,
//     provisional: false,
//     sound: true,
//   );
//
//   print("User granted permission: ${settings.authorizationStatus}");
//
//   //foreground에서의 푸시 알림 표시를 위한 알리 중요도 서정(android)
//   const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'subway_congestion',
//     'subway_congestion',
//     description: '지하철 혼잡도 알림입니다.',
//     importance: Importance.max
//   );
//
//   //foreground에서의 푸시 알람 표시를 위한 local notification 설정
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
//
//   //foreground 푸시 알림 핸들링
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     RemoteNotification? notification = message.notification;
//     AndroidNotification? android = message.notification?.android;
//
//     print("Got a message whilst in the foreground!");
//     print("Message data: ${message.data}");
//
//     if(message.notification != null && android != null){
//       flutterLocalNotificationsPlugin.show(
//         notification.hashCode,
//         notification?.title,
//         notification?.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             channel.id,
//             channel.name,
//             channelDescription: channel.description,
//             icon: android.smallIcon,
//           ),
//         )
//       );
//
//       print("Message also contained a notification: ${message.notification}");
//     }
//   });
//
//   //firebase token 발급
//   String? firebaseToken = await messaging.getToken();
//   print("firebaseToken: ${firebaseToken}");
//
//   return firebaseToken;
// }