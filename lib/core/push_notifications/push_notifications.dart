import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:half_grade/core/push_notifications/firebase_options.dart';

class PushNotifications{

  FirebaseMessaging? _testingInstance;

  PushNotifications._internal();
  static final _instance = PushNotifications._internal();
  factory PushNotifications(){
    return _instance;
  }


  FirebaseMessaging get _messagingInstance =>
      _testingInstance == null?FirebaseMessaging.instance : _testingInstance!;

  set testingInstance(FirebaseMessaging instance){
    _testingInstance = instance;
  }


  Future<void> init()async{
    try{
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } on PlatformException{
      /// this exception will be thrown because of the dart vm environment in unit tests
    }

    await _messagingInstance.requestPermission();
    _subscribeToMainTopic();
  }

  // Stream<RemoteMessage> onMessage = FirebaseMessaging.onMessage;
  // void onBackgroundMessage(Future<void> Function(RemoteMessage) handler)=>
  //     FirebaseMessaging.onBackgroundMessage(handler);


  void _subscribeToMainTopic(){
    _messagingInstance.subscribeToTopic('main');
  }

}