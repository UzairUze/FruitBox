import 'package:flutter/material.dart';
import 'package:fruitbox/resources/color/app_colors.dart';
import 'package:fruitbox/resources/components/round_button.dart';
import 'package:fruitbox/utils/utils.dart';
import 'package:fruitbox/viewmodel/controller/auth/auth_view_model.dart';
import 'package:get/get.dart';

class VerifyCodeScreen extends StatefulWidget {
  final verificationId;
  const VerifyCodeScreen({super.key, this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _authViewModel = Get.put(authViewModel());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Verify Code',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryTextColor),
            ),
            const SizedBox(height: 10),
            const Text(
              'Enter the OTP sent to your phone',
              style:
                  TextStyle(fontSize: 16, color: AppColor.secondaryTextColor),
            ),
            const SizedBox(height: 40),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    /// OTP TextField
                    TextFormField(
                      controller: _authViewModel.verifyCodeController.value,
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter OTP';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter OTP',
                        prefixIcon: const Icon(
                          Icons.security,
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
                  ],
                )),
            const SizedBox(height: 30),
            Obx(
              () => RoundButton(
                loading: _authViewModel.loading.value,
                title: 'Verify Code',
                Fontsize: 20,
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    _authViewModel.verifyCode(widget.verificationId);
                  }
                },
                width: screenWidth * 0.8,
                height: 50,
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: RichText(
                text: TextSpan(
                  text: 'Didn\'t receive a code? ',
                  style: TextStyle(color: AppColor.secondaryTextColor),
                  children: [
                    TextSpan(
                      text: 'Resend',
                      style: TextStyle(
                        color: AppColor.primaryTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
