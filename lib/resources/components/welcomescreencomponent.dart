import 'package:flutter/material.dart';
import 'package:fruitbox/resources/color/app_colors.dart';
import 'package:fruitbox/resources/components/RecommendedComboList.dart';
import 'package:fruitbox/resources/components/cambo_cart_hot.dart';
import 'package:fruitbox/viewmodel/controller/auth/auth_view_model.dart';
import 'package:get/get.dart';

class welcomeScreenComponent extends StatefulWidget {
  const welcomeScreenComponent({super.key});

  @override
  State<welcomeScreenComponent> createState() => _welcomeScreenComponentState();
}

class _welcomeScreenComponentState extends State<welcomeScreenComponent> {
  final _auth = Get.put(authViewModel());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // Scale factor for width and height
    final widthScale = screenWidth / 375.0; // Base width 375.0 (example)
    final heightScale = screenHeight / 812.0; // Base height 812.0 (example)
    return Padding(
      padding: EdgeInsets.all(16.0 * widthScale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///showing user name and profile.
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    _auth.username.value.toString(),
                    style: TextStyle(
                      fontSize: 24 * widthScale,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryTextColor2,
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                )
              ],
            ),
          ),
          SizedBox(height: 8 * heightScale),
          Text(
            "What fruit salad combo do you want today?",
            style: TextStyle(
              fontSize: 18 * widthScale,
              color: AppColor.secondaryTextColor,
            ),
          ),
          SizedBox(height: 20 * heightScale),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0 * widthScale),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30.0 * widthScale),
            ),
            child: TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.search, color: Colors.black54),
                hintText: "Search for fruit salad combos",
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 20 * heightScale),

          ///Recommended Combo Screen Start
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recommended Combo",
                    style: TextStyle(
                      fontSize: 20 * widthScale,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * .02,
                  ),
                  Container(
                    height: 207 * heightScale,
                    child: RecommendedComboList(),
                  ),
                  SizedBox(
                    height: 10 * heightScale,
                  ),

                  ///combo hot card gridview
                  Container(
                    height: 270 * heightScale,
                    child: comboCardHot(),
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
