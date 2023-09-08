import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API%20Models/updatefcm_model.dart';
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:rayzi/app/API_Services/update_fcm_services.dart';

import '../API Models/login_model.dart';
import '../data/APP_variables/AppVariable.dart';

class LoginServices extends GetxService {
  Future<LoginModel?> loginServices({
    required String identity,
    required int platformType,
    required String fcmToken,
    required int loginType,
    required String email,
    required String username,
    required String country,
    required String gender,
    File? profileImage,
  }) async {
    try {
      var uri = Uri.parse(Constant.baseUrl + Constant.userLogin);

      var request = http.MultipartRequest("POST", uri);

      http.MultipartFile addImage;
      if (loginType == 0 && profileImage != null) {
        log("++++++++++++++++++++++++++++++++++++++++++++");
        addImage = await http.MultipartFile.fromPath(
            'profileImage', profileImage.path);
        request.files.add(addImage);
      }
      request.headers.addAll({
        'Content-Type': 'application/json; charset=UTF-8',
        "key": Constant.key
      });

      request.headers.addAll({"key": Constant.key});

      Map<String, String> requestBody = <String, String>{
        "identity": identity,
        "platformType": "$platformType",
        "fcm_token": fcmToken,
        "loginType": "$loginType",
        "email": email,
        "name": username,
        "country": country,
        "gender": gender,
      };

      request.fields.addAll(requestBody);
      var res1 = await request.send();
      var response = await http.Response.fromStream(res1);
      if (response.statusCode == 200) {
        log("======================================respons:-${response.body}");
        var userdata = jsonDecode(response.body);
        log("USERDATA==========================$userdata");
        if (userdata["user"]["_id"] != null) {
          log("${userdata["user"]["_id"]}");
          await getstorage.write("UserID", userdata["user"]["_id"]);
          await getstorage.write(
              "UserProfile", userdata["user"]["profileImage"]);
          await getstorage.write('UserName', userdata["user"]["name"]);
          await getstorage.write('Gender', userdata["user"]["gender"]);
          await getstorage.write("Country", userdata["user"]["country"]);
          await getstorage.write("UserCoins", userdata["user"]["coin"]);
          await getstorage.write("UserBio", userdata["user"]["bio"].toString());
          await getstorage.write("UserDOB", userdata["user"]["dob"].toString());
          await getstorage.write("userDiamond", userdata["user"]["diamond"]);
          await getstorage.write('login', true);
          userID = getstorage.read("UserID");
          userName = getstorage.read("UserName");
          userProfile.value = getstorage.read("UserProfile");
          userCoins.value = getstorage.read("UserCoins");
          userGender = getstorage.read("Gender");
          userBio = getstorage.read("UserBio");
          userDOB = getstorage.read("UserDOB");
          userDiamond = getstorage.read("userDiamond");
          updateFCM();
        }
        return LoginModel.fromJson(jsonDecode(response.body));
        //return LoginModel.fromJson(jsonDecode(response.body));
      } else {
        log("login response: ${response.statusCode.toString()}");
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }

  UpdatefcmModel? updatefcmModel;
  Future updateFCM() async {
    var data = await UpdateFCMServices().updateFCMServices();
    updatefcmModel = data;
    if (updatefcmModel!.status == true) {
      log("==== FCM UPDATE ====");
    }
  }
}
