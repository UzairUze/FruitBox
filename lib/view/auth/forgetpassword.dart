import 'package:flutter/material.dart';
import 'package:fruitbox/resources/color/app_colors.dart';
import 'package:fruitbox/resources/components/round_button.dart';
import 'package:fruitbox/utils/constants.dart';
import 'package:fruitbox/utils/utils.dart';
import 'package:fruitbox/viewmodel/controller/auth/auth_view_model.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _authViewModel = Get.put(authViewModel());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final widthScale =
        screenWidth / 375; // Assuming design is based on 375px width
    final heightScale =
        screenHeight / 812; // Assuming design is based on 812px height

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(20 * widthScale),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Reset Password',
              style: TextStyle(
                fontSize: 30 * widthScale,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryTextColor,
              ),
            ),
            SizedBox(height: 20 * heightScale),
            Text(
              'Enter your email to reset your password',
              style: TextStyle(
                fontSize: 16 * widthScale,
                color: AppColor.secondaryTextColor,
              ),
            ),
            SizedBox(height: 40 * heightScale),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _authViewModel.forgetController.value,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Email',
                  prefixIcon: const Icon(
                    Icons.email,
                    color: AppColor.primaryColor,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColor.primaryColor,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColor.blackColor,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40 * heightScale),
            Obx(
              () => RoundButton(
                loading: _authViewModel.loading.value,
                title: 'Reset Password',
                Fontsize: 20 * widthScale,
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    _authViewModel.forgetPassword();
                  }
                },
                width: 285 * widthScale,
                height: 50 * heightScale,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
