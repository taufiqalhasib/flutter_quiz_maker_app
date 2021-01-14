import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{

  static String userLoggedIn = "USERLOGGINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAIL";
  static String userTypeKey = "USERTYPE";

  static saveUserLoggedInDetails({@required bool isLoggedIn}) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(HelperFunctions.userLoggedIn, isLoggedIn);
  }

  static Future<bool> getUserLoggedInDetails() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(HelperFunctions.userLoggedIn);
  }

  static saveUserTypeDetails({@required String userType}) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(HelperFunctions.userTypeKey, userType);
  }

  static Future<String> getUserTypeDetails() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(HelperFunctions.userTypeKey);
  }
}