import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API%20Models/getwithdraw_model.dart';

import 'app_url.dart';

class GetWithdrawService extends GetxService {
  Future<GetWithdrawModel?> getWithdrawService() async {
    final response = await http.get(
        Uri.parse(Constant.baseUrl + Constant.getWithdrawalUri),
        headers: {"key": Constant.key});
    if (response.statusCode == 200) {
      return GetWithdrawModel.fromJson(jsonDecode(response.body));
    } else {
      log('GetWithdraw StatusCode :- ${response.statusCode}');
    }
    return null;
  }
}
