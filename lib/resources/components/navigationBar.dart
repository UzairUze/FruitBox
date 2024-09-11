// import 'package:flutter/material.dart';
// import 'package:fruitbox/resources/color/app_colors.dart';
// import 'package:fruitbox/resources/components/cambo_cart_hot.dart';
// import 'package:fruitbox/resources/components/combo_card.dart';
// import 'package:fruitbox/viewmodel/welcome_screen_controller/WelcomeScreenControlller.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
//
// class Navigationbar extends StatelessWidget {
//   Navigationbar({super.key});
//   final controller = Get.put(navigationBarController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           icon: const Icon(Icons.menu, color: Colors.black),
//           onPressed: () {
//             Get.to(() => Navigationbar());
//           },
//         ),
//         actions: [
//           IconButton(
//             ///Svg picture use for svg picture showing in app
//             icon: Image.asset(
//               'assets/images/cart.png',
//               scale: 18.0,
//             ),
//             onPressed: () {
//               //Get.to(() => HomeScreen());
//             },
//           ),
//           SizedBox(
//             width: 10,
//           )
//         ],
//       ),
//       body: Obx(() => controller.screen[controller.selectedindex.value]),
//       bottomNavigationBar: Obx(
//         () => NavigationBar(
//           elevation: 0,
//           selectedIndex: controller.selectedindex.value,
//           onDestinationSelected: (index) =>
//               controller.selectedindex.value = index,
//           destinations: const [
//             NavigationDestination(
//               icon: Icon(Iconsax.home),
//               label: 'Home',
//             ),
//             NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
//             NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
//             NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
//           ],
//         ),
//       ),
//     );
//   }
// }
