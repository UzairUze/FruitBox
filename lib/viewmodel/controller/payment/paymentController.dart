import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  var cardHolderName = ''.obs;
  var cardNumber = ''.obs;
  var expiryDate = ''.obs;
  var ccv = ''.obs;

  void completeOrder() {
    // Implement your payment processing logic here
    // You can access the card details using the respective variables
    print('Completing order with:');
    print('Name: ${cardHolderName.value}');
    print('Card Number: ${cardNumber.value}');
    print('Expiry Date: ${expiryDate.value}');
    print('CCV: ${ccv.value}');
  }

  var cartItems = <Map<String, dynamic>>[].obs; // Observable list of cart items

  Future<void> fetchOrderItems(String orderId) async {
    try {
      var ref = FirebaseFirestore.instance
          .collection('Orders')
          .doc(orderId)
          .collection('Items');

      var snapshot = await ref.get();

      cartItems.clear();
      for (var doc in snapshot.docs) {
        cartItems.add(doc.data());
      }
    } catch (e) {
      // Handle errors if necessary
    }
  }
}
//
// Center(
// child: RoundButton(
// title: 'Complete Order',
// width: width * .7,
// borderRadius: 25,
// onPress: () {
// if (_formKey.currentState!.validate()) {
// // Process the payment
// Get.snackbar(
// 'Payment', 'Processing your payment...');
// }
// },
// ),
// ),
