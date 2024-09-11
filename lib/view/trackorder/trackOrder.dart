import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrackOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange.shade300,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            ),
            SizedBox(width: width * 0.02),
            Text(
              'Delivery Status',
              style: TextStyle(color: Colors.black, fontSize: width * 0.045),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: height * .05, horizontal: width * 0.08),
        child: Column(
          children: [
            _buildOrderStatusStep(
              context,
              image: 'assets/icons/ordertoken.png',
              title: 'Order Taken',
              isCompleted: true,
              width: width,
              height: height,
            ),
            _buildOrderStatusStep(
              context,
              image: 'assets/icons/orderbp.png',
              title: 'Order Is Being Prepared',
              isCompleted: true,
              width: width,
              height: height,
            ),
            _buildOrderStatusStep(
              context,
              image: 'assets/icons/rider.png',
              title: 'Order Is Being Delivered',
              subtitle: 'Your delivery agent is coming',
              isCompleted: true,
              isLastStep: false,
              showMap: true,
              width: width,
              height: height,
            ),
            _buildOrderStatusStep(
              context,
              image: 'assets/icons/orderrecived.png',
              title: 'Order Received',
              isCompleted: true,
              isLastStep: true,
              width: width,
              height: height,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderStatusStep(
    BuildContext context, {
    required String image,
    required String title,
    String? subtitle,
    required bool isCompleted,
    bool isLastStep = false,
    bool showMap = false,
    required double width,
    required double height,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: width * 0.06,
                    child: Image(
                      image: AssetImage(image),
                    )),
                if (!isLastStep)
                  Container(
                    height: height * 0.07,
                    width: 2,
                    color: Colors.orange.shade300,
                  ),
              ],
            ),
            SizedBox(width: width * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: width * 0.045),
                  ),
                  if (subtitle != null)
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.01),
                      child: Text(
                        subtitle,
                        style: TextStyle(
                            color: Colors.grey, fontSize: width * 0.035),
                      ),
                    ),
                  if (showMap)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.015),
                      child: Container(
                          height: height * 0.2,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(width * 0.02),
                          ),
                          child: Image.asset(
                            'assets/images/orderdeliver.jpg',
                            fit: BoxFit.fill,
                          )),
                    ),
                ],
              ),
            ),
            if (isCompleted)
              Icon(Icons.check_circle, color: Colors.green, size: width * 0.06),
            if (!isCompleted)
              Icon(Icons.radio_button_unchecked,
                  color: Colors.grey, size: width * 0.06),
          ],
        ),
        SizedBox(height: height * 0.02),
      ],
    );
  }
}
