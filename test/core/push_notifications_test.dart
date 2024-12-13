

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:half_grade/core/push_notifications/push_notifications.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../fixtures/mocks/push_notifications_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FirebaseMessaging>()])
void main(){

  group('push notifications tests', () {

    MockFirebaseMessaging firebaseMessaging = MockFirebaseMessaging();

    test('subscribe to the main topic', () async{
      final PushNotifications instance = PushNotifications()..testingInstance = firebaseMessaging;
      await instance.init();
      verify(firebaseMessaging.subscribeToTopic('main'));

    },);
  },);

}