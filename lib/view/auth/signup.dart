import 'package:flutter/material.dart';
import 'package:fruitbox/resources/color/app_colors.dart';
import 'package:fruitbox/resources/components/round_button.dart';
import 'package:fruitbox/resources/routes/routename.dart';
import 'package:fruitbox/utils/constants.dart';
import 'package:fruitbox/utils/utils.dart';
import 'package:fruitbox/viewmodel/controller/auth/auth_view_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _authViewModel = Get.put(authViewModel());

  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
              'Create Account',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryTextColor),
            ),
            const SizedBox(height: 10),
            const Text(
              'Fill in your details to sign up',
              style:
                  TextStyle(fontSize: 16, color: AppColor.secondaryTextColor),
            ),
            const SizedBox(height: 40),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  /// Username textField
                  TextFormField(
                    controller: _authViewModel.usernameController.value,
                    focusNode: _authViewModel.usernameFocusNode.value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Username';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      Utils.fieldFocusChange(
                        context,
                        _authViewModel.usernameFocusNode.value,
                        _authViewModel.emailFocusNode.value,
                      );
                    },
                    decoration: KUsernameTextFieldDecoration,
                  ),
                  const SizedBox(height: 20),

                  /// Email textField
                  TextFormField(
                    controller: _authViewModel.emailController.value,
                    focusNode: _authViewModel.emailFocusNode.value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Email';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      Utils.fieldFocusChange(
                        context,
                        _authViewModel.emailFocusNode.value,
                        _authViewModel.passwordFocusNode.value,
                      );
                    },
                    decoration: KEmailTextFieldDecoration,
                  ),
                  const SizedBox(height: 20),

                  /// Password textField
                  TextFormField(
                    controller: _authViewModel.passwordController.value,
                    focusNode: _authViewModel.passwordFocusNode.value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Password';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {},
                    obscuringCharacter: '*',
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: AppColor.primaryColor,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColor.primaryColor,
                        ),
                        onPressed: _togglePasswordVisibility,
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
              ),
            ),
            const SizedBox(height: 30),
            Obx(
              () => RoundButton(
                loading: _authViewModel.loading.value,
                title: 'Sign Up Now',
                Fontsize: 20,
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    _authViewModel.signup();
                  }
                },
                width: 285,
                height: 50,
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                // Navigate back to Login page
                Get.toNamed(Routename.loginScreen);
                _authViewModel.clearTEC();
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
