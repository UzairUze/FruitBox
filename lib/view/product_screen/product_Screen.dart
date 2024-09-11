import 'package:flutter/material.dart';
import 'package:fruitbox/resources/color/app_colors.dart';
import 'package:fruitbox/viewmodel/controller/productpage/productcontroller.dart';
import 'package:get/get.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class ProductDetailPage extends StatelessWidget {
  final image, title, price;
  var product_id;
  ProductDetailPage(
      {super.key,
      required this.image,
      required this.title,
      required this.product_id,
      required this.price});

  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.primaryColor,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Go back button

          // Product Image
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(color: AppColor.primaryColor),
              child: Padding(
                padding: EdgeInsets.only(bottom: screenHeight * .06),
                child: Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(image.toString()),
                    radius: 70,
                  ),
                ),
              ),
            ),
          ),

          // SizedBox(height: screenHeight * 0.03),

          // Product Title and Price
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toString(),
                    style: TextStyle(
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.w400,
                      color: AppColor.primaryTextColor2,
                    ),
                  ),
                  const Divider(
                    color: Colors.grey, // The color of the line
                    thickness:
                        0.2, // The thickness of the line// The right padding of the line
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Quantity Adjuster
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => productController.decrement(),
                            child: Container(
                              padding: EdgeInsets.all(screenWidth * 0.02),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.black54),
                                  color: Colors.grey.shade200),
                              child: Icon(
                                Icons.remove,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          Obx(() => Text(
                                "${productController.quantity.value}",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.06,
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                          SizedBox(width: screenWidth * 0.03),
                          GestureDetector(
                            onTap: () => productController.increment(),
                            child: Container(
                              padding: EdgeInsets.all(screenWidth * 0.02),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: AppColor.primaryColor),
                                color: Colors.grey.shade200,
                              ),
                              child: Icon(
                                Icons.add,
                                color: AppColor.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Price
                      Text(
                        "₦${price.toString()}",
                        style: TextStyle(
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w400,
                          color: AppColor.blackColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  const Divider(
                    color: Colors.grey, // The color of the line
                    thickness:
                        0.5, // The thickness of the line// The right padding of the line
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Product Description
                  // Text(
                  //   "One Pack Contains:",
                  //   style: TextStyle(
                  //     decoration: TextDecoration.underline,
                  //     decorationColor:
                  //         AppColor.primaryColor, // Change underline color
                  //     decorationStyle:
                  //         TextDecorationStyle.solid, // Dashed underline
                  //     decorationThickness: 2.0,
                  //     fontSize: screenWidth * 0.05,
                  //     fontWeight: FontWeight.bold,
                  //     color: AppColor.primaryTextColor2,
                  //   ),
                  // ),
                  RichText(
                    text: TextSpan(
                      text: 'One Pack Contains:',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        height:
                            0.2, // Controls the spacing between the text and the underline
                        decoration: TextDecoration.none, // No default underline
                      ),
                      children: [
                        WidgetSpan(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 0.7,
                                right: screenWidth *
                                    .45), // Add space between text and underline
                            height: 1.0, // Height of the custom underline
                            color:
                                AppColor.primaryColor, // Color of the underline
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    "Red Quinoa, Lime, Honey, Blueberries, Strawberries, Mango, Fresh mint.",
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: AppColor.secondaryTextColor,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    "If you are looking for a new fruit salad to eat today, quinoa is the perfect brunch for you.",
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: AppColor.secondaryTextColor,
                    ),
                  ),
                  Spacer(),

                  // Add to basket button and Favorite icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Favorite Icon
                      GestureDetector(
                        onTap: () {
                          // Add functionality here
                        },
                        child: Container(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.orange),
                            color: Colors.grey.shade200,
                          ),
                          child: Icon(Icons.favorite_outline,
                              color: AppColor.primaryButtonColor),
                        ),
                      ),
                      //Add to Basket Button
                      Align(
                        alignment: Alignment.bottomRight,
                        child: PersistentShoppingCart()
                            .showAndUpdateCartItemWidget(
                          inCartWidget: Container(
                            height: screenHeight * .07,
                            width: screenWidth * .6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColor.primaryColor,
                            ),
                            child: Center(
                              child: Text(
                                'Remove',
                                style: TextStyle(
                                    color: AppColor.whiteColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          notInCartWidget: Container(
                            height: screenHeight * .07,
                            width: screenWidth * .6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColor.primaryColor,
                            ),
                            child: Center(
                              child: Text(
                                'Add to cart',
                                style: TextStyle(
                                    color: AppColor.whiteColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          product: PersistentShoppingCartItem(
                              productId: product_id,
                              productName: title.toString(),
                              unitPrice: double.parse(price.toString()),
                              productThumbnail: image.toString(),
                              quantity: productController.quantity.toInt()),
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
                      // ElevatedButton(
                      //   onPressed: () {
                      //     // Add to basket functionality
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: AppColor.primaryButtonColor,
                      //     padding: EdgeInsets.symmetric(
                      //       horizontal: screenWidth * 0.2,
                      //       vertical: screenHeight * 0.02,
                      //     ),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //   ),
                      //   child: Text(
                      //     "Add to basket",
                      //     style: TextStyle(
                      //       fontSize: screenWidth * 0.05,
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      // ),
                    ],
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
