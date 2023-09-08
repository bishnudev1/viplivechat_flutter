import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'app_url.dart';

class DeletePostService {
  static var client = http.Client();

  static Future deletePost(String postId) async {
    final queryParameters = {
      "postId": postId,
    };

    final uri =
        Uri.https(Constant.queryUrl, Constant.deletePost, queryParameters);
    http.Response res = await http.delete(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "key": Constant.key,
      },
    );
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      log("Story Delete Response:- ${res.statusCode}");
      log("Story Delete Data:- $data");
      return data;
    } else {
      log("Deler Post StatusCode :- ${res.statusCode}");
    }
  }
}
