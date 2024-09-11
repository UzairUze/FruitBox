import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../resources/routes/routename.dart';

class SplashServices extends GetxController with SingleGetTickerProviderMixin {
  var bounceValue = 0.0.obs;
  late AnimationController animationController;
  late Animation<double> bounceAnimation;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    bounceAnimation = Tween<double>(begin: 0.0, end: 20.0)
        .chain(CurveTween(curve: Curves.bounceInOut))
        .animate(animationController);

    animationController.addListener(() {
      bounceValue.value = bounceAnimation.value;
    });

    @override
    void onClose() {
      animationController.dispose();
      super.onClose();
    }
  }

  void isLogin(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    final user = _auth.currentUser;
    if (user != null) {
      print(user);
      Timer(Duration(seconds: 3), () => Get.toNamed(Routename.welcomeScreen));
    } else {
      Timer(Duration(seconds: 3), () => Get.toNamed(Routename.continueScreen));
    }
  }
}
