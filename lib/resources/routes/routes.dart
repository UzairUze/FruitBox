import 'package:fruitbox/resources/routes/routename.dart';
import 'package:fruitbox/view/CongratulationsScreen/CongratulationsScreen.dart';
import 'package:fruitbox/view/auth/auth_screen.dart';
import 'package:fruitbox/view/auth/continue_screen.dart';
import 'package:fruitbox/view/auth/forgetpassword.dart';
import 'package:fruitbox/view/auth/login.dart';
import 'package:fruitbox/view/auth/login_with_number.dart';
import 'package:fruitbox/view/auth/signup.dart';
import 'package:fruitbox/view/checkout/checkout.dart';
import 'package:fruitbox/view/payment/payment.dart';
import 'package:fruitbox/view/privacypolicy/privacypolicy.dart';
import 'package:fruitbox/view/trackorder/trackOrder.dart';
import 'package:fruitbox/view/trackorder/trackOrder.dart';
import 'package:fruitbox/view/welcome/welcome_screen.dart';
import 'package:get/get.dart';

import '../../view/splash_screen.dart';

class appRoutes {
  static AppRoutes() => [
        GetPage(
            name: Routename.splashScreen,
            page: () => SplashScreen(),
            transitionDuration: Duration(milliseconds: 250),
            transition: Transition.downToUp),
        GetPage(
            name: Routename.continueScreen,
            page: () => continueScreen(),
            transitionDuration: Duration(milliseconds: 100),
            transition: Transition.downToUp),
        GetPage(
            name: Routename.authScreen,
            page: () => AuthScreen(),
            transitionDuration: Duration(milliseconds: 100),
            transition: Transition.downToUp),
        GetPage(
            name: Routename.loginScreen,
            page: () => loginScreen(),
            transitionDuration: Duration(milliseconds: 100),
            transition: Transition.downToUp),
        GetPage(
            name: Routename.welcomeScreen,
            page: () => WelcomeScreen(),
            transitionDuration: Duration(milliseconds: 100),
            transition: Transition.downToUp),
        GetPage(
            name: Routename.signUpScreen,
            page: () => SignUpScreen(),
            transitionDuration: Duration(milliseconds: 100),
            transition: Transition.downToUp),
        GetPage(
            name: Routename.SignUpWithNumberScreen,
            page: () => SignUpWithNumberScreen(),
            transitionDuration: Duration(milliseconds: 100),
            transition: Transition.downToUp),
        GetPage(
            name: Routename.forgetpassword,
            page: () => ForgotPasswordScreen(),
            transitionDuration: Duration(milliseconds: 100),
            transition: Transition.downToUp),
        GetPage(
            name: Routename.CongratulationsScreen,
            page: () => CongratulationsScreen(),
            transitionDuration: Duration(milliseconds: 100),
            transition: Transition.downToUp),
        GetPage(
            name: Routename.TrackOrderScreen,
            page: () => TrackOrderScreen(),
            transitionDuration: Duration(milliseconds: 100),
            transition: Transition.downToUp),
        GetPage(
            name: Routename.CheckoutPage,
            page: () => CheckoutPage(),
            transitionDuration: Duration(milliseconds: 100),
            transition: Transition.downToUp),
        GetPage(
            name: Routename.PaymentScreen,
            page: () => PaymentScreen(),
            transitionDuration: Duration(milliseconds: 100),
            transition: Transition.downToUp),
        GetPage(
            name: Routename.PrivacyPolicyPage,
            page: () => PrivacyPolicyPage(),
            transitionDuration: Duration(milliseconds: 100),
            transition: Transition.downToUp),
      ];
}
