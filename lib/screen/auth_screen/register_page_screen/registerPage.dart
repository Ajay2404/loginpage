import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loginpage/config.dart';
import 'package:loginpage/controllers/auth_page_controller/register_page_controller.dart';
import 'package:multiselect/multiselect.dart';

import '../../../common/common_colors.dart';
import '../../app_screen/dataBaseHelper.dart';
import '../login_page_screen/loginPage.dart';
import '../splash_screen/splashScreen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final registerPageCtrl = Get.put(RegisterPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 100),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imageAssets.register), fit: BoxFit.fill),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(fonts.register,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 35)),
                    SizedBox(
                      height: 20,
                    ),
                    Text(fonts.newaccount, style: TextStyle(fontSize: 18)),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: TextField(
                        controller: registerPageCtrl.name,
                        decoration: InputDecoration(
                            errorText: registerPageCtrl.namecheck
                                ? registerPageCtrl.error
                                : null,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: fonts.entername),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 20,
                        left: 20,
                      ),
                      child: TextField(
                        controller: registerPageCtrl.email,
                        decoration: InputDecoration(
                            errorText: registerPageCtrl.emailcheck
                                ? registerPageCtrl.error
                                : null,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: fonts.enteremail),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          child: CountryCodePicker(
                            // onChanged: print,
                            showFlag: true,
                            showCountryOnly: false,
                            initialSelection: "भारत",
                            favorite: ['+91', 'IND'],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 235,
                          height: 60,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: registerPageCtrl.phone,
                            decoration: InputDecoration(
                                errorText: registerPageCtrl.numcheck
                                    ? registerPageCtrl.error
                                    : null,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: fonts.phonenum),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 30),
                        Text(fonts.gender, style: TextStyle(fontSize: 15)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Row(
                            children: [
                              SizedBox(width: 30),
                              Radio(
                                fillColor:
                                    MaterialStatePropertyAll(Color(0xfff79515)),
                                value: 'male',
                                groupValue: registerPageCtrl.gender,
                                onChanged: (value) {
                                  setState(() {
                                    registerPageCtrl.gender = value!;
                                  });
                                },
                              ),
                              SizedBox(width: 10),
                              Text(fonts.male),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Radio(
                                fillColor:
                                    MaterialStatePropertyAll(Color(0xfff79515)),
                                value: 'female',
                                groupValue: registerPageCtrl.gender,
                                onChanged: (value) {
                                  setState(() {
                                    registerPageCtrl.gender = value!;
                                  });
                                },
                              ),
                              SizedBox(width: 10),
                              Text(fonts.female),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    Row(children: [
                      SizedBox(width: 30),
                      Text(fonts.qualification, style: TextStyle(fontSize: 15)),
                      SizedBox(width: 40),
                      DropdownButton(
                        borderRadius: BorderRadius.circular(30),
                        value: registerPageCtrl.dropdownvalue,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: appArray.items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            registerPageCtrl.dropdownvalue = newValue!;
                          });
                        },
                      ),
                    ]),
                    Row(
                      children: [
                        SizedBox(width: 30),
                        Text(fonts.hobbies),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)),
                          width: 250,
                          child: DropDownMultiSelect(
                            options: appArray.hobbies,
                            selectedValues: registerPageCtrl.selectedHobbies,
                            onChanged: (value) {
                              setState(() {
                                registerPageCtrl.selectedHobbies = value;
                              });
                            },
                            whenEmpty: fonts.selecthobbies,
                          ),
                        ),
                      ],
                    ),
                    Row(children: [
                      SizedBox(width: 30),
                      Text(fonts.dob),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        width: 175,
                        child: TextField(
                          onTap: () async {
                            DateTime? datePicked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2024),
                            );
                            if (datePicked != null) {
                              print(datePicked);
                              String formattedDate =
                                  DateFormat('dd-MM-yyyy').format(datePicked);
                              print(formattedDate);
                              setState(() {
                                registerPageCtrl.date.text =
                                    formattedDate.toString();
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                          controller: registerPageCtrl.date,
                          readOnly: true,
                          decoration: InputDecoration(
                              suffixIcon: InkWell(
                                  onTap: () async {
                                    DateTime? datePicked = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime(2024),
                                    );
                                    if (datePicked != null) {
                                      print(datePicked);
                                      String formattedDate =
                                          DateFormat('dd-MM-yyyy')
                                              .format(datePicked);
                                      print(formattedDate);
                                      setState(() {
                                        registerPageCtrl.date.text =
                                            formattedDate.toString();
                                      });
                                    } else {
                                      print("Date is not selected");
                                    }
                                  },
                                  child: Icon(Icons.calendar_month)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: fonts.dmy),
                        ),
                      ),
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: TextField(
                        obscureText: registerPageCtrl.passvisible,
                        controller: registerPageCtrl.password,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(registerPageCtrl.passvisible
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(
                                  () {
                                    registerPageCtrl.passvisible =
                                        !registerPageCtrl.passvisible;
                                  },
                                );
                              },
                            ),
                            errorText: registerPageCtrl.passcheck
                                ? registerPageCtrl.error
                                : null,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: fonts.password),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 20, left: 20),
                    //   child: TextField(
                    //     // obscureText: true,
                    //     controller: confirmpass,
                    //     decoration: InputDecoration(
                    //         errorText: conpasscheck ? error : null,
                    //         border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(10)),
                    //         hintText: "Enter Confirm Password"),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          DataBaseHelper()
                              .insertData(
                                  registerPageCtrl.name.text,
                                  registerPageCtrl.email.text,
                                  registerPageCtrl.phone.text,
                                  SplashScreen.db!,
                                  registerPageCtrl.password.text)
                              .then((value) {
                            if (value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(fonts.registersuccess)));
                              Get.to(LoginPage());
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(fonts.useralready)));
                            }
                          });
                          registerPageCtrl.namecheck = false;
                          registerPageCtrl.emailcheck = false;
                          registerPageCtrl.numcheck = false;
                          registerPageCtrl.passcheck = false;

                          RegExp nameRegExp = RegExp(r"^[a-zA-Z]+$");
                          RegExp emailRegExp = RegExp(r'\S+@\S+\.\S+');
                          RegExp numRegExp = RegExp('^(?:[+0]9)?[0-9]{10}\$');
                          RegExp passRegExp = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                          if (registerPageCtrl.name.text.isEmpty) {
                            registerPageCtrl.namecheck = true;
                            registerPageCtrl.error = fonts.blank;
                          } else if (registerPageCtrl.email.text.isEmpty) {
                            registerPageCtrl.emailcheck = true;
                            registerPageCtrl.error = fonts.blank;
                          } else if (registerPageCtrl.phone.text.isEmpty) {
                            registerPageCtrl.numcheck = true;
                            registerPageCtrl.error = fonts.blank;
                          } else if (registerPageCtrl.password.text.isEmpty) {
                            registerPageCtrl.passcheck = true;
                            registerPageCtrl.error = fonts.blank;
                          }

                          ///regexp
                          if (!nameRegExp
                              .hasMatch(registerPageCtrl.name.text)) {
                            registerPageCtrl.namecheck = true;
                            registerPageCtrl.error = fonts.validname;
                          } else if (!emailRegExp
                              .hasMatch(registerPageCtrl.email.text)) {
                            registerPageCtrl.emailcheck = true;
                            registerPageCtrl.error = fonts.validemail;
                          } else if (!numRegExp
                              .hasMatch(registerPageCtrl.phone.text)) {
                            registerPageCtrl.numcheck = true;
                            registerPageCtrl.error = fonts.validnum;
                          } else if (!passRegExp
                              .hasMatch(registerPageCtrl.password.text)) {
                            registerPageCtrl.passcheck = true;
                            registerPageCtrl.error = fonts.validpass;
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: bgColor,
                            border: Border.all(color: bgColor),
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.only(
                            right: 100, left: 100, bottom: 20, top: 20),
                        child: Text(
                          fonts.signup,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
