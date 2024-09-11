import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruitbox/resources/color/app_colors.dart';
import 'package:fruitbox/resources/components/RecommendedComboList.dart';
import 'package:fruitbox/resources/components/combo_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruitbox/resources/components/cambo_cart_hot.dart';
import 'package:fruitbox/resources/components/navigationBar.dart';
import 'package:fruitbox/view/profile/profile.dart';
import 'package:fruitbox/view/store/store.dart';
import 'package:fruitbox/viewmodel/controller/auth/auth_view_model.dart';
import 'package:fruitbox/viewmodel/welcome_screen_controller/WelcomeScreenControlller.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final controller = Get.put(navigationBarController());

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.changeindex(); // Switch to the desired tab
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // Scale factor for width and height
    final widthScale = width / 375.0; // Base width 375.0 (example)
    final heightScale = height / 812.0; // Base height 812.0 (example)
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        // appBar: AppBar(
        //   elevation: 0,
        //   automaticallyImplyLeading: false,
        //   title: Text(
        //     'Hello Kante',
        //     style: TextStyle(
        //       fontSize: 24 * widthScale,
        //       fontWeight: FontWeight.bold,
        //       color: AppColor.primaryTextColor2,
        //     ),
        //   ),
        //   titleSpacing: 15.0,
        //   actions: [
        //     CircleAvatar(
        //       radius: 24,
        //       backgroundImage: AssetImage('assets/images/profile.png'),
        //     ),
        //     // IconButton(
        //     //   ///Svg picture use for svg picture showing in app
        //     //   icon: Image.asset(
        //     //     'assets/images/profile.png',
        //     //     scale: 5.0,
        //     //   ),
        //     //   onPressed: () {
        //     //     //Get.to(() => HomeScreen());
        //     //   },
        //     // ),
        //     SizedBox(
        //       width: 10,
        //     )
        //   ],
        // ),
        body: Obx(() => controller.screen[controller.selectedindex.value]),
        bottomNavigationBar: Obx(
          () => NavigationBar(
            animationDuration: Duration(seconds: 1),
            backgroundColor: Colors.white,
            indicatorColor: AppColor.primaryTextColor,
            elevation: 0,
            selectedIndex: controller.selectedindex.value,
            onDestinationSelected: (index) =>
                controller.selectedindex.value = index,
            destinations: [
              NavigationDestination(
                icon: Icon(
                  Iconsax.home,
                  color: controller.selectedindex.value == 0
                      ? AppColor.whiteColor
                      : AppColor.primaryTextColor2,
                ),
                label: 'Home',
                tooltip: 'Home',
              ),
              NavigationDestination(
                  icon: Icon(
                    Iconsax.shop,
                    color: controller.selectedindex.value == 1
                        ? AppColor.whiteColor
                        : AppColor.primaryTextColor2,
                  ),
                  label: 'Store'),
              NavigationDestination(
                  icon: Icon(
                    Iconsax.heart,
                    color: controller.selectedindex.value == 2
                        ? AppColor.whiteColor
                        : AppColor.primaryTextColor2,
                  ),
                  label: 'Wishlist'),
              NavigationDestination(
                  icon: PersistentShoppingCart().showCartItemCountWidget(
                    cartItemCountWidgetBuilder: (itemCount) => Badge(
                      label: Text(itemCount.toString()),
                      backgroundColor: controller.selectedindex.value == 3
                          ? AppColor.whiteColor
                          : AppColor.primaryColor,
                      textColor: controller.selectedindex.value == 3
                          ? AppColor.primaryTextColor2
                          : AppColor.whiteColor,
                      child: Icon(
                        Iconsax.shopping_cart,
                        color: controller.selectedindex.value == 3
                            ? AppColor.whiteColor
                            : AppColor.primaryTextColor2,
                      ),
                    ),
                  ),
                  label: 'Cart'),
              NavigationDestination(
                  icon: Icon(
                    Iconsax.user,
                    color: controller.selectedindex.value == 4
                        ? AppColor.whiteColor
                        : AppColor.primaryTextColor2,
                  ),
                  label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
