import 'dart:math';

import 'package:flutter/cupertino.dart';
import '../models/user_model.dart';

var groupNotificationTitle;
var freeSearchCounter = 0;
final loggedInGlobal = ValueNotifier(false);
UserModel userData = UserModel(
    fcmToken: "",
    displayName: "",
    email: "",
    imageUrl: "",
    address: '',
    bio: '',
    phoneNumber: '');
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

