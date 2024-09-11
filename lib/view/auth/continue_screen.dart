import 'package:flutter/material.dart';
import 'package:fruitbox/resources/color/app_colors.dart';
import 'package:fruitbox/resources/routes/routename.dart';
import 'package:fruitbox/view/auth/auth_screen.dart';
import 'package:get/get.dart';

import '../../resources/components/round_button.dart';

///Continue Screen
class continueScreen extends StatefulWidget {
  const continueScreen({super.key});

  @override
  State<continueScreen> createState() => _continueScreenState();
}

class _continueScreenState extends State<continueScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: AppColor.primaryButtonColor,
              child: Center(
                child: Image.asset('assets/images/continue.png'),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(18),
              color: AppColor.whiteColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Get The Freshest Fruit Salad Combo",
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColor.primaryTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 10),
                  const Text(
                    "We deliver the best and freshest fruit salad in town. Order for a combo today!!!",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.secondaryTextColor,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: height * .08),
                  RoundButton(
                    width: width * .9,
                    title: "Let's Continue",
                    onPress: () {
                      Get.toNamed(Routename.authScreen);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
