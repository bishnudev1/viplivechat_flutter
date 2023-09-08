// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API%20Models/success_purchase_model.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';

import 'app_url.dart';

class SuccessPurchasService extends GetxService {
  Future<SuccessPurchaseModel> successPurchas(
      {required String coinPlanId, required String paymentGateway}) async {
    final url = Uri.parse(Constant.baseUrl + Constant.successPurchaseUri);

    final headers = {
      'key': Constant.key,
      "Content-Type": "application/json; charset=UTF-8",
    };
    final body = jsonEncode({
      'userId': userID,
      "coinPlanId": coinPlanId,
      "paymentGateway": paymentGateway,
    });

    final response = await http.post(url, headers: headers, body: body);

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      log("======= sccessPurchase:-$data");
      return SuccessPurchaseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to search movie title.');
    }
  }
}
