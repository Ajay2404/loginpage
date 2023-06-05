import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loginpage/config.dart';

import '../../../../common/common_colors.dart';
import '../forgotPassPage.dart';

class SendCodePage extends StatefulWidget {
  const SendCodePage({Key? key}) : super(key: key);

  @override
  State<SendCodePage> createState() => _SendCodePageState();
}

class _SendCodePageState extends State<SendCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(13),
                  child: InkWell(
                      onTap: () {
                        Get.to(ForgotPassword());
                      },
                      child: SvgPicture.asset(
                        svgAssets.mm2,
                        height: 40,
                      )),
                ),
                SizedBox(
                  width: 70,
                ),
                Text(fonts.otpverify,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: 100),
                child: Image(image: AssetImage(imageAssets.mm1))),
            Text(fonts.enterotp),
            Text(fonts.digitcode),
            Row(
              children: [
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    keyboardType: TextInputType.number,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffe3e3e3),
                  ),
                  height: 50,
                  width: 50,
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: TextField(
                    keyboardType: TextInputType.number,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffe3e3e3),
                  ),
                  height: 50,
                  width: 50,
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: TextField(
                    keyboardType: TextInputType.number,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffe3e3e3),
                  ),
                  height: 50,
                  width: 50,
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: TextField(
                    keyboardType: TextInputType.number,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffe3e3e3),
                  ),
                  height: 50,
                  width: 50,
                ),
              ],
            ),
            Row(
              children: [
                Text(fonts.didntrecieve),
                InkWell(
                    onTap: () {},
                    child: Text(fonts.resendotp,
                        style: TextStyle(color: bgColor))),
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 80, top: 180),
                decoration: BoxDecoration(
                    color: bgColor,
                    border: Border.all(color: bgColor),
                    borderRadius: BorderRadius.circular(20)),
                padding:
                    EdgeInsets.only(top: 20, bottom: 20, right: 160, left: 160),
                child: Text(
                  fonts.verify,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
