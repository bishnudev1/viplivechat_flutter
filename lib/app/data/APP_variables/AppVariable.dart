// ignore_for_file: file_names, constant_identifier_names

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

///// ====== LIVE USER THUMLIST WAVE ======= \\\\\\
String waveLottie = "lottie/wave.json";

///// ====== CAMERA FUNCTION ======= \\\\\\
List<CameraDescription> cameras = [];

///// ====== GETX STORAGE ======= \\\\\\
var getstorage = GetStorage();

///// ====== Reportsheet ======= \\\\\\
enum SingingCharacter { sexualContent, ViolentContent, childAbuse, Spam, Other }

///// ====== login variables ======= \\\\\\
String androidId = "";
String fcmToken = "";
String userID = "";
String userName = "";
String userGender = "";
RxString userProfile = "".obs;
RxInt userCoins = 0.obs;
int userDiamond = 0;
String userBio = "";
String userDOB = "";
File? userUpdateImage;

///// ====== SOCKETS ======= \\\\\\
late io.Socket socket;
late io.Socket liveSocket;
late io.Socket liveStreamingSocket;

///// ====== AGORA ======= \\\\\\
final infoString = <String>[];
// String appId = "f4c3267f905b4d0b9aa726a3ff2f6191";
String appId = "";
//String appCertificate = "e98aacb9378f434496dcbb1e6ac8f714";
String appCertificate = "";
int plusCoins = 0;
int plusdiamond = 0;
int videoCallCharge = 0;
int withdrawLimit = 0;
bool googlepayActive = true;
//// ====== StripePey ======== \\\\\\\
//String stripPublishableKey =
//  "pk_test_51IWywoSGE6fS01MG9U0usNXTW7BufqX1o2eFV4xAWSdTmZhrA7ixXV8EivBuGExwKZQHwH0hHtRvA2ASflY0fGIR00ol26LdEQ";

//String stripSecrateKey =
//  "sk_test_51IWywoSGE6fS01MGf7xcpOZUnrvBGg7oqzz5HSquArnaft5JWVNX860dJSWrZbP9x2SQs7huXP8Okso2Wjkhcv0i00we2AcFVx";
bool stripActive = true;
String stripPublishableKey = "";
String stripSecrateKey = "";

///// ====== RazorPay ======= \\\\\\
//String razorPayKey = "rzp_test_NNbwJ9tmM0fbxj";
bool razorPayActive = true;
String razorPayKey = "";

//// ======== Notification ======== \\\\\\
FirebaseMessaging? messaging;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
RxBool notificationVisit = false.obs;

//// ======== BranchIO ======== \\\\\\
RxBool branchIOVisit = false.obs;

String privacyPolicyLink = "";
String termAndCondition = "";
String contactSupport = "";
String howToWithdraw = "";
var bgCall = false.obs;
