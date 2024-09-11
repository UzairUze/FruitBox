import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruitbox/resources/color/app_colors.dart';
import 'package:fruitbox/resources/components/round_button.dart';
import 'package:fruitbox/resources/routes/routename.dart';
import 'package:fruitbox/viewmodel/controller/auth/auth_view_model.dart';
import 'package:fruitbox/viewmodel/controller/check_connectivity.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final authViewModel _auth = Get.put(authViewModel());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final widthScale = width / 375; // Base width for scaling
    final heightScale = height / 812; // Base height for scaling

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 20 * widthScale, vertical: 20 * heightScale),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Image.asset(
                  'assets/images/splash.png', // Replace with your image path
                ),
              ),
              SizedBox(height: height * 0.03),
              Flexible(
                child: Column(
                  children: [
                    Text(
                      "Fruit Box",
                      style: TextStyle(
                        fontSize: 28 * widthScale,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primaryTextColor,
                      ),
                    ),
                    SizedBox(height: height * 0.012),
                    Text(
                      "Welcome to FruitBox, where you\nfind fresh fruits daily",
                      style: TextStyle(
                        fontSize: 16 * widthScale,
                        color: AppColor.secondaryTextColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: height * 0.03),
                    RoundButton(
                        borderRadius: 30,
                        width: 200 * widthScale,
                        title: 'Login',
                        onPress: () {
                          Get.toNamed(Routename.loginScreen);
                        }),
                    SizedBox(height: height * 0.018),
                    RoundButton(
                      buttonColor: Colors.white38,
                      textColor: AppColor.primaryButtonColor,
                      borderRadius: 30,
                      width: 200 * widthScale,
                      title: 'Sign Up',
                      onPress: () {
                        Get.toNamed(Routename.signUpScreen);
                      },
                    ),
                    SizedBox(height: height * 0.038),
                    Text(
                      "Sign up using",
                      style: TextStyle(
                        fontSize: 14 * widthScale,
                        color: AppColor.secondaryTextColor,
                      ),
                    ),
                    SizedBox(height: height * 0.012),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Image.asset(
                              'assets/icons/Facebook.png'), // Replace with your icon path
                          iconSize: 40 * widthScale,
                          onPressed: () {},
                        ),
                        SizedBox(width: width * 0.02),
                        IconButton(
                          icon: Image.asset(
                              'assets/icons/Google.png'), // Replace with your icon path
                          iconSize: 40 * widthScale,
                          onPressed: () {
                            _auth.signwithGoogle();
                          },
                        ),
                        SizedBox(width: width * 0.02),
                        IconButton(
                            icon: Image.asset(
                                fit: BoxFit.cover,
                                'assets/icons/Phone.png'), // Replace with your icon path
                            iconSize: 40 * widthScale,
                            onPressed: () {
                              Get.toNamed(Routename.SignUpWithNumberScreen);
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
