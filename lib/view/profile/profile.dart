import 'package:flutter/material.dart';
import 'package:fruitbox/resources/color/app_colors.dart';
import 'package:fruitbox/resources/routes/routename.dart';
import 'package:fruitbox/viewmodel/controller/auth/auth_view_model.dart';
import 'package:fruitbox/viewmodel/controller/themecontroller/themecontroller.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  final _auth = Get.put(authViewModel());

  // final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final _auth = Get.put(authViewModel());
    final _theme = Get.put(themeController());
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(height: height * 0.05),
          CircleAvatar(
            radius: height * 0.08,
            backgroundImage: AssetImage(
                'assets/images/profile.png'), // Replace with your image asset
            child: Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                radius: height * 0.025,
                child: IconButton(
                  color: Colors.orange,
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                ),
              ),
            ),
          ),
          SizedBox(height: height * 0.02),
          Obx(
            () => Text(
              _auth.username.value.toString(),
              style: TextStyle(
                  fontSize: height * 0.03,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryTextColor2),
            ),
          ),
          SizedBox(height: height * 0.005),

          ///this textbox for id
          // Text(
          //   '8967452743',
          //   style: TextStyle(
          //     fontSize: screenHeight * 0.02,
          //     color: Colors.grey,
          //   ),
          // ),
          //  SizedBox(height: screenHeight * 0.005),
          Obx(
            () => Text(
              _auth.useremail.value.toString(),
              style: TextStyle(
                fontSize: height * 0.02,
                color: AppColor.secondaryTextColor,
              ),
            ),
          ),
          SizedBox(height: height * 0.03),

          ///Text button List started
          Expanded(
            child: ListView(
              children: [
                ProfileMenuItem(
                  icon: Icons.history,
                  text: 'Order History',
                  onTap: () {
                    // Handle tap
                  },
                ),
                // ProfileMenuItem(
                //   icon: Icons.location_on,
                //   text: 'Shipping Address',
                //   onTap: () {
                //     // Handle tap
                //   },
                // ),
                Obx(() => ProfileMenuItem(
                      icon: _theme.isDarkMode.value
                          ? Icons.light_mode_outlined
                          : Icons.mode_night_outlined,
                      text: 'Theme mode',
                      onTap: _theme.toggleTheme,
                    )),
                ProfileMenuItem(
                  icon: Icons.privacy_tip,
                  text: 'Privacy Policy',
                  onTap: () {
                    Get.toNamed(Routename.PrivacyPolicyPage);
                  },
                ),
                ProfileMenuItem(
                  icon: Icons.settings,
                  text: 'Settings',
                  onTap: () {
                    // Handle tap
                  },
                ),
                ProfileMenuItem(
                  icon: Icons.logout,
                  text: 'Log out',
                  onTap: () {
                    _auth.logout();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  ProfileMenuItem({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return ListTile(
      leading: Icon(
        icon,
        color: AppColor.primaryColor,
        size: screenHeight * 0.04,
      ),
      title: Text(
        text,
        style: TextStyle(
            fontSize: screenHeight * 0.025, color: AppColor.primaryTextColor2),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: screenHeight * 0.02,
        color: AppColor.secondaryTextColor,
      ),
      onTap: onTap,
    );
  }
}
