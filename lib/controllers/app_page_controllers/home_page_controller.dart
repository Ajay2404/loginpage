import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController{
  List<Map> contactdetails = [];
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController searchController = TextEditingController();
  bool isSearch = false;
  bool isFavorite = false;
  bool Isdata = false;
  List<Map> searchData = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();

}