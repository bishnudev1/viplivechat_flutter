import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API%20Models/getsingle_post_model.dart';
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';

class GetSinglePostServices extends GetxService {
  Future<GetSinglePostModel?> getSinglepost(
      {required String secoundUserId, required String postID}) async {
    log("====USER ID = $userID postID===$postID");
    var queryParameters = {
      "loginUser": userID,
      "userId": secoundUserId,
      "postId": postID
    };

    final response = await http.get(
        Uri.https(
            Constant.queryUrl, Constant.getSinglePostUrl, queryParameters),
        headers: {"key": Constant.key});

    if (response.statusCode == 200) {
      log("====>> ${response.body}");
      return GetSinglePostModel.fromJson(jsonDecode(response.body));
    } else {
      log("response statusCode := ${response.statusCode}");
    }
    return null;
  }
}
