import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';

import '../API Models/createchat_topic_model.dart';
import 'app_url.dart';

class CreateChatTopicServices extends GetxService {
  Future<CreateChatTopicModel?> createChatTopic(
      {required String userId2}) async {
    final queryParameters = {"receiverId": userId2, "senderId": userID};
    final response = await http.post(
      Uri.https(
          Constant.queryUrl, Constant.createChatTopicUrl, queryParameters),
      headers: {"key": Constant.key},
    );
    if (response.statusCode == 200) {
      log("========>>>>${response.body}");
      return CreateChatTopicModel.fromJson(jsonDecode(response.body));
    } else {
      log("CreateChat Topic StatusCode:-${response.statusCode}");
    }
    return null;
  }
}
