import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/WebPages/contactSupportWeb.dart';
import 'package:rayzi/app/WebPages/howToWithdrawWeb.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/User_Profile/views/WithdrawalMethod.dart';

import '../../My_App/views/Broadcast_Screen.dart';

class GetMoney extends StatefulWidget {
  const GetMoney({Key? key}) : super(key: key);

  @override
  State<GetMoney> createState() => _GetMoneyState();
}

class _GetMoneyState extends State<GetMoney> {
  TextEditingController textEditingController = TextEditingController();
  final TextEditingController coinController =
      TextEditingController(text: "${userCoins.value}");
  FocusNode commonFocusnode = FocusNode();
  double miniDoller = (withdrawLimit * 1) / plusdiamond;
  @override
  void initState() {
    // TODO: implement initState
    commonFocusnode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  double autoCalculatedText = userCoins.value / 50;
  void calculateText(int input) {
    setState(() {
      autoCalculatedText = input / 50;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: 50,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: ImageIcon(
                    const AssetImage(
                      "Images/new_dis/back.png",
                    ),
                    size: 25,
                    color: ThemeColor.blackback,
                  ),
                ),
                const SizedBox(
                  width: 26,
                ),
                Text(
                  "Get money",
                  style: TextStyle(
                      fontFamily: 'abold',
                      fontSize: 22,
                      color: ThemeColor.blackback),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.bottomSheet(menusheet());
                  },
                  child: Icon(
                    Icons.more_vert_outlined,
                    size: 30,
                    color: ThemeColor.grayIcon,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                color: ThemeColor.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                    color: ThemeColor.greAlpha20.withOpacity(0.15), width: 1.5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text(
                    "Great job!",
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'abold',
                        color: ThemeColor.blackback),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Only ",
                        style: TextStyle(
                            color: ThemeColor.blackback,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      Image.asset(
                        "Images/Profile/diamond.png",
                        height: 16,
                        width: 16,
                      ),
                      Text(
                        (userDiamond < withdrawLimit)
                            ? " ${withdrawLimit - userDiamond} left to get"
                            : "0 left to get",
                        style: TextStyle(
                            color: ThemeColor.blackback,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "\$$miniDoller",
                    style: TextStyle(
                        fontFamily: 'abold',
                        color: ThemeColor.blackback,
                        fontSize: 45),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ThemeColor.greAlpha20.withOpacity(0.2),
                      ),
                      // child: Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Container(
                      //       width: 10,
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.only(
                      //             topLeft: Radius.circular(10),
                      //             bottomLeft: Radius.circular(10)),
                      //         color: Colors.blueAccent.shade100,
                      //       ),
                      //     ),
                      //     Expanded(
                      //         child: Container(
                      //       color: Colors.transparent,
                      //     ))
                      //   ],
                      // ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: LinearProgressIndicator(
                          backgroundColor:
                              ThemeColor.greAlpha20.withOpacity(0.2),
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.blueAccent.shade100),
                          value: userDiamond / withdrawLimit,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: GestureDetector(
              onTap: () {
                if (userDiamond >= withdrawLimit) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return withdrawalDialog();
                    },
                  );
                } else {
                  Fluttertoast.showToast(
                      msg: "Not Sufficient Diamond",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: ThemeColor.white,
                      textColor: ThemeColor.pink,
                      fontSize: 16.0);
                }
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: ThemeColor.white,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                      color: ThemeColor.greAlpha20.withOpacity(0.15),
                      width: 1.5),
                ),
                alignment: Alignment.center,
                child: Text("+ Add withdrawal method",
                    style: TextStyle(
                        fontFamily: 'abold',
                        color: ThemeColor.blackback,
                        fontSize: 20)),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: GestureDetector(
              onTap: () => Get.to(BroadCastScreen()),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: ThemeColor.pink,
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "Images/Center_Tab/video-camera.png",
                      color: ThemeColor.white,
                      height: 25,
                      width: 25,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Go Live",
                      style: TextStyle(
                          color: ThemeColor.white,
                          fontFamily: 'abold',
                          fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      )),
    );
  }

  Dialog withdrawalDialog() {
    return Dialog(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
      child: StatefulBuilder(
        builder: (context, setState1) => Container(
          height: 300,
          decoration: BoxDecoration(
            color: ThemeColor.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: ThemeColor.blackback.withOpacity(0.08),
                        ),
                        child: Icon(Icons.close,
                            color: ThemeColor.blackback.withOpacity(0.8)),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Note :- ",
                      style: TextStyle(
                        fontSize: 18,
                        color: ThemeColor.pink,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: "Minimum $miniDoller\$ Withdraw",
                      style: TextStyle(
                        fontSize: 15,
                        color: ThemeColor.blackback,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.only(left: 40, right: 40),
                height: 55,
                width: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 70,
                      child: TextField(
                        maxLength: 6,
                        onChanged: (value) {
                          setState1(() {
                            calculateText(int.parse(value));
                          });
                        },
                        controller: coinController,
                        cursorColor: Colors.black,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true, signed: false),
                        decoration: const InputDecoration(
                            border: InputBorder.none, counterText: ""),
                      ),
                    ),
                    Text(
                      "=",
                      style: TextStyle(
                        color: ThemeColor.pink,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "\$ $autoCalculatedText",
                      style: TextStyle(
                          color: ThemeColor.pinklight,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Text(
              //   "Coin to Withdraw",
              //   style: TextStyle(
              //     color: ThemeColor.pink,
              //     fontWeight: FontWeight.w500,
              //     fontSize: 20,
              //   ),
              // ),
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () async {
                  if (coinController.text.isEmpty) {
                    Fluttertoast.showToast(
                      msg: "Please Enter your withdraw diamond...",
                      backgroundColor: Colors.white,
                      fontSize: 15,
                      textColor: ThemeColor.pink,
                      timeInSecForIosWeb: 4,
                    );
                  } else if (userDiamond < withdrawLimit) {
                    Fluttertoast.showToast(
                      msg: "No Enough diamond to withdraw",
                      backgroundColor: Colors.white,
                      fontSize: 15,
                      textColor: ThemeColor.pink,
                      timeInSecForIosWeb: 4,
                    );
                  } else if (int.parse(coinController.text) > userDiamond) {
                    Fluttertoast.showToast(
                      msg: "Withdraw coin are mote then total coin",
                      backgroundColor: ThemeColor.white,
                      fontSize: 15,
                      textColor: ThemeColor.pink,
                      timeInSecForIosWeb: 4,
                    );
                  } else {
                    Get.to(WithdrawalMethod(
                      diamond: int.parse(coinController.text),
                    ));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    height: 50,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: ThemeColor.pink,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Next",
                      style: TextStyle(
                          color: ThemeColor.white,
                          fontSize: 18,
                          fontFamily: 'abold'),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Container menusheet() {
    return Container(
      height: 155,
      decoration: BoxDecoration(
        color: ThemeColor.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(14),
          topLeft: Radius.circular(14),
        ),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 6.5,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: ThemeColor.pink,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "Images/User_Profile/information.png",
                  height: 25,
                  width: 25,
                  color: ThemeColor.blackback,
                ),
                const SizedBox(
                  width: 25,
                ),
                GestureDetector(
                  onTap: () => Get.to(() => const HowToWithdrawWeb()),
                  child: Text(
                    "how to withdraw earnings",
                    style: TextStyle(
                      color: ThemeColor.blackback,
                      fontSize: 20,
                      fontFamily: 'amidum',
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "Images/User_Profile/rubber-ring.png",
                  height: 25,
                  width: 25,
                  color: ThemeColor.blackback,
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () => Get.to(() => const ContactSupportWeb()),
                  child: Text(
                    "Contact Support",
                    style: TextStyle(
                      color: ThemeColor.blackback,
                      fontSize: 20,
                      fontFamily: 'amidum',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
