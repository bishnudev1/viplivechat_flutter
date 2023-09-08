import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API%20Models/liveend_history_model.dart';

import 'app_url.dart';

class LiveEndHistoryServices extends GetxService {
  Future<LiveEndHistoryModel?> liveEndServices(
      {required liveStreamingID}) async {
    final queryParameters = {
      "liveStreamingId": liveStreamingID,
    };
    final response = await http.get(
      Uri.https(Constant.queryUrl, Constant.liveEndHistoryUri, queryParameters),
      headers: {"key": Constant.key},
    );

    if (response.statusCode == 200) {
      log("========>>>>${response.body}");
      return LiveEndHistoryModel.fromJson(jsonDecode(response.body));
    } else {
      log("LiveStriminEnd StattusCode:-${response.statusCode}");
    }
    return null;
  }
}
