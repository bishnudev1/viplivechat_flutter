// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API%20Models/updatefcm_model.dart';
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';

class UpdateFCMServices extends GetxService {
  Future<UpdatefcmModel?> updateFCMServices() async {
    final queryParameters = {"userId": userID, "fcm_token": fcmToken};
    final response = await http.patch(
      Uri.https(Constant.queryUrl, Constant.updateFCMUri, queryParameters),
      headers: {"key": Constant.key},
    );

    if (response.statusCode == 200) {
      print("========>>>>${response.body}");
      return UpdatefcmModel.fromJson(jsonDecode(response.body));
    } else {
      print("FCM StattusCode:-${response.statusCode}");
    }
    return null;
  }
}
