import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../resources/color/app_colors.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColor.primaryColor,
      textColor: AppColor.whiteColor,
      fontSize: 20,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static snakbar(String title, message) {
    Get.snackbar(title, message);
  }

  static const KTextStyle = TextStyle(fontSize: 16, color: Colors.white);
  static rwsnakbar() {
    Get.rawSnackbar(
        messageText: const Text('PLEASE CONNECT TO THE INTERNET',
            style: TextStyle(color: AppColor.primaryColor, fontSize: 14)),
        isDismissible: false,
        duration: const Duration(days: 1),
        backgroundColor: Colors.red[400]!,
        icon: const Icon(
          Icons.wifi_off,
          color: Colors.white,
          size: 35,
        ),
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.GROUNDED);
  }
}
