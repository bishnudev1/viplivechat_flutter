import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';

class GetAllPostServices extends GetxService {
  /// postType == ALL==0 And ProfilePost==1
  getAllpostServices({required int postType, String? secoundUserId}) async {
    log("====USER ID = $userID Type ===$postType");
    Map<String, String?> queryParameters;
    if (postType == 0) {
      log("================================LOGIN");
      queryParameters = {"loginUser": userID};
    } else {
      queryParameters = {"loginUser": userID, "userId": secoundUserId};
    }
    final response = await http.get(
        Uri.https(Constant.queryUrl, Constant.getPostUrl, queryParameters),
        headers: {"key": Constant.key});

    if (response.statusCode == 200) {
      log("====>> ${response.body}");
      return jsonDecode(response.body);
    } else {
      log("response statusCode := ${response.statusCode}");
    }
    return null;
  }
}
