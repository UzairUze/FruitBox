import 'package:fruitbox/resources/color/app_colors.dart';
import 'package:fruitbox/resources/components/cambo_cart_hot.dart';
import 'package:fruitbox/resources/components/welcomescreencomponent.dart';
import 'package:fruitbox/view/cart/cart.dart';
import 'package:fruitbox/view/profile/profile.dart';
import 'package:fruitbox/view/store/store.dart';
import 'package:fruitbox/view/wishlist/wishlist.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fruitbox/resources/components/RecommendedComboList.dart';

class navigationBarController extends GetxController {
  final RxInt selectedindex = 0.obs;

  void changeindex() {
    selectedindex.value = 0;
  }

  ///here is Screens list that we show on bottom navigation bar
  final screen = [
    welcomeScreenComponent(),
    StoreScreen(
        // imageUrl: 'assets/images/food1.png',
        // title: 'Food one',
        // price: '2000',
        ),
    wishlistScreen(),
    CartView(),
    ProfileScreen(),
  ];
}
