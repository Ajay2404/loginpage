import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../common/common_colors.dart';
import '../../../config.dart';
import 'layouts/sendCodePage.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              child: Image.asset(imageAssets.img, fit: BoxFit.fill),
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Container(
              padding: EdgeInsets.only(bottom: 150, right: 130),
              alignment: Alignment.center,
              child: Text(
                fonts.forgotpass,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          Container(
              padding: EdgeInsets.only(bottom: 100, right: 200),
              alignment: Alignment.center,
              child: Text(
                fonts.emailadd,
                style: TextStyle(fontSize: 15),
              )),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 30, left: 30, top: 20),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: fonts.enteremailornum),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(SendCodePage());
            },
            child: Container(
              decoration: BoxDecoration(
                  color: bgColor,
                  border: Border.all(color: bgColor),
                  borderRadius: BorderRadius.circular(20)),
              padding:
                  EdgeInsets.only(top: 20, bottom: 20, right: 140, left: 140),
              margin: EdgeInsets.only(top: 530, left: 30),
              child: Text(
                fonts.sendcode,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
