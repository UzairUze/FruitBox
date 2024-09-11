import 'package:flutter/material.dart';
import 'package:fruitbox/resources/components/round_button.dart';
import 'package:fruitbox/resources/routes/routename.dart';
import 'package:get/get.dart';
import 'package:fruitbox/view/trackorder/trackOrder.dart';

class CongratulationsScreen extends StatelessWidget {
  const CongratulationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: width * 0.18,
              backgroundColor: Colors.green.withOpacity(0.2),
              child: Icon(Icons.check_circle,
                  color: Colors.green, size: width * 0.3),
            ),
            SizedBox(height: height * 0.04),
            Text(
              'Congratulations!!!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: width * 0.06,
                color: Colors.black,
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              'Your order has been taken and is being attended to',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: width * 0.045,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: height * 0.05),
            RoundButton(
                fontweight: FontWeight.w500,
                height: height * .07,
                borderRadius: 10,
                width: width * .6,
                title: 'Track Order',
                onPress: () {
                  Get.toNamed(Routename.TrackOrderScreen);
                }),
            SizedBox(height: height * 0.02),
            RoundButton(
                fontweight: FontWeight.w500,
                height: height * .07,
                borderRadius: 10,
                width: width * .6,
                title: 'Continue shopping',
                onPress: () {
                  Get.toNamed(Routename.welcomeScreen);
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required Color color,
    Color? textColor,
    Color? borderColor,
    required VoidCallback onPressed,
    required double width,
    required double height,
  }) {
    return SizedBox(
      width: width * 0.6,
      height: height * 0.07,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor ?? Colors.white,
          backgroundColor: color,
          side: borderColor != null ? BorderSide(color: borderColor) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(width * 0.02),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: width * 0.045,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
