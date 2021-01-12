import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{

  static String userLoggedIn = "USERLOGGINKEY";

  static saveUserLoggedInDetails({@required bool isLoggedIn}) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(userLoggedIn, isLoggedIn);
  }

  static Future<bool> getUserLoggedInDetails() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(userLoggedIn);
  }
}