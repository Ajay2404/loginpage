import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loginpage/controllers/auth_page_controller/splash_page_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../../common/common_colors.dart';
import '../../app_screen/dataBaseHelper.dart';
import '../../app_screen/home_page_screen/home_Page_Screen.dart';
import '../login_page_screen/loginPage.dart';

class SplashScreen extends StatefulWidget {
  static SharedPreferences? prefs;
  static Database? db;

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashPageCtrl = Get.put(SplashPageController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ForSharePrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Lottie.asset("animation/contacts.json"),
      ),
    );
  }

  Future<void> ForSharePrefs() async {
    SplashScreen.prefs = await SharedPreferences.getInstance();
    setState(() {
      splashPageCtrl.Islogin =
          SplashScreen.prefs!.getBool("loginstatus") ?? false;
    });

    DataBaseHelper().GetDataBase().then((value) {
      setState(() {
        SplashScreen.db = value;
      });
    });

    Future.delayed(Duration(seconds: 4)).then((value) {
      if (splashPageCtrl.Islogin) {
        Get.to(HomePage());
      } else {
        Get.to(LoginPage());
      }
    });
  }
}
