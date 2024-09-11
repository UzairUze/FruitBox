import 'package:flutter/material.dart';
import 'package:get/get.dart';

class themeController extends GetxController {
  // Observable for dark mode status
  var isDarkMode = false.obs;

  // Method to toggle the theme
  void toggleTheme() {
    if (Get.isDarkMode) {
      Get.changeTheme(lightTheme);
      isDarkMode(false);
    } else {
      Get.changeTheme(darkTheme);
      isDarkMode(true);
    }
  }

  // Define light theme
  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white, // Light theme background color
    primaryColor: Colors.blue,
  );

  // Define dark theme
  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black, // Dark theme background color
    primaryColor: Colors.blue,
  );
}
