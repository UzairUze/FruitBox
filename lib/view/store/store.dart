import 'package:flutter/material.dart';
import 'package:fruitbox/resources/color/app_colors.dart';
import 'package:fruitbox/utils/utils.dart';
import 'package:fruitbox/view/product_screen/product_Screen.dart';
import 'package:fruitbox/viewmodel/controller/TabController.dart';
import 'package:fruitbox/viewmodel/controller/auth/auth_view_model.dart';
import 'package:fruitbox/viewmodel/controller/store/storeController.dart';
import 'package:get/get.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

final _storeController = Get.put(storeController());

///store Screen
class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  // final String imageUrl;
  // final String title;
  // final String price;
  //
  // StoreScreen({
  //   required this.imageUrl,
  //   required this.title,
  //   required this.price,
  // });

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  bool isFavorite = false;
  final _storeController = Get.put(storeController());
  final _auth = Get.put(authViewModel());
  Future<void> _refreshItems() async {
    // Simulate a network request or data refresh
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      // Update the items or perform any necessary actions
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final widthScale = width / 375.0; // Base width 375.0 (example)
    final heightScale = height / 812.0; // Base height 812.0 (example)
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshItems,
        child: Padding(
          padding: EdgeInsets.all(16.0 * widthScale),
          child: Column(
            children: [
              /// Showing user name and profile.
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
                          color: AppColor
                              .primaryTextColor2, // Replace with AppColor.primaryTextColor2
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage('assets/images/profile.png'),
                    ),
                  ],
                ),
              ),
              // Add space between the header and the lists
              /// ListView section
              Expanded(
                child: Row(
                  children: <Widget>[
                    Obx(
                      () => Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: _storeController.items.length,
                          itemBuilder: (context, index) {
                            final item = _storeController.items[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => ProductDetailPage(
                                            image: item['image']!,
                                            title: item['title']!,
                                            price: item['price']!,
                                            product_id: item['product_id']!,
                                          ));
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            blurRadius: 10,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize
                                            .min, // Ensure the column takes minimum space
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(item['image']!),
                                            radius: 60,
                                            backgroundColor: Colors.transparent,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            item['title']!,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          // SizedBox(height: 5),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  item['price']!,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: AppColor
                                                          .primaryTextColor),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: PersistentShoppingCart()
                                                      .showAndUpdateCartItemWidget(
                                                    inCartWidget: Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade100,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: AppColor
                                                            .primaryTextColor,
                                                        size: 25,
                                                      ),
                                                    ),
                                                    notInCartWidget: Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade100,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Icon(
                                                        Icons.add,
                                                        color: AppColor
                                                            .primaryTextColor,
                                                        size: 25,
                                                      ),
                                                    ),
                                                    product:
                                                        PersistentShoppingCartItem(
                                                            productId: item[
                                                                'product_id']!,
                                                            productName: item[
                                                                    'title']!
                                                                .toString(),
                                                            unitPrice: double
                                                                .parse(item[
                                                                        'price']!
                                                                    .toString()),
                                                            productThumbnail:
                                                                item['image']!
                                                                    .toString(),
                                                            quantity: 1),
                                                  ),
                                                  // child: InkWell(
                                                  //   onTap: () {},
                                                  //   child: Container(
                                                  //     padding: EdgeInsets.all(4),
                                                  //     decoration: BoxDecoration(
                                                  //       color:
                                                  //           Colors.grey.shade100,
                                                  //       shape: BoxShape.circle,
                                                  //     ),
                                                  //     child: Icon(
                                                  //       Icons.add,
                                                  //       color: AppColor
                                                  //           .primaryTextColor,
                                                  //       size: 25,
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          debugPrint('hello');
                                          _storeController
                                              .toggleFavorite(index);
                                        });
                                      },
                                      child: Icon(
                                        item['isFavorite'] == true
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: AppColor.primaryTextColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 20), // Add space between the two lists
                    Obx(
                      () => Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: _storeController.items.length,
                          itemBuilder: (context, index) {
                            final item = _storeController.items[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => ProductDetailPage(
                                            image: item['image']!,
                                            title: item['title']!,
                                            price: item['price']!,
                                            product_id: item['product_id']!,
                                          ));
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            blurRadius: 10,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize
                                            .min, // Ensure the column takes minimum space
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(item['image']!),
                                            radius: 60,
                                            backgroundColor: Colors.transparent,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            item['title']!,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          // SizedBox(height: 5),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  item['price']!,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: AppColor
                                                          .primaryTextColor),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: PersistentShoppingCart()
                                                      .showAndUpdateCartItemWidget(
                                                    inCartWidget: Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade100,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: AppColor
                                                            .primaryTextColor,
                                                        size: 25,
                                                      ),
                                                    ),
                                                    notInCartWidget: Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade100,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Icon(
                                                        Icons.add,
                                                        color: AppColor
                                                            .primaryTextColor,
                                                        size: 25,
                                                      ),
                                                    ),
                                                    product:
                                                        PersistentShoppingCartItem(
                                                            productId: item[
                                                                'product_id']!,
                                                            productName: item[
                                                                    'title']!
                                                                .toString(),
                                                            unitPrice: double
                                                                .parse(item[
                                                                        'price']!
                                                                    .toString()),
                                                            productThumbnail:
                                                                item['image']!
                                                                    .toString(),
                                                            quantity: 1),
                                                  ),
                                                  // child: InkWell(
                                                  //   onTap: () {},
                                                  //   child: Container(
                                                  //     padding: EdgeInsets.all(4),
                                                  //     decoration: BoxDecoration(
                                                  //       color:
                                                  //           Colors.grey.shade100,
                                                  //       shape: BoxShape.circle,
                                                  //     ),
                                                  //     child: Icon(
                                                  //       Icons.add,
                                                  //       color: AppColor
                                                  //           .primaryTextColor,
                                                  //       size: 25,
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          debugPrint('hello');
                                          _storeController
                                              .toggleFavorite(index);
                                        });
                                      },
                                      child: Icon(
                                        item['isFavorite'] == true
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: AppColor.primaryTextColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: Padding(
                    //     padding: EdgeInsets.only(top: height * .1),
                    //     child: ListView.builder(
                    //       itemCount: 5,
                    //       itemBuilder: (context, index) {
                    //         return listone(
                    //           imageUrl: 'assets/images/food1.png',
                    //           title: 'Food One',
                    //           price: '2000',
                    //           isFavorite: true,
                    //         );
                    //       },
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class listone extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String price;
  final bool isFavorite;

  listone(
      {required this.imageUrl,
      required this.title,
      required this.price,
      required this.isFavorite});

  @override
  State<listone> createState() => _listoneState();
}

class _listoneState extends State<listone> {
  final TabcontrollerT tabController = Get.put(TabcontrollerT());
//  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Ensure the column takes minimum space
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(widget.imageUrl),
                  radius: 60,
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(height: 10),
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                // SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.price,
                        style: TextStyle(
                            fontSize: 16, color: AppColor.primaryTextColor),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            // Handle add to cart logic
                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.add,
                              color: AppColor.primaryTextColor,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  /// tabController.toggleFavorite(index);
                });
              },
              child: Icon(
                widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: AppColor.primaryTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class listTwo extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String price;

  listTwo({
    required this.imageUrl,
    required this.title,
    required this.price,
  });

  @override
  State<listTwo> createState() => _listTwoState();
}

class _listTwoState extends State<listTwo> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Ensure the column takes minimum space
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(widget.imageUrl),
                  radius: 60,
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(height: 10),
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                // SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.price,
                        style: TextStyle(
                            fontSize: 16, color: AppColor.primaryTextColor),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            // Handle add to cart logic
                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.add,
                              color: AppColor.primaryTextColor,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: AppColor.primaryTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
