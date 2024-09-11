import 'package:flutter/material.dart';
import 'package:fruitbox/resources/color/app_colors.dart';
import 'package:fruitbox/resources/components/round_button.dart';
import 'package:fruitbox/resources/routes/routename.dart';
import 'package:fruitbox/utils/constants.dart';
import 'package:fruitbox/utils/utils.dart';
import 'package:fruitbox/view/auth/verfiy_number.dart';
import 'package:fruitbox/viewmodel/controller/auth/auth_view_model.dart';
import 'package:get/get.dart';

class SignUpWithNumberScreen extends StatefulWidget {
  const SignUpWithNumberScreen({super.key});

  @override
  State<SignUpWithNumberScreen> createState() => _SignUpWithNumberScreenState();
}

class _SignUpWithNumberScreenState extends State<SignUpWithNumberScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _authViewModel = Get.put(authViewModel());

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _authViewModel.phoneController.value.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Create an Account',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryTextColor),
            ),
            const SizedBox(height: 10),
            const Text(
              'Sign up with your phone number',
              style:
                  TextStyle(fontSize: 16, color: AppColor.secondaryTextColor),
            ),
            const SizedBox(height: 40),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    /// Phone Number TextField
                    TextFormField(
                      controller: _authViewModel.phoneController.value,
                      // focusNode: _authViewModel.phoneFocusNode.value,
                      keyboardType: TextInputType.phone,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Phone Number';
                        } else if (RegExp(r"^\+92[0-9]{11}$").hasMatch(value)) {
                          return 'Please Enter a Valid Phone Number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: '+92123456789',
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: AppColor.primaryColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color:
                                AppColor.primaryColor, // Set border color here
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColor.blackColor, // Set border color here
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    //    const SizedBox(height: 20),

                    /// OTP TextField
                    // TextFormField(
                    //   controller: _authViewModel.verifyCodeController.value,
                    //   //  focusNode: _authViewModel.otpFocusNode.value,
                    //   keyboardType: TextInputType.number,
                    //   autovalidateMode: AutovalidateMode.onUserInteraction,
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return 'Please Enter OTP';
                    //     }
                    //     return null;
                    //   },
                    //   decoration: InputDecoration(
                    //     hintText: 'Enter OTP',
                    //     prefixIcon: const Icon(
                    //       Icons.security,
                    //       color: AppColor.primaryColor,
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide: const BorderSide(
                    //         color:
                    //             AppColor.primaryColor, // Set border color here
                    //         width: 1.0,
                    //       ),
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: const BorderSide(
                    //         color: AppColor.blackColor, // Set border color here
                    //         width: 1.0,
                    //       ),
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //   ),
                    // ),
                  ],
                )),
            const SizedBox(height: 30),
            Obx(
              () => RoundButton(
                loading: _authViewModel.loading.value,
                title: 'Send code',
                Fontsize: 20,
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    _authViewModel.signwithNumber();
                  }
                },
                width: 285,
                height: 50,
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Get.toNamed(
                    Routename.loginScreen); // Navigate back to the login screen
              },
              child: RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: TextStyle(color: AppColor.secondaryTextColor),
                  children: [
                    TextSpan(
                      text: 'Login',
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
