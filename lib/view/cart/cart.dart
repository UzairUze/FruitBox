import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fruitbox/resources/color/app_colors.dart';
import 'package:fruitbox/resources/components/cart/cart_tile_widget.dart';
import 'package:fruitbox/resources/components/cart/empty_cart_msg_widget.dart';
import 'package:fruitbox/resources/routes/routename.dart';
import 'package:fruitbox/view/checkout/checkout.dart';
import 'package:fruitbox/viewmodel/controller/cart/cartController.dart';
import 'package:fruitbox/viewmodel/controller/order/OrderContrioller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final _cartcontroller = Get.put(CartController());
  final _ordercontroller = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('My Cart'),
        // centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Expanded(
                child: PersistentShoppingCart().showCartItems(
                  cartTileWidget: ({required data}) =>
                      CartTileWidget(data: data),
                  showEmptyCartMsgWidget: EmptyCartMsgWidget(),
                ),
              ),
              PersistentShoppingCart().showTotalAmountWidget(
                cartTotalAmountWidgetBuilder: (totalAmount) => Visibility(
                  visible: totalAmount == 0.0 ? false : true,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                                color: AppColor.primaryTextColor2,
                                fontSize: 22),
                          ),
                          Text(
                            r"₦" + totalAmount.toString(),
                            style: const TextStyle(
                                color: AppColor.primaryTextColor2,
                                fontSize: 22),
                          ),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () {
                            final shoppingCart = PersistentShoppingCart();

                            // Retrieve cart data and total price
                            Map<String, dynamic> cartData =
                                shoppingCart.getCartData();

                            // Extract cart items and total price
                            List<PersistentShoppingCartItem> cartItems =
                                cartData['cartItems'];
                            double totalPrice = cartData['totalPrice'];

                            for (var item in cartItems) {
                              _ordercontroller.addItem(item, totalPrice);
                              Get.toNamed(Routename.CheckoutPage);
                              // Get.to(() => CheckoutPage(
                              //       orderId: _cartcontroller.orderID.toString(),
                              //     ));

                              // debugPrint('Item ID: ${item.productId}');
                              // debugPrint('Quantity: ${item.quantity}');
                              // debugPrint('Price: ${item.unitPrice}');
                              // debugPrint('Name: ${item.productName}');
                              // debugPrint('Image: ${item.productThumbnail}');
                              // Print any other details that your PersistentShoppingCartItem contains
                            }

                            /* since cart items is a list, you can run a loop to extract all the values
                                  send it to api or firebase based on your requirement

                             */

                            log('Total Price: $totalPrice');
                          },
                          child: const Text('Checkout'))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
