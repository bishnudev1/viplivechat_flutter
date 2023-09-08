import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rayzi/app/API_Services/userlocation_services.dart';

import '../../../API_Services/login_services.dart';
import '../../../data/APP_variables/AppVariable.dart';
import '../../My_App/views/my_app_view.dart';

class QuickLoginController extends GetxController {
  // var getStorage = GetStorage();
  var maleUser = true.obs;
  var femaleUser = false.obs;

  var currentAddress = "";
  //CountryName? countryName;
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  List<String> nicName = [
    "Edward Bailey",
    "Thomas Bailey",
    "Lily Adams",
    "Isabella Kennedy",
    "Charlotte Bailey",
    "Kennedy Marshall",
    "Jackson Edward",
  ];

  ///Tologin
  int? platform;
  int logintype = 0;
  String gender = "";

  @override
  void onInit() {
    super.onInit();
    if (Platform.isAndroid) {
      platform = 0;
    } else if (Platform.isIOS) {
      platform = 1;
    }
    userLocation();
//    location();
  }

  Future userLocation() async {
    var contry = await UserLocation.userLocation();
    log("${contry!.country}");
    locationController.text = contry.country!;
    update();
  }

  Future<void> submit() async {
    if (femaleUser.value == true || maleUser.value == true) {
      if (nameController.text.isNotEmpty) {
        if (maleUser.value) {
          gender = "male";
        } else {
          gender = "female";
        }

        ///=====call API====== ///
        await LoginServices().loginServices(
          identity: androidId,
          platformType: platform!,
          fcmToken: fcmToken,
          loginType: logintype,
          email: "",
          username: nameController.text,
          country: locationController.text,
          gender: gender,
          profileImage: proImage,
        );
        Get.offAll(const MyApp());
      } else {
        Fluttertoast.showToast(
            msg: "Enter Your Name",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Select Your gender",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }

  // getAddressFromLatLng() async {
  //   try {
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //         _currentPosition.latitude, _currentPosition.longitude);
  //
  //     Placemark place = placemarks[0];
  //
  //     currentAddress = "${place.country}";
  //     print("+++++++$currentAddress");
  //     update();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  /// Image Piker
  File? proImage;

  Future cameraImage() async {
    try {
      final imagepike =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (imagepike == null) return;

      final imageTeam = File(imagepike.path);
      proImage = imageTeam;
      update();
      Get.back();
    } on PlatformException catch (e) {
      log("$e");
    }
  }

  Future pickImage() async {
    try {
      final imagepike =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imagepike == null) return;

      final imageTeam = File(imagepike.path);
      proImage = imageTeam;
      update();
      Get.back();
    } on PlatformException catch (e) {
      log("fail $e");
    }
  }

  void chooseName() {
    nicName.shuffle();
    nameController.text = nicName[0];
    update();
  }
}
