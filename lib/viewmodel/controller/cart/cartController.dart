import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fruitbox/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fruitbox/utils/utils.dart';
import 'package:fruitbox/view/checkout/checkout.dart';
import 'package:get/get.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';

class CartController extends GetxController {
  var cartItems = <PersistentShoppingCartItem>[].obs;
  var totalPrice = 0.0.obs;
  var orderID;

  // Function to add items to the cart (if needed)
  void addItem(PersistentShoppingCartItem item, double totalprice) {
    cartItems.add(item);
    totalPrice.value = totalprice;
  }

  // Function to send cart data and address to Firebase
  Future<void> sendCartDataToFirebase(String address) async {
    try {
      var ref = FirebaseFirestore.instance
          .collection('Orders')
          .doc(); // Create a new document
      orderID = ref.id;

      for (var item in cartItems) {
        await ref.collection('Items').add({
          'product_id': item.productId,
          'quantity': item.quantity,
          'title': item.productName,
          'price': item.unitPrice,
          'total_price': item.unitPrice * item.quantity,
          'image': item.productThumbnail,
        });
      }

      await ref.set({
        'address': address,
        'total_price': totalPrice.value,
        'timestamp': FieldValue.serverTimestamp(),
      });

      Utils.toastMessage('Order placed successfully!');
      print('order id ');
      print(orderID.toString());
    } catch (error) {
      Utils.toastMessage('Failed to place order: $error');
      debugPrint(error.toString());
    }
  }
}

// Future<void> sendItemToFirebase(
//     PersistentShoppingCartItem item, double totalprice) async {
//   // Reference to your Firebase collection
//   var ref = FirebaseFirestore.instance.collection('Orders');
//
//   // Send data to Firebase
//   await ref.add({
//     'product_id': item.productId,
//     'quantity': item.quantity,
//     'title': item.productName,
//     'price': item.unitPrice,
//     'total_price': totalprice,
//     'image': item.productThumbnail,
//     // Add other necessary fields
//   }).then((value) {
//     Get.to(() => CheckoutPage());
//     Utils.toastMessage('send data to firebase successfully');
//   }).onError((error, StackTrace) {
//     Utils.toastMessage(error.toString());
//     debugPrint(error.toString());
//   });
// }
