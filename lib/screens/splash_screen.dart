import 'dart:math' show pi;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../helpers/constants.dart';
import '../models/user_model.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  double value = 0.99;
  String text = "Loading..";
  late AnimationController _contorller;
  late AnimationController _contorllerCounterClock;
  late Animation<double> _animation;
  late Animation<double> _animationCounterClock;
  late bool login;
  getData() async {
    login = await getUserLoggedIn();
    if (login == true) {
      ageVerified.value = true;
      var userid = await getUserData();
      userDocId.value = userid.toString();
      setState(() {
        loggedInGlobal.value = true;
      });
      await FirebaseMessaging.instance.getToken().then((value) {
        fcmToken.value = value!;
        if (kDebugMode) {
          print("Token saved");
        }
        if (kDebugMode) {
          print(fcmToken.value);
        }
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userDocId.value)
          .update({'FcmToken': fcmToken.value});
      FirebaseFirestore.instance
          .collection('users')
          .doc(userDocId.value)
          .get()
          .then((value) async {
        setState(() {
          userData = UserModel.fromDocument(value.data());
          EmailConst.value = value.data()!['email'];
          NameConst.value = value.data()!['displayName'];
          profileUrlConst.value = value.data()!['imageUrl'];
        });
      });
      Future.delayed(const Duration(milliseconds: 4000), () {
        Get.offAll(() => const HomeScreen(
              fromStart: false,
            ));
      });
    } else {
      Future.delayed(const Duration(milliseconds: 4000), () {
        Get.offAll(() => const HomeScreen(
              fromStart: false,
            ));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _contorller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _contorllerCounterClock =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _animation = Tween<double>(
      begin: 0.0,
      end: 2 * pi,
    ).animate(_contorller);

    _animationCounterClock = Tween<double>(
      begin: 2 * pi,
      end: 0.0,
    ).animate(_contorllerCounterClock);
    _contorllerCounterClock.repeat();
    _contorller.repeat();
    getData();
  }

  @override
  void dispose() {
    _contorller.dispose();
    _contorllerCounterClock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(alignment: Alignment.center, children: [
              Container(
                height: 100.h,
                width: 100.w,
              ),
              Positioned(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image.asset('assets/images/logo.png',
                  // height: 20.h,
                  //   width: 30.w,
                  // ),
                  SizedBox(
                    height: 25.h,
                  ),
                  AnimatedBuilder(
                      animation: _contorller,
                      builder: (context, child) {
                        return Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..rotateZ(_animation.value),
                          child: Image.asset(
                            'assets/images/logo_black.png',
                            height: 75,
                            width: 75,
                          ),
                        );
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'BORDEAUX',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Interbold',
                            fontSize: 36),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                ],
              ))
            ])
          ],
        ));
  }
}
