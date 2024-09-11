import 'package:flutter/material.dart';
import 'package:fruitbox/resources/routes/routename.dart';
import 'package:fruitbox/viewmodel/welcome_screen_controller/WelcomeScreenControlller.dart';
import 'package:get/get.dart';

class EmptyCartMsgWidget extends StatelessWidget {
  EmptyCartMsgWidget({super.key});
  final navigationBarController _controller =
      Get.put(navigationBarController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
        child: SizedBox(
      height: size.height * .7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: const Text('Your cart is empty')),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                _controller.changeindex();
              },
              child: const Text('Shop now')),
        ],
      ),
    ));
  }
}
