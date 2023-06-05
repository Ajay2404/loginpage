import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loginpage/controllers/auth_page_controller/login_page_controller.dart';

import '../../../common/common_colors.dart';
import '../../../config.dart';
import '../../app_screen/dataBaseHelper.dart';
import '../../app_screen/forgot_page_screen/forgotPassPage.dart';
import '../../app_screen/home_page_screen/home_Page_Screen.dart';
import '../register_page_screen/registerPage.dart';
import '../splash_screen/splashScreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginPageCtrl = Get.put(LoginPageController());

  @override
  void initState() {
    super.initState();
    loginPageCtrl.passwordVisible = true;
    loginPageCtrl.remactivate = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 140,
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0),
                ),
              ),
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(fonts.welcome,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30)),
                  Text(fonts.logintoaccount,
                      style: const TextStyle(fontSize: 18)),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(8, 80, 8, 60),
              padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0),
                ),
              ),
              child: Column(children: [
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: loginPageCtrl.emailphone,
                    decoration: InputDecoration(
                        errorText: loginPageCtrl.emailcheckk
                            ? loginPageCtrl.emailerrorr
                            : null,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: fonts.enteremail),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    obscureText: loginPageCtrl.passwordVisible,
                    controller: loginPageCtrl.paassword,
                    decoration: InputDecoration(
                      errorText: loginPageCtrl.passcheckk
                          ? loginPageCtrl.passerrorr
                          : null,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: fonts.password,
                      suffixIcon: IconButton(
                        icon: Icon(loginPageCtrl.passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(
                            () {
                              loginPageCtrl.passwordVisible =
                                  !loginPageCtrl.passwordVisible;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                        onPressed: () {
                          setState(
                            () {
                              loginPageCtrl.remactivate =
                                  !loginPageCtrl.remactivate;
                            },
                          );
                        },
                        icon: Icon(
                          loginPageCtrl.remactivate
                              ? Icons.check_circle_outline_sharp
                              : Icons.check_circle,
                          color: const Color(0xfff79515),
                        )),
                    Text(fonts.rememberme,
                        style: const TextStyle(color: Colors.grey)),
                    const SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(
                          const ForgotPassword(),
                          // transition: Transition.leftToRight, duration: Duration(seconds: 3)
                        );
                      },
                      child: Text(fonts.forgotpass,
                          style: const TextStyle(color: Color(0xfff79515))),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      loginPageCtrl.emailcheckk = false;
                      loginPageCtrl.passcheckk = false;
                      // RegExp emailRegExp = RegExp(r"\S+@\S+\.\S+");
                      // RegExp passRegExp = RegExp(
                      //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                      if (loginPageCtrl.emailphone.text.isEmpty) {
                        loginPageCtrl.emailcheckk = true;
                        loginPageCtrl.emailerrorr = fonts.blank;
                      } else if (loginPageCtrl.paassword.text.isEmpty) {
                        loginPageCtrl.passcheckk = true;
                        loginPageCtrl.passerrorr = fonts.blank;
                      }
                      // if (!emailRegExp.hasMatch(emailphone.text)) {
                      //   emailcheckk = true;
                      //   emailerrorr = "Please Enter Valid Email";
                      // } else if (!passRegExp.hasMatch(paassword.text)) {
                      //   passcheckk = true;
                      //   passerrorr = "Enter Correct Password";
                      // }
                      DataBaseHelper()
                          .Loginuser(loginPageCtrl.emailphone.text,
                              loginPageCtrl.paassword.text, SplashScreen.db!)
                          .then(
                        (value) {
                          if (value.length == 1) {
                            SplashScreen.prefs!
                                .setInt("userid", value[0]['id']);
                            SplashScreen.prefs!
                                .setString("email", value[0]['email']);
                            SplashScreen.prefs!
                                .setBool("loginstatus", true)
                                .then(
                              (value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Login SuccessFully")));
                                Get.to(const HomePage());
                              },
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("User Not Found")));
                          }
                        },
                      );
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, left: 100, right: 100),
                        decoration: BoxDecoration(
                            color: bgColor,
                            border: Border.all(color: bgColor),
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          fonts.login,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      // IconButton(
                      //   icon: Icon(Icons.fingerprint),
                      //   onPressed: () {},
                      // ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
              ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(svgAssets.google),
                SvgPicture.asset(svgAssets.facebook),
                SvgPicture.asset(svgAssets.apple),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              alignment: Alignment.center,
              height: 118,
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(8, 30, 8, 0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(fonts.donthaveaccount),
                      InkWell(
                        onTap: () {
                          Get.to(
                            const RegisterPage(),
                            // transition: Transition.circularReveal, duration: Duration(seconds: 3)
                          );
                        },
                        child: Text(
                          fonts.createaccount,
                          style: const TextStyle(
                            color: Color(0xfff79515),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
