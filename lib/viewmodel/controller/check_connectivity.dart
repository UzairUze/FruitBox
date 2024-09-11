import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fruitbox/resources/color/app_colors.dart';
import 'package:fruitbox/utils/utils.dart';
import 'package:get/get.dart';
import 'dart:core';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(
      List<ConnectivityResult> connectivityResult) async {
    if (connectivityResult.contains(ConnectivityResult.none)) {
      debugPrint(connectivityResult.toString());
      Utils.rwsnakbar();
      // Fluttertoast.showToast(
      //   msg: 'please connect to the internet',
      //   backgroundColor: AppColor.primaryColor,
      //   textColor: AppColor.whiteColor,
      //   timeInSecForIosWeb: 5,
      //   fontSize: 20,
      //   gravity: ToastGravity.SNACKBAR,
      // );
      //  Get.snackbar('check internet', 'please connect to the internet');
      // Get.rawSnackbar(
      //     messageText: const Text('PLEASE CONNECT TO THE INTERNET',
      //         style: TextStyle(color: AppColor.primaryColor, fontSize: 14)),
      //     isDismissible: false,
      //     duration: const Duration(days: 1),
      //     backgroundColor: Colors.red[400]!,
      //     icon: const Icon(
      //       Icons.wifi_off,
      //       color: Colors.white,
      //       size: 35,
      //     ),
      //     margin: EdgeInsets.zero,
      //     snackStyle: SnackStyle.GROUNDED);
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}
