import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loginpage/common/common_colors.dart';
import 'package:loginpage/config.dart';
import 'package:loginpage/controllers/app_page_controllers/home_page_controller.dart';
import 'package:loginpage/screen/app_screen/dataBaseHelper.dart';
import 'package:loginpage/screen/app_screen/edit_page_screen/editScreen.dart';
import 'package:loginpage/screen/auth_screen/login_page_screen/loginPage.dart';
import 'package:loginpage/screen/auth_screen/splash_screen/splashScreen.dart';

import '../favorite_page_screen/favorite_page.dart';

class HomePage extends StatefulWidget {
  //favorite list..//drawer options 1.manage_contacts.2.create group_Contact.
  // 3.recycle_bin(if i delete contact it will delete from the list of contact
  // and add in recycle bin and then user delete it from recycle bin and if not
  // delete then it will automatic permanently delete after 30 days)
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homePageCtrl = Get.put(HomePageController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ViewData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: bgColor,
              ),
              child: Column(
                children: [
                  Text(
                    "${SplashScreen.prefs!.getString("email") ?? ""}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Text("All Contacts"),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text('Manage Contacts'),
              onTap: () {
                // Handle Manage Contacts tap
              },
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text('Create Group Contact'),
              onTap: () {
                // Handle Create Group Contact tap
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Recycle Bin'),
              onTap: () {},
            ),
          ],
        ),
      ),
      key: homePageCtrl.scaffoldKey,
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        shadowColor: bgColor,
        surfaceTintColor: bgColor,
        actions: [
          IconButton(
              onPressed: () {
                SplashScreen.prefs!.setBool("loginstatus", false).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(fonts.loginsuccess)));
                  Get.off(LoginPage());
                });
              },
              icon: Icon(Icons.logout)),
        ],
        leading: IconButton(
            onPressed: () {
              if (homePageCtrl.scaffoldKey.currentState!.isDrawerOpen) {
                homePageCtrl.scaffoldKey.currentState!.closeDrawer();
              } else {
                homePageCtrl.scaffoldKey.currentState!.openDrawer();
              }
            },
            icon: Icon(Icons.menu)),
        backgroundColor: bgColor,
        // title: Text(
        //   "${SplashScreen.prefs!.getString("email") ?? ""}",
        // )
      ),
      body: homePageCtrl.Isdata
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: !homePageCtrl.isFavorite,
                      child: Container(
                        height: 60,
                        width: homePageCtrl.isSearch ? 390 : 190,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  homePageCtrl.isSearch =
                                      !homePageCtrl.isSearch;
                                });
                              },
                              icon: Icon(
                                homePageCtrl.isSearch
                                    ? Icons.close
                                    : Icons.search,
                              ),
                            ),
                            if (homePageCtrl.isSearch)
                              Expanded(
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      if (value.isNotEmpty) {
                                        homePageCtrl.searchData = [];
                                        for (int i = 0;
                                            i <
                                                homePageCtrl
                                                    .contactdetails.length;
                                            i++) {
                                          String name = homePageCtrl
                                              .contactdetails[i]["name"];
                                          String number = homePageCtrl
                                              .contactdetails[i]["number"];
                                          if (name.toLowerCase().contains(
                                                  value.toLowerCase()) ||
                                              number.contains(value)) {
                                            homePageCtrl.searchData.add(
                                                homePageCtrl.contactdetails[i]);
                                            print(
                                                "Search===${homePageCtrl.searchData}");
                                          }
                                        }
                                      } else {
                                        homePageCtrl.searchData =
                                            homePageCtrl.contactdetails;
                                      }
                                    });
                                  },
                                  autofocus: true,
                                  controller: homePageCtrl.searchController,
                                  decoration: InputDecoration(
                                    hintText:
                                        '${homePageCtrl.contactdetails.length} Contacts',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ).paddingOnly(left: 10),
                    ),
                    Visibility(
                      visible: !homePageCtrl.isSearch,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: 60,
                              width: 190,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.center,
                                onPressed: () {
                                  Get.to(FavoritePage());
                                },
                                icon: Icon(
                                  Icons.star,
                                ),
                              ),
                            ).paddingOnly(right: 10),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(8, 20, 8, 0),
                    padding: EdgeInsets.only(left: 10, right: 10, top: 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                    child: homePageCtrl.searchData.isEmpty
                        ? Center(child: Text('No data found.'))
                        : ListView.builder(
                            itemCount: homePageCtrl.isSearch
                                ? homePageCtrl.searchData.length
                                : homePageCtrl.contactdetails.length,
                            itemBuilder: (context, index) {
                              Map map = homePageCtrl.isSearch
                                  ? homePageCtrl.searchData[index]
                                  : homePageCtrl.contactdetails[index];
                              return Container(
                                child: ListTile(
                                  leading: IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(
                                                  "Change Profile Picture"),
                                              content: Column(
                                                children: [
                                                  Text("Choose From Gallery"),
                                                  Text("Cancel"),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        Icons.account_circle,
                                        size: 30,
                                      )),
                                  title: Text(
                                    "${map['name']}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  subtitle: Text("  +91 ${map['number']}",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black)),
                                  trailing: PopupMenuButton(
                                    onSelected: (value) {
                                      if (value == 1) {
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return EditScreen(map);
                                          },
                                        ));
                                      }
                                    },
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                            value: 1,
                                            child: Text(fonts.update)),
                                        PopupMenuItem(
                                            value: 2,
                                            onTap: () {
                                              DataBaseHelper()
                                                  .deleteContact(
                                                      homePageCtrl
                                                              .contactdetails[
                                                          index]["id"],
                                                      SplashScreen.db!)
                                                  .then((value) {
                                                ViewData();
                                              });
                                            },
                                            child: Text(fonts.delete)),
                                        PopupMenuItem(
                                            child: Text(fonts.favorite))
                                      ];
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: bgColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: AlertDialog(
                  title: Column(children: [
                    Text(fonts.contactdetail),
                    SizedBox(height: 20),
                    Tooltip(
                        message: fonts.addimg,
                        child: SvgPicture.asset(
                          svgAssets.contact,
                          height: 100,
                        ))
                  ]),
                  actions: [
                    TextField(
                        controller: homePageCtrl.name,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            label: Text(
                              fonts.name,
                              style: TextStyle(fontWeight: FontWeight.w100),
                            ))),
                    SizedBox(height: 20),
                    TextField(
                        keyboardType: TextInputType.phone,
                        controller: homePageCtrl.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            label: Text(
                              fonts.number,
                              style: TextStyle(fontWeight: FontWeight.w100),
                            ))),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        int user = SplashScreen.prefs!.getInt("userid") ?? 0;
                        DataBaseHelper()
                            .insertcontact(
                                homePageCtrl.name.text,
                                homePageCtrl.number.text,
                                user,
                                SplashScreen.db!)
                            .then((value) {
                          ViewData();
                        });
                        homePageCtrl.name.text = "";
                        homePageCtrl.number.text = "";
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: bgColor,
                            border: Border.all(color: bgColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          fonts.save,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ).paddingOnly(
                          top: 20,
                          right: 20,
                          left: 20,
                          bottom: 20,
                        ),
                      ).paddingOnly(top: 10),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void ViewData() {
    int view = SplashScreen.prefs!.getInt("userid") ?? 0;
    DataBaseHelper().contactview(view, SplashScreen.db!).then((value) async {
      homePageCtrl.contactdetails = value;
      homePageCtrl.searchData = value;
      homePageCtrl.Isdata = true;
      await Future.delayed(Duration(seconds: 1));
      EasyLoading.dismiss();
      setState(() {});
    });
  }
}
