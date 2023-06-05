import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:loginpage/screen/auth_screen/splash_screen/splashScreen.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
    builder: EasyLoading.init(),
  ));
}
