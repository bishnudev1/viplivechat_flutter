import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';
import 'package:rayzi/app/data/AppImages.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/Messages/controllers/messages_controller.dart';
import 'package:rayzi/app/modules/Messages/views/FakeMessage.dart';
import 'package:shimmer/shimmer.dart';

import 'Message_Show.dart';

class MessagesView extends StatefulWidget {
  MessagesView({Key? key}) : super(key: key);

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  //MessageData data = MessageData();
  MessagesController controller = Get.put(MessagesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Messages",
          style:
              TextStyle(fontFamily: 'alight', fontSize: 22, color: ThemeColor.pink, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(
        () => (controller.isLoading.value)
            ? buildShimmer
            : (controller.chatListModel!.chatList!.isEmpty)
                ? Center(
                    child: Image.asset(
                      AppImages.nodataImage,
                      height: 200,
                      width: 200,
                    ),
                  )
                : NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                      overscroll.disallowIndicator();
                      return false;
                    },
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: controller.chatListModel!.chatList!.length,
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 7,
                              ),
                              Divider(
                                color: ThemeColor.graylight.withOpacity(0.3),
                                thickness: 0.8,
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                            ],
                          ),
                        );
                      },
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            if (controller.chatListModel!.chatList![index].isFake == true) {
                              Get.to(FakeMessageShow(
                                images: "${controller.chatListModel!.chatList![index].profileImage}",
                                // "${Constant.baseUrl}${controller.chatListModel!.chatList![index].profileImage}",
                                name: "${controller.chatListModel!.chatList![index].name}",
                                userId: '${controller.chatListModel!.chatList![index].userId}',
                                videoUrl: '${Constant.baseUrl}${controller.chatListModel!.chatList![index].video}',
                              ));
                            } else {
                              Get.to(MessageShow(
                                images: "${controller.chatListModel!.chatList![index].profileImage}",
                                name: "${controller.chatListModel!.chatList![index].name}",
                                userId2: '${controller.chatListModel!.chatList![index].userId}',
                                senderId: userID,
                                chatRoomId: "${controller.chatListModel!.chatList![index].topic}",
                              ));
                            }
                          },
                          child: SizedBox(
                            height: 62,
                            child: Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: ThemeColor.graylight,
                                      child: CircleAvatar(
                                        radius: 28,
                                        backgroundColor: ThemeColor.grayIcon,
                                        backgroundImage: (controller.chatListModel!.chatList![index].isFake ==
                                                true)
                                            ? NetworkImage(
                                                // "${Constant.baseUrl}${controller.chatListModel!.chatList![index].profileImage}")
                                                "${controller.chatListModel!.chatList![index].profileImage}")
                                            : NetworkImage(
                                                "${controller.chatListModel!.chatList![index].profileImage}"),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "${controller.chatListModel!.chatList![index].name}",
                                              style: TextStyle(
                                                fontFamily: 'abold',
                                                fontSize: 16.5,
                                                //color: theme_Color.white,
                                                color: ThemeColor.blackback,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          (controller.chatListModel!.chatList![index].messageType == 1)
                                              ? "🎁  Gift"
                                              : "${controller.chatListModel!.chatList![index].message}",
                                          style: TextStyle(
                                              fontFamily: 'alight',
                                              fontSize: 12.5,
                                              //color: theme_Color.white,
                                              color: ThemeColor.blacklight),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Positioned(
                                    top: 5,
                                    right: 0,
                                    child: Text(
                                      "${controller.chatListModel!.chatList![index].time}",
                                      style: TextStyle(
                                          fontFamily: 'alight',
                                          fontSize: 10,
                                          color: ThemeColor.blacklight,
                                          fontWeight: FontWeight.w300),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }

  Shimmer get buildShimmer {
    return Shimmer.fromColors(
      period: const Duration(milliseconds: 1100),
      baseColor: ThemeColor.shimmerBaseColor,
      highlightColor: ThemeColor.shimmerHighlight,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5,
                right: 15,
                left: 15,
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade900,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 57,
                          width: 57,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1.5),
                              shape: BoxShape.circle,
                              color: Colors.red),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 17, left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 15,
                                width: 40,
                                color: Colors.red,
                              ),
                              Container(height: 15, width: 40, color: Colors.red),
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: 15,
                            width: 40,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
