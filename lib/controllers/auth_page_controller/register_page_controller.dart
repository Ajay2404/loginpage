import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class RegisterPageController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController password = TextEditingController();

  bool namecheck = false;
  bool emailcheck = false;
  bool numcheck = false;
  bool passcheck = false;

  bool datecheck = false;
  bool passvisible = false;

  List<String> selectedHobbies = [];
  String gender = "";
  String dropdownvalue = 'Select';
  String error = "";
}
