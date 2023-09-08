import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';

import '../API Models/chat_thumblist_model.dart';
import 'app_url.dart';

class ChatThumbListServices extends GetxService {
  Future<ChatThumbListModel?> chatThumbList() async {
    final queryParameters = {"userId": userID};
    final response = await http.get(
      Uri.https(Constant.queryUrl, Constant.chatThumbListUrl, queryParameters),
      headers: {"key": Constant.key},
    );

    if (response.statusCode == 200) {
      log("========>>MESSAGE${response.body}");
      return ChatThumbListModel.fromJson(jsonDecode(response.body));
    } else {
      log("StattusCode:-${response.statusCode}");
    }
    return null;
  }
}
