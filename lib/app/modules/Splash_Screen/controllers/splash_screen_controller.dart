// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/API%20Models/setting_model.dart';
import 'package:rayzi/app/API%20Models/updatefcm_model.dart';
import 'package:rayzi/app/API%20Models/user_profile_model.dart';
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:rayzi/app/API_Services/update_fcm_services.dart';
import 'package:rayzi/app/API_Services/userprofile_services.dart';
import 'package:rayzi/app/Branch_IO/BranchIOController.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';
import 'package:rayzi/app/modules/Messages/views/Message_Show.dart';
import 'package:rayzi/app/modules/Messages/views/VideoCallreceive.dart';
import 'package:rayzi/app/modules/home/views/Live%20Streaming/LiveStreamingScreen.dart';
import 'package:rayzi/app/modules/home/views/notification_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../API_Services/setting_services.dart';
import '../../My_App/views/my_app_view.dart';

class SplashScreenController extends GetxController {
  BranchIOController branchIOController = Get.put(BranchIOController());
  var success = false.obs;
  var notActive = false.obs;
  var userBlock = false.obs;
  var profileData;
  var coinget = false.obs;
  UserProfileModel? userProfileModel;
  Settingmodel? settingmodel;
  UpdatefcmModel? updatefcmModel;

  @override
  void onInit() {
    super.onInit();
    initFirebase();
    settingcall();
    if (getstorage.read('login') == true) {
      userID = getstorage.read("UserID");
      userName = getstorage.read("UserName");
      userProfile.value = getstorage.read("UserProfile");
      userCoins.value = getstorage.read("UserCoins");
      userGender = getstorage.read("Gender");
      userBio = getstorage.read("UserBio");
      userDOB = getstorage.read("UserDOB");
      userProfile.value = getstorage.read("UserProfile");
      userCoins.value = getstorage.read("UserCoins");
      updateFCM();
    }
    socket = io.io(
        Constant.baseUrl,
        io.OptionBuilder().setTransports(['websocket']).setQuery(
            {"globalRoom": userID}).build());
    socket.connect();
    socket.onConnect((data) {
      log("user ID :: $userID");
      log("onconnect");
      socket.on("callRequest", (data) {
        log("===================>>>>>>>>> CallRequest listen");
        log("hello caller== $data");
        if (bgCall.value) {
          log("==============================");
        } else {
          Get.to(VideoCallreceive(
            callerName: '${data["callerName"]}',
            callerImage: '${data["callerImage"]}',
            callID: '${data["callId"]}',
            receiveCallData: data,
          ));
        }
      });
    });
  }

  Future settingcall() async {
    var data = await SettingService.settingService();
    settingmodel = data;
    log("${data!.status}");
    success = data.status!.obs;
    log("Success value :: ${success.value}");
    log("Setting is active or not :: ${settingmodel!.setting!.isAppActive}");
    if (success.value && settingmodel!.setting!.isAppActive == true) {
      plusCoins = settingmodel!.setting!.coin!.toInt();
      plusdiamond = settingmodel!.setting!.diamond!.toInt();
      withdrawLimit = settingmodel!.setting!.withdrawLimit!.toInt();
      videoCallCharge = settingmodel!.setting!.videoCallCharge!.toInt();
      //// ==== StripPay ===== \\\\\
      stripActive = settingmodel!.setting!.stripeSwitch!;
      stripPublishableKey =
          settingmodel!.setting!.stripePublishableKey.toString();
      stripSecrateKey = settingmodel!.setting!.stripeSecretKey.toString();
      Stripe.publishableKey = stripPublishableKey;
      log("###################====$stripPublishableKey===$stripSecrateKey");
      //// ==== GooglePay ===== \\\\
      googlepayActive = settingmodel!.setting!.googlePlaySwitch!;
      ///// ====== RazorPay ==== \\\\
      razorPayActive = settingmodel!.setting!.razorPay!;
      razorPayKey = settingmodel!.setting!.razorSecretKey.toString();
      settingmodel!.setting!.agoraCertificate!;
      appId = settingmodel!.setting!.agoraKey!;
      privacyPolicyLink = "${settingmodel!.setting!.privacyPolicyLink}";
      termAndCondition = "${settingmodel!.setting!.termAndCondition}";
      contactSupport = "${settingmodel!.setting!.contactSupport}";
      howToWithdraw = "${settingmodel!.setting!.howToWithdraw}";
      log("plusCoins:- $plusCoins plusdiamond:- $plusdiamond videoCallCharge:-$videoCallCharge");
      if (getstorage.read('login') == true) {
        branchIOController.listenDynamicLinks();
        profileget();
      } else {
        Get.offAll(const MyApp());
      }
    } else {
      notActive.value = true;
    }
  }

