import 'dart:convert';
import 'dart:developer';

import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API_Services/app_url.dart';

import '../API Models/getgift_model.dart';

class GetGiftService extends GetxService {
  static var client = http.Client();

  static Future<GetGiftModel> getGift() async {
    try {
      var uri = Uri.parse(Constant.baseUrl + Constant.getGiftUrl);

      final response = await client.get(uri, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "key": Constant.key,
      });

      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return GetGiftModel.fromJson(data);
      } else {
        log(response.statusCode.toString());
      }
      return GetGiftModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
