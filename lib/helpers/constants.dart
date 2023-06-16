import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

var groupNotificationTitle;
var freeSearchCounter = 0;
final loggedInGlobal = ValueNotifier(false);
final ageVerified = ValueNotifier(false);
UserModel userData = UserModel(
    fcmToken: "",
    displayName: "",
    email: "",
    imageUrl: "",
    address: '',
    bio: '',
    phoneNumber: '',
    notification: true);
final userDocId = ValueNotifier("");
final EmailConst = ValueNotifier("");
final NameConst = ValueNotifier("");
final fcmToken = ValueNotifier("");
final profileUrlConst = ValueNotifier("");

var FcmToken;
late List<String> chatRespList;
var subscription = false;

generateRandomNumber(int min, int max) {
  return min + Random().nextInt(max - min);
}

void setUserLoggedIn(bool key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("isLoggedIn", key);
}

Future getUserLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var log = prefs.getBool("isLoggedIn") ?? false;
  return log;
}

void saveUserData({@required userID}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString("userID", userID);
}

Future getUserData() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? result = pref.getString("userID");
  return result;
}
