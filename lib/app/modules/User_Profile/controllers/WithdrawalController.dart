import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/API%20Models/getwithdraw_model.dart';
import 'package:rayzi/app/API_Services/getwithdraw_service.dart';
import 'package:rayzi/app/API_Services/withdrawal_services.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/User_Profile/views/WithdrawalMethod.dart';

class WithdrawalController extends GetxController {
  WithdrawalMethod? withdrawalMethod;
  GetWithdrawModel? getWithdrawModel;
  var isLoading = true.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getWithrawal();
  }

  Future getWithrawal() async {
    isLoading.value = true;
    var data = await GetWithdrawService().getWithdrawService();
    getWithdrawModel = data;
    if (getWithdrawModel!.status == true) {
      isLoading.value = false;
    }
  }

  Future withrawal(
      {required String paymentGateway, required int diamond}) async {
    log("==========$paymentGateway==============$diamond}");
    var data = await WithdrawalServices()
        .withdrawalServices(paymentGateway: paymentGateway, diamond: diamond);
    if (data!.status == true) {
      Fluttertoast.showToast(
          msg: "Withdrawal successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: ThemeColor.white,
          textColor: ThemeColor.pink,
          fontSize: 16.0);
      Get.back();
    }
  }
}