  Future updateFCM() async {
    var data = await UpdateFCMServices().updateFCMServices();
    updatefcmModel = data;
    if (updatefcmModel!.status == true) {
      log("==== FCM UPDATE ====");
    }
  }

  //// ====== FireBase Notification ======= \\\\\
  Future profileget() async {
    log("===========$userID");
    profileData =
        await UserProfileServices().userProfileServices(userID, userID);
    if (profileData["status"] == true &&
        getstorage.read('login') == true &&
        profileData["userProfile"]["isBlock"] == false) {
      userCoins.value = profileData["userProfile"]["coin"];
      userDiamond = int.parse("${profileData["userProfile"]["diamond"]}");
      getstorage.write("UserCoins", userCoins.value);
      getstorage.write("userDiamond", userDiamond);
      if (notificationVisit.value == false && branchIOVisit.value == false) {
        Get.offAll(const MyApp());
      }
    } else if (getstorage.read('login') == false &&
        profileData["userProfile"]["isBlock"] == false) {
      Get.offAll(const MyApp());
    } else {
      if (profileData["userProfile"]["isBlock"] == true) {
        userBlock.value = true;
      }
      log("============>>> Status =${profileData["status"]}");
    }
  }

  initFirebase() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await messaging.getToken().then((value) {
      log("this is fcm token = $value");
    });

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      log("notificationVisit with start :- ${notificationVisit.value}");
      notificationVisit.value = !notificationVisit.value;
      log("notificationVisit with SetState :- ${notificationVisit.value}");
      handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      log("this is event log :- $event");
      handleMessage(event);
    });

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        log('Got a message whilst in the foreground!');
        log('Message data: ${message.data}');

        if (message.notification != null) {
          log('Message also contained a notification: ${message.notification}');
        }
        const AndroidInitializationSettings initializationSettingsAndroid =
            AndroidInitializationSettings('mipmap/ic_launcher');
        flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
        flutterLocalNotificationsPlugin?.initialize(
            const InitializationSettings(
                android: initializationSettingsAndroid),
            onDidReceiveNotificationResponse: (payload) {
          log("payload is:- $payload");
          handleMessage(message);
        });
        _showNotificationWithSound(message);
      },
    );
  }

  Future<void> handleMessage(RemoteMessage message) async {
    log("++++++++++++++++++++++++++ ${message.data}=====");

    if (message.data['type'] == 'ADMIN') {
      Get.to(const NotificationScreen());
    } else if (message.data['type'] == 'CHAT') {
      Get.to(MessageShow(
          images: message.data['senderProfileImage'],
          name: message.data['senderName'],
          userId2: message.data["senderId"],
          chatRoomId: message.data["chatRoom"],
          senderId: userID));
    } else if (message.data['type'] == 'LIVE') {
      log("======");
      log("======${message.data["data"]}");
      log("======${message.data["channel"]}");
      log("======${message.data["_id"]}");
      log("======${message.data["liveStreamingId"]}");
      log("======${message.data["name"]}");
      log("======${message.data["profileImage"]}");
      log("======${message.data["mongoId"]}");
      Get.to(
        () => LiveStreamingScreen(
          token: "${message.data["token"]}",
          channelName: "${message.data["channel"]}",
          liveuserid: "${message.data["_id"]}",
          clientRole: ClientRole.Audience,
          liveStrimingid: "${message.data["liveStreamingId"]}",
          liveusername: "${message.data["name"]}",
          liveuserimage: "${message.data["profileImage"]}",
          mongoId: "${message.data["mongoId"]}",
          userDiamond: '${message.data["diamond"]}',
          followstatus: '',
        ),
      );
    }
  }

  Future _showNotificationWithSound(RemoteMessage message) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      '0',
      'tindo',
      channelDescription: 'hello',
      //  icon: 'mipmap/ic_launcher',
      importance: Importance.max,
      priority: Priority.high,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin?.show(
      message.hashCode,
      message.notification!.body.toString(),
      message.notification!.title.toString(),
      platformChannelSpecifics,
      payload: 'Custom_Sound',
    );
  }
}
