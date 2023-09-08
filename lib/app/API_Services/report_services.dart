// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';

import '../API Models/report_model.dart';
import 'app_url.dart';

class ReportServices extends GetxService {
  Future<ReportModel?> postReportServices({
    required String postID,
    required String reportType,
    required String report,
    required String image,
  }) async {
    var payload = jsonEncode({
      "report": report,
      "image": image,
    }.map((key, value) => MapEntry(key, value.toString())));

    // final queryParameters = (reportType == 0)
    //     ? {"postId": postID, "userId": userID, "reportType": runtimeType}
    //     : {"profileId": postID, "userId": userID, "reportType": runtimeType};
    final queryParameters = (reportType == "0")
        ? {
            "postId": postID,
            "userId": userID,
            "reportType": reportType,
          }
        : {
            "profileId": postID,
            "userId": userID,
            "reportType": reportType,
          };
    print(
        "====PostID==$postID===Reporty==$reportType=====report====$report===Image===$image");

    print(
        "=======URL= ${Uri.https(Constant.queryUrl, Constant.postReport, queryParameters)}");

    final response = await http.post(
        Uri.https(Constant.queryUrl, Constant.postReport, queryParameters),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "key": Constant.key,
        },
        body: payload);

    print("===========${response.statusCode}========${response.body}");
    if (response.statusCode == 200) {
      print("Report response:- ${response.body}");
      return ReportModel.fromJson(jsonDecode(response.body));
    } else {
      print("Report StatusCode :- ${response.statusCode}");
    }
    return null;
  }
}
