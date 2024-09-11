import 'package:flutter/cupertino.dart';
import 'package:fruitbox/view/payment/payment.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:fruitbox/viewmodel/controller/cart/cartController.dart';

class CheckoutController extends GetxController {
  var currentAddress = 'Fetching address...'.obs;

  final CartController cartController = Get.find<CartController>();

  void updateAddress(String newAddress) {
    currentAddress.value = newAddress;
  }

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

  void onAddAddressDetails() {
    // Navigate to the address details screen or perform action
  }

  void onConfirmAddress() {
    // Save the address and cart data to Firebase
    cartController.sendCartDataToFirebase(currentAddress.value);
  }
}
