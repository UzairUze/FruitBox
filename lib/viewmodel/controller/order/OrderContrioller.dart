import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fruitbox/view/payment/payment.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:fruitbox/utils/utils.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class OrderController extends GetxController {
  final PersistentShoppingCart _shoppingCart = PersistentShoppingCart();

  // Cart related variables
  var cartItems = <PersistentShoppingCartItem>[].obs;
  var totalPrice = 0.0.obs;
  var currentAddress = 'Fetching address...'.obs;

  // Payment related variables
  var cardHolderName = ''.obs;
  var cardNumber = ''.obs;
  var expiryDate = ''.obs;
  var ccv = ''.obs;

  // Function to add items to the cart (if needed)
  void addItem(PersistentShoppingCartItem item, double totalprice) {
    cartItems.add(item);
    totalPrice.value = totalprice;
  }

  // Function to update address
  void updateAddress(String newAddress) {
    currentAddress.value = newAddress;
  }

  // Function to fetch address based on coordinates
  Future<void> fetchAndUpdateAddress(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      String address = '${place.street}, ${place.locality}';
      updateAddress(address);
    } catch (e) {
      updateAddress('Unable to fetch address');
      debugPrint(e.toString());
    }
  }

  // Function to complete the order and save data to Firebase
  Future<void> completeOrder() async {
    try {
      // Create a new order document with an auto-generated ID
      var orderRef = FirebaseFirestore.instance.collection('Orders').doc();
      final orderId = orderRef.id;
      final timestamp = FieldValue.serverTimestamp();

      // Save cart items
      for (var item in cartItems) {
        await orderRef.collection('Items').add({
          'product_id': item.productId,
          'quantity': item.quantity,
          'title': item.productName,
          'price': item.unitPrice,
          'total_price': item.unitPrice * item.quantity,
          'image': item.productThumbnail,
        });
      }

      // Save order details
      await orderRef.set({
        'address': currentAddress.value,
        'total_price': totalPrice.value,
        'timestamp': timestamp,
      });

      // Notify user of success
      Utils.toastMessage('Order placed successfully!');
      print('Order ID: $orderId');

      // Clear cart after order completion if needed
      cartItems.clear();
      totalPrice.value = 0.0;
      _shoppingCart.clearCart();

      // Navigate to the payment screen or perform any additional actions
      // Get.to(() => PaymentScreen(orderId: orderId));
    } catch (error) {
      // Handle errors
      Utils.toastMessage('Failed to place order: $error');
      debugPrint(error.toString());
    }
  }
}
