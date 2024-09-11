import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fruitbox/resources/color/app_colors.dart';
import 'package:fruitbox/viewmodel/controller/check_connectivity.dart';
import 'package:get/get.dart';

import '../viewmodel/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashServices splashServices = Get.put(SplashServices());

  @override
  void initState() {
    super.initState();

    splashServices.isLogin(context); // Monitor internet connection
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   splashServices.isLogin(context);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor
          .primaryButtonColor, // Replace with AppColor.primaryButtonColor
      child: Center(
        child: Obx(
          () => Transform.translate(
            offset: Offset(0, splashServices.bounceValue.value),
            child: Image.asset('assets/images/splash.png'),
          ),
        ),
      ),
    );
    // Container(
    //   color: AppColor.primaryButtonColor,
    //   child: const Center(
    //     child: Image(
    //       image: AssetImage('assets/images/splash.png'),
    //       //color: AppColor.primaryButtonColor,
    //     ),
    //   ),
    // );
  }
}
