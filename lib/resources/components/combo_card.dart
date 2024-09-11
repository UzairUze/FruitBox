// import 'package:flutter/material.dart';
// import 'package:fruitbox/resources/color/app_colors.dart';
// import 'package:fruitbox/viewmodel/controller/TabController.dart';
// import 'package:fruitbox/viewmodel/controller/store/storeController.dart';
// import 'package:fruitbox/viewmodel/controller/wishlist/wishlistcontroller.dart';
// import 'package:get/get.dart';
//
// ///here is Recommended combo Card widget
//
// class RecommendedComboCard extends StatefulWidget {
//   final String imageUrl;
//   final String title;
//   final String price;
//
//   RecommendedComboCard({
//     required this.imageUrl,
//     required this.title,
//     required this.price,
//   });
//
//   @override
//   _RecommendedComboCardState createState() => _RecommendedComboCardState();
// }
//
// class _RecommendedComboCardState extends State<RecommendedComboCard> {
//   final _wishlistController = Get.put(WishlistController());
//   final _storeController = Get.put(storeController());
//
//   bool isFavorite = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     return Padding(
//       padding: EdgeInsets.symmetric(
//           horizontal: width * .008, vertical: height * .002),
//       child: Stack(
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.width * 0.45,
//             padding: EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   blurRadius: 10,
//                   offset: Offset(0, 5),
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisSize:
//                   MainAxisSize.min, // Ensure the column takes minimum space
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CircleAvatar(
//                   backgroundImage: AssetImage(widget.imageUrl),
//                   radius: 40,
//                   backgroundColor: Colors.transparent,
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   widget.title,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 5),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         widget.price,
//                         style: TextStyle(
//                             fontSize: 16, color: AppColor.primaryTextColor),
//                       ),
//                       Align(
//                         alignment: Alignment.bottomRight,
//                         child: InkWell(
//                           onTap: () {
//                             // Handle add to cart logic
//                           },
//                           child: Container(
//                             padding: EdgeInsets.all(4),
//                             decoration: BoxDecoration(
//                               color: Colors.grey.shade100,
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(
//                               Icons.add,
//                               color: AppColor.primaryTextColor,
//                               size: 25,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Obx(
//             () => Positioned(
//               top: 8,
//               right: 8,
//               child: GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     debugPrint('hello');
//                     //  _storeController.toggleFavorite(index);
//                   });
//                 },
//                 child: Icon(
//                     // item['isFavorite'] == true
//                     //     ? Icons.favorite
//                     Icons.favorite_border,
//                     color: AppColor.primaryTextColor),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
