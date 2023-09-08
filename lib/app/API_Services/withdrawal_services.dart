import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API%20Models/withdrawal_model.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';

import 'app_url.dart';

class WithdrawalServices extends GetxService {
  Future<WithdrawalModel?>? withdrawalServices(
      {required String paymentGateway, required int diamond}) async {
    final body = jsonEncode({
      "userId": userID,
      "paymentGateway": paymentGateway,
      "description": "hello",
      "diamond": "$diamond",
    });
    final response = await http.post(
      Uri.parse(Constant.baseUrl + Constant.withdrawalUri),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "key": Constant.key
      },
      body: body,
    );
    if (response.statusCode == 200) {
      var data = await jsonDecode(response.body);
      if (data["status"] == true) {
        return WithdrawalModel.fromJson(jsonDecode(response.body));
      } else {
        log("Withdrawal States :- $data");
      }
    } else {
      log("Withdrawal States Code :- ${response.statusCode}");
    }
    return null;
  }
}
