import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loginpage/controllers/app_page_controllers/edit_page_controller.dart';
import 'package:loginpage/screen/app_screen/dataBaseHelper.dart';
import 'package:loginpage/screen/auth_screen/splash_screen/splashScreen.dart';

import '../../../common/common_colors.dart';
import '../../../config.dart';
import '../home_page_screen/home_Page_Screen.dart';

class EditScreen extends StatefulWidget {
  Map contactdetail;

  EditScreen(Map this.contactdetail, {Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final editPageCtrl = Get.put(EditPageController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editPageCtrl.newname.text = widget.contactdetail["name"].toString();
    editPageCtrl.newnumber.text = widget.contactdetail["number"].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
          elevation: 0,
          shadowColor: bgColor,
          surfaceTintColor: bgColor,
          backgroundColor: bgColor,
          title: Text(
            fonts.updatecontact,
          )),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 400,
              child: Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(8, 130, 8, 30),
                  padding: EdgeInsets.only(left: 30, right: 30, top: 50),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: editPageCtrl.newname,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: fonts.newname),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: editPageCtrl.newnumber,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: fonts.newnum),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 140,
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(8, 0, 8, 200),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      DataBaseHelper()
                          .update(
                              editPageCtrl.newname.text,
                              editPageCtrl.newnumber.text,
                              widget.contactdetail['id'],
                              SplashScreen.db!)
                          .then(
                        (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(fonts.updatesuccess)));
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return HomePage();
                            },
                          ));
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 20, bottom: 20, left: 60, right: 60),
                      decoration: BoxDecoration(
                          color: bgColor,
                          border: Border.all(color: bgColor),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        fonts.update,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(fonts.cancelupdate)));
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return HomePage();
                        },
                      ));
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 20, bottom: 20, left: 60, right: 60),
                      decoration: BoxDecoration(
                          color: bgColor,
                          border: Border.all(color: bgColor),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        fonts.cancel,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
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
