import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fruitbox/resources/color/app_colors.dart';
import 'package:fruitbox/resources/components/combo_card.dart';
import 'package:fruitbox/view/product_screen/product_Screen.dart';
import 'package:fruitbox/viewmodel/controller/TabController.dart';
import 'package:get/get.dart';
import 'package:fruitbox/viewmodel/controller/TabController.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class comboCardHot extends StatefulWidget {
  const comboCardHot({super.key});

  @override
  State<comboCardHot> createState() => _comboCardHotState();
}

class _comboCardHotState extends State<comboCardHot> {
  bool isFavorite = false;
  final TabcontrollerT tabController = Get.put(TabcontrollerT());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tab Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(tabController.tabs.length, (index) {
                return InkWell(
                  onTap: () {
                    tabController.changeTab(index);
                  },
                  child: Column(
                    children: [
                      Text(
                        tabController.tabs[index],
                        style: TextStyle(
                          fontSize: tabController.selectedTab.value == index
                              ? 18
                              : 16,
                          fontWeight: tabController.selectedTab.value == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: tabController.selectedTab.value == index
                              ? AppColor.primaryTextColor
                              : AppColor.primaryTextColor2,
                        ),
                      ),
                      if (tabController.selectedTab.value == index)
                        Container(
                          height: 2,
                          width: 30,
                          color: AppColor.primaryTextColor,
                        ),
                    ],
                  ),
                );
              }),
            ),
            SizedBox(
              height: 10,
            ),
            // Item Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: tabController.items.length,
                itemBuilder: (context, index) {
                  final item = tabController.items[index];
                  final imageUrl =
                      item['image'] ?? ''; // Default to empty string if null
                  final title = item['title'] ??
                      'Unknown'; // Default to 'Unknown' if null
                  final price = item['price'] ?? '0'; // Default to '0' if null
                  final productId =
                      item['product_id'] ?? '0'; // Default to '0' if null

                  return Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(() => ProductDetailPage(
                                image: imageUrl,
                                title: title,
                                price: double.tryParse(price) ?? 0.0,
                                product_id: productId,
                              ));
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(imageUrl),
                                radius: 40,
                                backgroundColor: Colors.transparent,
                              ),
                              SizedBox(height: 10),
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.primaryTextColor2,
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      price,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.orange,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: PersistentShoppingCart()
                                          .showAndUpdateCartItemWidget(
                                        inCartWidget: Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.remove,
                                            color: AppColor.primaryTextColor,
                                            size: 25,
                                          ),
                                        ),
                                        notInCartWidget: Container(
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
                                        product: PersistentShoppingCartItem(
                                          productId: productId,
                                          productName: title,
                                          unitPrice:
                                              double.tryParse(price) ?? 0.0,
                                          productThumbnail: imageUrl,
                                          quantity: 1,
                                        ),
                                      ),
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
                              tabController.toggleFavorite(index);
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
