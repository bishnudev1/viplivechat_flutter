// ignore_for_file: file_names

import 'dart:io';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/API_Services/user_golive_services.dart';
import 'package:rayzi/app/modules/home/views/Live%20Streaming/Live_UserScreen.dart';

import '../../../API Models/user_golive_model.dart';

class GoliveController extends GetxController {
  UserGoLiveModel? userGoLiveModel;
  Future usergoLive({required String userId, File? couverImage}) async {
    if (couverImage != null) {
      userGoLiveModel = await UserGoLive()
          .userGoLiveService(userId: userId, couverImage: couverImage);
    } else {
      userGoLiveModel = await UserGoLive().userGoLiveService(userId: userId);
    }
    await Get.to(LiveUserScreen(
      token: userGoLiveModel!.liveHost!.token!,
      liveRoomId: userGoLiveModel!.liveHost!.liveStreamingId!,
      clientRole: ClientRole.Broadcaster,
      channelName: userGoLiveModel!.liveHost!.channel!,
      liveHostId: userGoLiveModel!.liveHost!.userId!,
      mongoID: userGoLiveModel!.liveHost!.id!,
    ));
  }
}
