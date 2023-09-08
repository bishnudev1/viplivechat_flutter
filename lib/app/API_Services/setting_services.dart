// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../API Models/setting_model.dart';
import 'app_url.dart';

class SettingService extends GetxService {
  static Future<Settingmodel?> settingService() async {
    final response = await http.get(
      Uri.parse(Constant.baseUrl + Constant.settingUrl),
      headers: {"key": Constant.key},
    );
    if (response.statusCode == 200) {
      return Settingmodel.fromJson(jsonDecode(response.body));
    } else {
      print("=====Fail====${response.statusCode}");
      return null;
    }
  }
}
