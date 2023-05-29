import 'package:bordeaux/common_widgets/page_transition.dart';
import 'package:bordeaux/screens/age_verification.dart';
import 'package:bordeaux/screens/group_chat_inbox.dart';
import 'package:bordeaux/screens/group_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

import '../controllers/general_controller.dart';
import '../helpers/constants.dart';
import '../screens/chart.dart';
import '../screens/general_setting_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/profile_screen.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final generalController = Get.find<GeneralController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 55.w,
      backgroundColor: Colors.black.withOpacity(0.7),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                Get.back();
                // Get.offAll(() => HomeScreen());
                generalController
                    .backgroundImageCounter(generateRandomNumber(0, 11));

                PageTransition.fadeInNavigation(page: HomeScreen());
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.white.withOpacity(0.3)))),
                height: 50,
                child: Center(
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 17,
                      ),
                      Text(
                        'Home',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Interbold',
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Colors.white.withOpacity(0.3)))),
              height: 50,
              child: Center(
                child: InkWell(
                  onTap: (){
                    PageTransition.fadeInNavigation(page: AgeVerification());
                  },
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 17,
                      ),
                      Text(
                        'Age Verification',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Interbold',
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                Get.to(()=>GroupChatScreen());
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.white.withOpacity(0.3)))),
                height: 50,
                child: Center(
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 17,
                      ),
                      Text(
                        'Chat',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Interbold',
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.back();
                PageTransition.fadeInNavigation(page: ProfileScreen());
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.white.withOpacity(0.3)))),
                height: 50,
                child: Center(
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 17,
                      ),
                      Text(
                        'Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Interbold',
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            InkWell(
              onTap: () {
                Get.back();
                PageTransition.fadeInNavigation(page: GeneralSettingPage());
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.white.withOpacity(0.3)))),
                height: 50,
                child: Center(
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 17,
                      ),
                      Text(
                        'Setting',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Interbold',
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Colors.white.withOpacity(0.3)))),
              height: 50,
              child: Center(
                child: Row(
                  children: const [
                    SizedBox(
                      width: 17,
                    ),
                    Text(
                      'Log out',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Interbold',
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
