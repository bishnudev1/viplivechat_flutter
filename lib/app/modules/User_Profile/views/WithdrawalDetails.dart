import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/User_Profile/controllers/WithdrawalController.dart';

class WithdrawalDetails extends StatefulWidget {
  final List? details;
  final String paymentGateway;
  final int diamond;
  const WithdrawalDetails(
      {Key? key,
      required this.details,
      required this.paymentGateway,
      required this.diamond})
      : super(key: key);

  @override
  State<WithdrawalDetails> createState() => _WithdrawalDetailsState();
}

class _WithdrawalDetailsState extends State<WithdrawalDetails> {
  TextEditingController textEditingController = TextEditingController();
  FocusNode commonFocusnode = FocusNode();
  WithdrawalController withdrawalController = Get.put(WithdrawalController());
  @override
  void initState() {
    // TODO: implement initState
    commonFocusnode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                ),
                child: Text("Fill in the details below",
                    style: TextStyle(
                      color: ThemeColor.blackback,
                      fontSize: 25,
                      fontFamily: "abold",
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.details!.length,
                padding: const EdgeInsets.only(left: 15),
                itemBuilder: (context, index) {
                  return Text(
                    "•  ${widget.details![index]}",
                    style: const TextStyle(
                      fontFamily: 'alight',
                      fontSize: 16.5,
                      color: Colors.black,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "* if below all information is correct then your withdraw request is accept *",
                  style: TextStyle(
                    color: ThemeColor.pink,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                height: 200,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextField(
                  controller: textEditingController,
                  maxLines: 8,
                  cursorColor: ThemeColor.blackback,
                  style: TextStyle(
                    fontFamily: 'amidum',
                    fontSize: 16,
                    color: ThemeColor.blackback,
                  ),
                  focusNode: commonFocusnode,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.1),
                    hintText: "Enter Your Details",
                    hintStyle: const TextStyle(
                      fontFamily: 'amidum',
                      fontSize: 16,
                    ),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: ThemeColor.pink)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
              const Spacer(
                flex: 6,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: GestureDetector(
                  onTap: () {
                    withdrawalController.withrawal(
                        paymentGateway: widget.paymentGateway,
                        diamond: widget.diamond);
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: ThemeColor.pink,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          color: ThemeColor.white,
                          fontFamily: 'abold',
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
