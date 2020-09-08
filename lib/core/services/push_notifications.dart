import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService{
  final FirebaseMessaging _fcm = FirebaseMessaging();
  Future initialise (){
        if (Platform.isIOS){
          //Request for Permissions
          _fcm.requestNotificationPermissions(IosNotificationSettings());
        }
        //Fire up the Cloud Base Function Internally
     _fcm.configure(
       //Called when the app is on the foreground and we receive a push notification.
       onMessage: (Map<String, dynamic> message) async {
       print ('onMessage: $message');
       },
       //Called when the app has been closed completely and it is opened
       // from the push notification directly.
       onLaunch: (Map<String, dynamic> message) async {
        print ('onLaunch: $message');
       },
       //Called when the app is in the background and it is opened
       //from the push notification.
       onResume: (Map<String, dynamic> message) async {
         print ('onMessage: $message');
       },
     );
  }
}