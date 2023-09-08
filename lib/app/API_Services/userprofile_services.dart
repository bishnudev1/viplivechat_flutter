// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API_Services/app_url.dart';

class UserProfileServices extends GetxService {
  userProfileServices(String userId, String secoundUser) async {
    log("@@@@@@@@@@@$userId@@@@@@@$secoundUser");
    final queryParameters = {
      "loginUserId": userId,
      "profileUserId": secoundUser
    };

    final response = await http.get(
        Uri.https(Constant.queryUrl, Constant.userProfileUrl, queryParameters),
        headers: {"key": Constant.key});
    if (response.statusCode == 200) {
      log("======================RESPONSE ==${response.statusCode}");
      log("======================RESPONSE ==${response.body}");
      print("repons:- ${response.body}");
      return jsonDecode(response.body);
    } else {
      print("statusCode:- ${response.statusCode}");
      return null;
    }
  }
}
