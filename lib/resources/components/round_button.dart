import 'dart:ui';

import 'package:flutter/material.dart';
import '../color/app_colors.dart';

class RoundButton extends StatelessWidget {
  /// Round button component
  const RoundButton(
      {Key? key,
      this.buttonColor = AppColor.primaryButtonColor,
      this.textColor = AppColor.whiteColor,
      required this.title,
      required this.onPress,
      this.width = 60,
      this.height = 50,
      this.loading = false,
      this.borderRadius = 10,
      this.Fontsize = 18,
      this.borderColor = AppColor.primaryButtonColor,
      this.fontweight = FontWeight.normal})
      : super(key: key);

  final bool loading;
  final String title;
  final double height, width;
  final VoidCallback onPress;
  final FontWeight fontweight;
  final Color textColor, buttonColor, borderColor;
  final double borderRadius, Fontsize;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            border: Border.all(
              color: borderColor, // Border color
              width: 3,
            ),
            color: buttonColor,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: loading
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: Fontsize,
                      color: textColor,
                      fontWeight: fontweight),
                ),
              ),
      ),
    );
  }
}
