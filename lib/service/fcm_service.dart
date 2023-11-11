import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../data/db/local_database.dart';
import '../data/models/news_model.dart';
import '../data/storage/storage_repo.dart';
import '../providers/news_provider.dart';
import 'local_notification_sevice.dart';

String title = "";
String description = "";
String image = "";

Future<void> initFirebase() async {
  bool isSubs=StorageRepository.getBool("subs");

  NewsProvider newsProvider=NewsProvider.instance;
  await Firebase.initializeApp();
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  isSubs? await  FirebaseMessaging.instance.subscribeToTopic("news"):await FirebaseMessaging.instance.unsubscribeFromTopic("news");

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );


  // FOREGROUND MESSAGE HANDLING.
  FirebaseMessaging.onMessage.listen((RemoteMessage message)async {
    title = message.data["title"];
    description = message.data["description"];
    image = message.data["image"];
    debugPrint('DECRIPTION ${message.data['description']}');
    await LocalDatabase.insertNews(NewsModel(title: title, description: description, image: image));
    newsProvider.getNews();
    debugPrint("SAQLANDI");
    LocalNotificationService.instance.showFlutterNotification(message);

  });

  // BACkGROUND MESSAGE HANDLING
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // FROM TERMINATED MODE

  handleMessage(RemoteMessage message)async {
    title = message.data["title"];
    description = message.data["description"];
    image = message.data["image"];
    debugPrint("22222");
    LocalNotificationService.instance.showFlutterNotification(message);
  }

  RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();

  if (remoteMessage != null) {
    handleMessage(remoteMessage);
    await LocalDatabase.insertNews(NewsModel(title: title, description: description, image: image));
    newsProvider.getNews();
  }

  FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  title = message.data["title"];
  description = message.data["description"];
  image = message.data["image"];
  await LocalDatabase.insertNews(NewsModel(title: title, description: description, image: image));
  debugPrint("33333");
}