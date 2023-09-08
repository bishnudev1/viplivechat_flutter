// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API_Services/app_url.dart';

import '../data/APP_variables/AppVariable.dart';

class SendLikeServices extends GetxService {
  sendlike(String postId) async {
    final queryParameters = {"postId": postId, "userId": userID};
    final response = await http.post(
      Uri.https(Constant.queryUrl, Constant.sendLike, queryParameters),
      headers: {"key": Constant.key},
    );

    if (response.statusCode == 200) {
      print("====>>>${response.body}");
      return response.body;
    } else {
      print("StstusCode :- ${response.statusCode}");
    }
    return null;
  }
}
