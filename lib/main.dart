import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fruitbox/firebase_options.dart';
import 'package:fruitbox/resources/routes/routes.dart';
import 'package:fruitbox/view/auth/continue_screen.dart';
import 'package:fruitbox/view/auth/signup.dart';
import 'package:fruitbox/view/splash_screen.dart';
import 'package:fruitbox/viewmodel/controller/check_connectivity.dart';
import 'package:fruitbox/viewmodel/controller/dependency_injection.dart';
import 'package:fruitbox/viewmodel/controller/themecontroller/themecontroller.dart';
import 'package:get/get.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

Future<void> main() async {
  await PersistentShoppingCart().init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate();
  DependencyInjection.init();
  // await FirebaseAppCheck.instance.activate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _theme = Get.put(themeController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _theme.isDarkMode.value ? ThemeData.dark() : ThemeData.light(),
        // home: const MyHomePage(
        //   title: 'checking internet',
        // ),
        initialRoute: '/',
        getPages: appRoutes.AppRoutes(),
      ),
    );
  }
}
