import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API_Services/app_url.dart';

import '../API Models/follow_request_model.dart';
import '../data/APP_variables/AppVariable.dart';

class FollowRequestServices extends GetxService {
  Future<FollowRequestModel?> followRequestServices(String userToId) async {
    log("UserToID : $userToId userFromId : $userID");

    final queryParameters = {"userToId": userToId, "userFromId": userID};

    final response = await http.post(
      Uri.https(Constant.queryUrl, Constant.followRequestUrl, queryParameters),
      headers: {"key": Constant.key},
    );

    if (response.statusCode == 200) {
      log("========>>>>${response.body}");
      return FollowRequestModel.fromJson(jsonDecode(response.body));
    } else {
      log("StattusCode:-${response.statusCode}");
    }
    return null;
  }
}
