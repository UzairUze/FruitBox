import 'package:flutter/material.dart';
import 'package:fruitbox/resources/color/app_colors.dart';
import 'package:fruitbox/viewmodel/controller/wishlist/wishlistcontroller.dart';
import 'package:get/get.dart';

class wishlistScreen extends StatefulWidget {
  const wishlistScreen({super.key});

  @override
  State<wishlistScreen> createState() => _wishlistScreenState();
}

class _wishlistScreenState extends State<wishlistScreen> {
  final wishlistController = Get.put(WishlistController());

  @override
  void initState() {
    // TODO: implement initState
    wishlistController.wishlistItems.refresh();
    setState(() {
      wishlistController.wishlistItems.refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final widthScale = width / 375.0; // Base width 375.0
    final heightScale = height / 812.0; // Base height 812.0

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Wishlist',
          style: TextStyle(fontSize: 24 * widthScale),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (wishlistController.wishlistItems.isEmpty) {
          // Empty Wishlist UI
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/empty_wishlist.png',
                  width: width * 0.7,
                  height: height * 0.3,
                ),
                SizedBox(height: 10 * heightScale),
                Text(
                  "My Wishlist is Empty!",
                  style: TextStyle(
                    fontSize: 24 * widthScale,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10 * heightScale),
                Text(
                  "Tap heart button to start saving your favorite items.",
                  style: TextStyle(
                    fontSize: 16 * widthScale,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20 * heightScale),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to explore or shop page
                  },
                  child: Text(
                    "Explore",
                    style: TextStyle(fontSize: 18 * widthScale),
                  ),
                ),
              ],
            ),
          );
        } else {
          // Wishlist with items
          return ListView.builder(
            itemCount: wishlistController.wishlistItems.length,
            itemBuilder: (context, index) {
              final item = wishlistController.wishlistItems[index];

              return Dismissible(
                key: Key(index.toString()), // Ensure each item has a unique key
                direction:
                    DismissDirection.endToStart, // Swipe from right to left
                background: Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  alignment: AlignmentDirectional.centerEnd,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (direction) {
                  // Call a function on left slide
                  wishlistController.removeFromWishlist(item['product_id']);
                  debugPrint("price: ${item['product_id']}");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${item['title']} removed from wishlist"),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 5.0 * heightScale,
                      horizontal: 5.0 * widthScale),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 5.0 * heightScale,
                          horizontal: 10.0 * widthScale),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 3,
                            child: Image.network(
                              item['image'],
                              width: width * 0.3,
                              height: height * 0.1,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(width: 12 * widthScale),
                          Expanded(
                            flex: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title'],
                                  style: TextStyle(
                                      fontSize: 15 * widthScale,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.primaryTextColor2),
                                ),
                                SizedBox(height: 3 * heightScale),
                                Text(
                                  "Review (⭐ 4.9)",
                                  style: TextStyle(
                                    fontSize: 14 * widthScale,
                                    color: AppColor.secondaryTextColor,
                                  ),
                                ),
                                SizedBox(height: 10 * heightScale),
                                Text(
                                  "price: ${item['price']}",
                                  style: TextStyle(
                                      fontSize: 16 * widthScale,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.primaryTextColor2),
                                ),
                              ],
                            ),
                          ),
                          //Spacer(),
                          Flexible(
                            flex: 4,
                            child: ElevatedButton(
                              onPressed: () {
                                wishlistController
                                    .removeFromWishlist(item['product_id']);
                                debugPrint("price: ${item['product_id']}");
                              },
                              child: Text(
                                "Add to Bag",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12 * widthScale),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.primaryButtonColor,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10 * heightScale,
                                    horizontal: 15 * widthScale),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
