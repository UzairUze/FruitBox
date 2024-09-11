import 'package:flutter/material.dart';
import 'package:fruitbox/resources/components/round_button.dart';
import 'package:fruitbox/resources/routes/routename.dart';
import 'package:fruitbox/viewmodel/controller/order/OrderContrioller.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatefulWidget {
  final String? orderID;

  PaymentScreen({super.key, this.orderID});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final OrderController _orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final isWideScreen = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Column(
        children: [
          // First Expanded Widget
          Expanded(
            flex: 2,
            child: Obx(() {
              if (_orderController.cartItems.isEmpty) {
                return Center(child: Text('No items in your order.'));
              }

              return ListView.builder(
                itemCount: _orderController.cartItems.length,
                itemBuilder: (context, index) {
                  var item = _orderController.cartItems[index];

                  return Card(
                    margin: EdgeInsets.symmetric(
                      vertical: mediaQuery.size.height * 0.008,
                      horizontal: mediaQuery.size.width * 0.03,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(isWideScreen ? 24.0 : 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.productName ?? 'Product Name',
                            style: TextStyle(
                              fontSize: isWideScreen ? 22 : 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: mediaQuery.size.height * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Price:',
                                style: TextStyle(
                                  fontSize: isWideScreen ? 18 : 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                item.unitPrice.toString() ?? '',
                                style: TextStyle(
                                  fontSize: isWideScreen ? 18 : 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: mediaQuery.size.height * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Quantity:',
                                style: TextStyle(
                                  fontSize: isWideScreen ? 18 : 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                item.quantity.toString() ?? ' ',
                                style: TextStyle(
                                  fontSize: isWideScreen ? 18 : 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: mediaQuery.size.height * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Price:',
                                style: TextStyle(
                                  fontSize: isWideScreen ? 18 : 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                item.totalPrice.toString() ?? '',
                                style: TextStyle(
                                  fontSize: isWideScreen ? 18 : 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Expanded(
              flex: 1,
              child: Card(
                margin: EdgeInsets.symmetric(
                  vertical: mediaQuery.size.height * 0.02,
                  horizontal: mediaQuery.size.width * 0.04,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(isWideScreen ? 24.0 : 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Amount:',
                        style: TextStyle(
                          fontSize: isWideScreen ? 22 : 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        _orderController.totalPrice.toString() ?? '',
                        style: TextStyle(
                          fontSize: isWideScreen ? 22 : 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          // Second Expanded Widget containing the Form
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Card Holder's Name
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Card Holder’s Name',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          _orderController.cardHolderName.value = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the card holder\'s name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.02),

                      // Card Number
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Card Number',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          _orderController.cardNumber.value = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the card number';
                          }
                          if (value.length != 16) {
                            return 'Card number must be 16 digits';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.02),

                      // Expiry Date and CCV
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Date',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.datetime,
                              onChanged: (value) {
                                _orderController.expiryDate.value = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the expiry date';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: width * 0.02),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'CCV',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                _orderController.ccv.value = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the CCV';
                                }
                                if (value.length != 3) {
                                  return 'CCV must be 3 digits';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.04),

                      // Complete Order Button
                      Center(
                        child: RoundButton(
                          borderRadius: 25,
                          width: width * .7,
                          title: 'Complete Order',
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              // Call the complete order function in the controller
                              _orderController.completeOrder();
                              Get.toNamed(Routename.CongratulationsScreen);
                              Get.snackbar(
                                  'Payment', 'Processing your payment...');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
