import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LoginPageController extends GetxController{
  TextEditingController emailphone = TextEditingController();
  TextEditingController paassword = TextEditingController();

  bool emailcheckk = false;
  bool passcheckk = false;
  String emailerrorr = "";
  String passerrorr = "";
  bool passwordVisible = false;
  bool remactivate = false;

}