// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rayzi/app/data/AppImages.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/User_Profile/views/user_profile_view.dart';
import 'package:rayzi/app/modules/home/controllers/home_controller.dart';
import 'package:rayzi/app/modules/home/views/Live%20Streaming/FakeLiveStreaming.dart';
import 'package:shimmer/shimmer.dart';
import '../../../data/APP_variables/AppVariable.dart';
import '../../My_App/controllers/my_app_controller.dart';
import '../../User_Profile/views/Following_Screen.dart';
import 'Live Streaming/LiveStreamingScreen.dart';
import 'notification_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  HomeController homeController = Get.put(HomeController());
  MyAppController myAppController = Get.put(MyAppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(Get.width, 56),
          child: AppBar(
            title: SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Get.to(const UserProfileView()),
                    child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: (userProfile.value == "")
                            ? CircleAvatar(
                                backgroundColor: Colors.grey.withOpacity(0.8),
                                radius: 16,
                                backgroundImage:
                                    (getstorage.read('Gender') == "male")
                                        ? AssetImage(
                                            AppImages.maleUser,
                                          )
                                        : AssetImage(
                                            AppImages.femaleUser,
                                          ),
                              )
                            : Obx(
                                () => CircleAvatar(
                                  backgroundColor: Colors.grey.withOpacity(0.8),
                                  radius: 16,
                                  backgroundImage:
                                      NetworkImage(userProfile.value),
                                ),
                              )),
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  InkWell(
                    onTap: () {
                      myAppController.changeTabIndex(4);
                    },
                    splashFactory: NoSplash.splashFactory,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            height: 16,
                            width: 16,
                            child: Image.asset(AppImages.coinImages)),
                        const SizedBox(
                          width: 2.5,
                        ),
                        Obx(
                          () => Text(
                            (userCoins.value == 0) ? "0" : "${userCoins.value}",
                            style: TextStyle(
                                fontSize: 16,
                                // color: theme_Color.white,
                                color: ThemeColor.blackback,
                                fontFamily: 'abold'),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Get.to(const FollowingScreen()),
                    child: SizedBox(
                      height: 23,
                      width: 23,
                      child: Image.asset("Images/Addfriend.png",
                          color: ThemeColor.blackback),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: () => Get.to(const NotificationScreen()),
                    child: SizedBox(
                      height: 23,
                      width: 23,
                      child: Image.asset(
                        "Images/notification3.png",
                        color: ThemeColor.blackback,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            elevation: 0,
          )),
      body: RefreshIndicator(
        color: ThemeColor.pink,
        onRefresh: () async {
          await homeController.thumbList();
        },
        child: NestedScrollView(
          physics: const ScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 1,
                    ),
                    /*             Obx(
                      () => Stack(
                        alignment: Alignment.center,
                        children: [
                          (homeController.images.isNotEmpty)
                              ? CarouselSlider(
                                  options: CarouselOptions(
                                    enableInfiniteScroll: false,
                                    autoPlay: true,
                                    height: 134,
                                    viewportFraction: 1,
                                    initialPage: 0,
                                    onPageChanged: (index, reason) {
                                      homeController.initialIndex.value = index;
                                    },
                                  ),
                                  items: homeController.images.map((i) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(BannerWeb(
                                            uri: homeController.bannerUri[homeController.initialIndex.value]));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5, right: 5),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            child: Image.network(
                                              Constant.baseUrl + i,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(left: 5, right: 5),
                                  child: Container(
                                    color: ThemeColor.grayIcon.withOpacity(0.4),
                                    width: double.infinity,
                                    // padding: EdgeInsets.only(left: 5, right: 5),
                                    child: const ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                          Positioned(
                            bottom: 10,
                            child: Obx(
                              () => AnimatedSmoothIndicator(
                                onDotClicked: animateToSlide,
                                activeIndex: homeController.initialIndex.value,
                                count: homeController.images.length,
                                axisDirection: Axis.horizontal,
                                // curve: Curves.easeInCubic,
                                effect: WormEffect(
                                    dotHeight: 7.5,
                                    dotWidth: 7.5,
                                    activeDotColor: ThemeColor.pink,
                                    dotColor: ThemeColor.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),*/
                  ],
                ),
              ),
            ];
          },
          body: RefreshIndicator(
            onRefresh: () async {
              await homeController.thumbList();
              setState(() {});
            },
            color: ThemeColor.pink,
            child: Obx(
              () => (homeController.isLoading.value)
                  ? shimmer()
                  : (homeController.userThumbListModel!.user!.isEmpty)
                      ? Center(
                          child: Image.asset(
                            AppImages.nodataImage,
                            height: 200,
                            width: 200,
                          ),
                        )
                      : CustomScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          slivers: [
                            SliverPadding(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, bottom: 15, top: 5),
                              sliver: SliverGrid(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 4,
                                  crossAxisSpacing: 2,
                                  childAspectRatio: 0.9,
                                ),
                                delegate: SliverChildBuilderDelegate(
                                  childCount: homeController
                                      .userThumbListModel!.user!.length,
                                  (context, index) {
                                    // log("user data length :: ${homeController.userThumbListModel!.user!.length}");
                                    // log("user profile image :: ${homeController.userThumbListModel!.user![index].profileImage}");
                                    // log("user fake or not :: ${homeController.userThumbListModel!.user![index].isFake}");
                                    return GestureDetector(
                                      onTap: () {
                                        if (homeController.userThumbListModel!
                                                .user![index].isFake ==
                                            true) {
                                          log("Is Fake True");
                                          Get.to(() => FakeLiveStreaming(
                                                username: homeController
                                                    .userThumbListModel!
                                                    .user![index]
                                                    .name!,
                                                videourl: homeController
                                                    .userThumbListModel!
                                                    .user![index]
                                                    .video!,
                                                profileIamge: homeController
                                                    .userThumbListModel!
                                                    .user![index]
                                                    .profileImage!,
                                                userCoin:
                                                    "${homeController.userThumbListModel!.user![index].coin!}",
                                                userId: homeController
                                                    .userThumbListModel!
                                                    .user![index]
                                                    .userId!,
                                              ));
                                        } else {
                                          log("Is Fake false");
                                          Get.to(LiveStreamingScreen(
                                            token: homeController
                                                .userThumbListModel!
                                                .user![index]
                                                .token!,
                                            channelName: homeController
                                                .userThumbListModel!
                                                .user![index]
                                                .channel!,
                                            liveuserid: homeController
                                                .userThumbListModel!
                                                .user![index]
                                                .userId!,
                                            clientRole: ClientRole.Audience,
                                            liveStrimingid: homeController
                                                .userThumbListModel!
                                                .user![index]
                                                .liveStreamingId!,
                                            liveusername: homeController
                                                .userThumbListModel!
                                                .user![index]
                                                .name!,
                                            liveuserimage: homeController
                                                .userThumbListModel!
                                                .user![index]
                                                .profileImage!,
                                            mongoId:
                                                "${homeController.userThumbListModel!.user![index].id}",
                                            userDiamond:
                                                '${homeController.userThumbListModel!.user![index].diamond}',
                                            followstatus:
                                                '${homeController.userThumbListModel!.user![index].friends}',
                                          ));
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: ThemeColor.greAlpha20,
                                            image: DecorationImage(
                                                image: (homeController
                                                            .userThumbListModel!
                                                            .user![index]
                                                            .isFake ==
                                                        true)
                                                    ? NetworkImage(
                                                        "${homeController.userThumbListModel!.user![index].coverImage}")
                                                    : NetworkImage(
                                                        homeController
                                                            .userThumbListModel!
                                                            .user![index]
                                                            .coverImage
                                                            .toString()),
                                                fit: BoxFit.cover)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5, top: 5),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                height: 30,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Colors.black54,
                                                ),
                                                child: SizedBox(
                                                  height: 50,
                                                  width: 70,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Lottie.asset(
                                                        //allGridList[index].lottie,
                                                        waveLottie,
                                                        fit: BoxFit.cover,
                                                        reverse: true,
                                                        repeat: true,
                                                        animate: true,
                                                        height: 18,
                                                        width: 10,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        homeController
                                                            .userThumbListModel!
                                                            .user![index]
                                                            .totalUser
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontFamily: "abold",
                                                            color: Colors.white,
                                                            fontSize: 12),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.5, bottom: 5),
                                              child: SizedBox(
                                                height: 38,
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 16,
                                                      backgroundColor:
                                                          ThemeColor.pink,
                                                      child: CircleAvatar(
                                                        radius: 15,
                                                        backgroundColor: Colors
                                                            .grey
                                                            .withOpacity(0.8),
                                                        backgroundImage: (homeController
                                                                    .userThumbListModel!
                                                                    .user![
                                                                        index]
                                                                    .isFake ==
                                                                true)
                                                            ? NetworkImage(
                                                                "${homeController.userThumbListModel!.user![index].profileImage}")
                                                            : NetworkImage(
                                                                homeController
                                                                    .userThumbListModel!
                                                                    .user![
                                                                        index]
                                                                    .profileImage
                                                                    .toString()),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                          height: 3,
                                                        ),
                                                        Text(
                                                          "${homeController.userThumbListModel!.user![index].name}",
                                                          style:
                                                              const TextStyle(
                                                            fontFamily: 'abold',
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .location_on_outlined,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 13,
                                                                ),
                                                                SizedBox(
                                                                  height: 2.2,
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              //allGridList[index].country,
                                                              "${homeController.userThumbListModel!.user![index].country}",
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'alight',
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      12.5),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
            ),
          ),
        ),
      ),
    );
  }

  CarouselController controller = CarouselController();

  void animateToSlide(int index) => controller.animateToPage(index);

  Shimmer shimmer() {
    return Shimmer.fromColors(
      highlightColor: ThemeColor.shimmerHighlight,
      baseColor: ThemeColor.shimmerBaseColor,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding:
                const EdgeInsets.only(left: 5, right: 5, bottom: 15, top: 5),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 2,
                childAspectRatio: 0.9,
              ),
              delegate: SliverChildBuilderDelegate(
                childCount: 10,
                (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.red),
                    // child: Column(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 5, top: 5),
                    //       child: Container(
                    //         padding: const EdgeInsets.symmetric(horizontal: 5),
                    //         height: 30,
                    //         width: 70,
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(8),
                    //           color: Colors.black54,
                    //         ),
                    //         child: Container(
                    //           height: 50,
                    //           width: 70,
                    //           child: Row(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceEvenly,
                    //             children: [
                    //               Lottie.asset(
                    //                 //allGridList[index].lottie,
                    //                 waveLottie,
                    //                 fit: BoxFit.cover,
                    //                 reverse: true,
                    //                 repeat: true,
                    //                 animate: true,
                    //                 height: 18,
                    //                 width: 10,
                    //               ),
                    //               const SizedBox(
                    //                 width: 5,
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 5.5, bottom: 5),
                    //       child: Container(
                    //         height: 38,
                    //         child: Row(
                    //           children: [
                    //             CircleAvatar(
                    //               radius: 16,
                    //               backgroundColor: ThemeColor.pink,
                    //               child: CircleAvatar(
                    //                 radius: 15,
                    //                 backgroundColor:
                    //                     Colors.grey.withOpacity(0.8),
                    //                 backgroundImage: (homeController
                    //                             .userThumbListModel!
                    //                             .user![index]
                    //                             .isFake ==
                    //                         true)
                    //                     ? NetworkImage(
                    //                         "${Constant.baseUrl}${homeController.userThumbListModel!.user![index].profileImage.toString()}")
                    //                     : NetworkImage(
                    //                         "${homeController.userThumbListModel!.user![index].profileImage.toString()}"),
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               width: 5,
                    //             ),
                    //             Column(
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 SizedBox(
                    //                   height: 3,
                    //                 ),
                    //                 Text(
                    //                   //allGridList[index].name,
                    //                   "${homeController.userThumbListModel!.user![index].name}",
                    //                   style: TextStyle(
                    //                     fontFamily: 'abold',
                    //                     color: Colors.white,
                    //                     fontSize: 14,
                    //                   ),
                    //                 ),
                    //                 Row(
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.start,
                    //                   children: [
                    //                     Column(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.start,
                    //                       children: [
                    //                         Icon(
                    //                           Icons.location_on_outlined,
                    //                           color: Colors.white,
                    //                           size: 13,
                    //                         ),
                    //                         SizedBox(
                    //                           height: 2.2,
                    //                         ),
                    //                       ],
                    //                     ),
                    //                     const SizedBox(
                    //                       width: 5,
                    //                     ),
                    //                     Text(
                    //                       //allGridList[index].country,
                    //                       "${homeController.userThumbListModel!.user![index].country}",
                    //                       style: TextStyle(
                    //                           fontFamily: 'alight',
                    //                           color: Colors.white,
                    //                           fontSize: 12.5),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///
//TabBar(
//   indicatorPadding: EdgeInsets.only(left: 40, right: 40),
//   indicatorWeight: 5,
//   indicatorColor: theme_Color.pink,
//   tabs: [
//     Tab(text: "live"),
//     Tab(text: "gg"),
//     Tab(text: "Cart"),
//   ],
// ),
// TabBarView(
//   children: [
//     SafeArea(
//         child: Column(
//           children: [
//             Container(
//               height: 200,
//               width: double.infinity,
//               padding: EdgeInsets.symmetric(vertical: 5),
//               child: CarouselSlider(
//                 options: CarouselOptions(
//                   enableInfiniteScroll: true,
//                   autoPlay: true,
//                   enlargeCenterPage: true,
//                   viewportFraction:
//                   1, //roted thai tyare said ni screen na dekhay
//                   //aspectRatio: ,
//                   initialPage: 0,
//                   // pageSnapping:,
//                 ),
//                 items: Banner_Image.banner.map((i) {
//                   return Container(
//                     width: double.infinity,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(12),
//                       ),
//                       child: Image.asset(
//                         i,
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ],
//         )),
//     SafeArea(
//         child: Column(
//           children: [
//             Container(
//               height: 200,
//               width: double.infinity,
//               padding: EdgeInsets.symmetric(vertical: 5),
//               child: CarouselSlider(
//                 options: CarouselOptions(
//                   enableInfiniteScroll: true,
//                   autoPlay: true,
//                   enlargeCenterPage: true,
//                   viewportFraction:
//                   1, //roted thai tyare said ni screen na dekhay
//                   //aspectRatio: ,
//                   initialPage: 0,
//                   // pageSnapping:,
//                 ),
//                 items: Banner_Image.banner.map((i) {
//                   return Container(
//                     width: double.infinity,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(12),
//                       ),
//                       child: Image.asset(
//                         i,
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ],
//         )),
//     SafeArea(
//         child: Column(
//           children: [
//             Container(
//               height: 200,
//               width: double.infinity,
//               padding: EdgeInsets.symmetric(vertical: 5),
//               child: CarouselSlider(
//                 options: CarouselOptions(
//                   enableInfiniteScroll: true,
//                   autoPlay: true,
//                   enlargeCenterPage: true,
//                   viewportFraction:
//                   1, //roted thai tyare said ni screen na dekhay
//                   //aspectRatio: ,
//                   initialPage: 0,
//                   // pageSnapping:,
//                 ),
//                 items: Banner_Image.banner.map((i) {
//                   return Container(
//                     width: double.infinity,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(12),
//                       ),
//                       child: Image.asset(
//                         i,
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ],
//         )),
//   ],
// ),
