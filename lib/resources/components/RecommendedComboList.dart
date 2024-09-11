import 'package:flutter/material.dart';
import 'package:fruitbox/resources/color/app_colors.dart';
import 'package:fruitbox/resources/components/combo_card.dart';
import 'package:fruitbox/view/product_screen/product_Screen.dart';
import 'package:fruitbox/viewmodel/controller/recommendedcombo/recommendedComboController.dart';
import 'package:fruitbox/viewmodel/controller/store/storeController.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

///here is Recommended Combo List we us combo Card widget and pass into listview builder
class RecommendedComboList extends StatefulWidget {
  const RecommendedComboList({super.key});

  @override
  State<RecommendedComboList> createState() => _RecommendedComboListState();
}

class _RecommendedComboListState extends State<RecommendedComboList> {
  final _RCController = Get.put(RecommendedComboController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      child: Obx(() => _RCController.items.isEmpty
          ? Center(
              child: Container(
                width: width * .4,
                child: Center(
                    child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                )),
              ),
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _RCController.items.length,
              itemBuilder: (context, index) {
                final item = _RCController.items[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * .008, vertical: height * .002),
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
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(item['image']!),
                                radius: 40,
                                backgroundColor: Colors.transparent,
                              ),
                              SizedBox(height: 10),
                              Text(
                                item['title']!,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item['price']!,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColor.primaryTextColor),
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
                                            productId: item['product_id']!,
                                            productName:
                                                item['title']!.toString(),
                                            unitPrice: double.parse(
                                                item['price']!.toString()),
                                            productThumbnail:
                                                item['image']!.toString(),
                                            quantity: 1),
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
                              _RCController.toggleFavorite(index);
                            });
                          },
                          child: Icon(
                              item['isFavorite'] == true
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: AppColor.primaryTextColor),
                        ),
                      ),
                    ],
                  ),
                );
              })),
    );
  }
}
