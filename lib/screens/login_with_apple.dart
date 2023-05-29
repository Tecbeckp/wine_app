import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../common_widgets/colors.dart';
import '../common_widgets/page_transition.dart';
import 'home_screen.dart';

class LoginWithApple extends StatefulWidget {
  const LoginWithApple({Key? key}) : super(key: key);

  @override
  State<LoginWithApple> createState() => _LoginWithAppleState();
}
final TextEditingController appleId = TextEditingController();
final TextEditingController applepassword = TextEditingController();
final TextEditingController emailId = TextEditingController();
final TextEditingController emailpassword = TextEditingController();
List<String> socialButtons = [
  'assets/images/weather.png',
  'assets/images/measure.png',
  'assets/images/wallet.png',
  'assets/images/applestore.png',
  'assets/images/appstore.png',
  'assets/images/iosmessage.png',
  'assets/images/applemusic.png',
];
_divider(){
  return const SizedBox(height: 15);
}

class _LoginWithAppleState extends State<LoginWithApple> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child:
        Stack(
            fit: StackFit.expand,
            children: [
              ColorFiltered(
                colorFilter:  ColorFilter.mode(
                  Colors.black.withOpacity(0.2),
                  BlendMode.darken,
                ),
                child: Image.asset('assets/images/background_grocery.png',fit: BoxFit.fill,),),

              Positioned(
                  top: 70,
                  child: SizedBox(
                    width: 100.w,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/logo_white.png',
                                  height: 47,
                                  width: 60,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  'BORDEAUX',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontFamily: 'ManropeBold'),
                                )
                              ],
                            ),
                            const SizedBox(height: 30),


                            DelayedDisplay(delay: Duration(milliseconds: 300,),fadeIn: true,
                              child: Container(
                                height: 100.h<680?73.h:75.h,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only( left: 17, right: 17,bottom: 5,top: 7),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:  [
                                          Text(
                                            'Login with Apple ID',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 18.sp),
                                          )
                                        ],
                                      ),
                                      Center(
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(left: 37, right: 37),
                                            child: Text(
                                              'Sign in with your Apple ID to use to  access user apple health account',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,

                                                height: 1.6,
                                                color: AppColors.black.withOpacity(0.6),
                                                fontSize: 8.sp,
                                              ),
                                            ),
                                          )),
                                      SizedBox(height: 100.h <670 ? 0:10,),
                                      SizedBox(height: 7.h,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            hintText: 'Name / Email / Phone',
                                            labelText: 'APPLE ID',
                                            prefixIcon: Image.asset(
                                              'assets/images/user_icon.png',
                                              scale: 3,
                                            ),
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 1.2,
                                                fontSize: 12,
                                                color: AppColors.black.withOpacity(0.4)),
                                            labelStyle: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 1.2,
                                                fontSize: 12,
                                                color: AppColors.black.withOpacity(0.4)),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey.withOpacity(0.2),
                                                  width: 1.5),
                                              borderRadius: BorderRadius.circular(7),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey.withOpacity(0.2),
                                                  width: 1.5),
                                              borderRadius: BorderRadius.circular(7),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red.withOpacity(0.8),
                                                  width: 1.5),
                                              borderRadius: BorderRadius.circular(7),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 100.h <670 ? 0:10,),
                                      SizedBox(
                                        height: 7.h,
                                        child: TextFormField(controller: applepassword,
                                          decoration: InputDecoration(
                                            hintText: 'Password',
                                            labelText: 'PASSWORD',
                                            prefixIcon: Image.asset(
                                              'assets/images/lock_icon.png',
                                              scale: 3,
                                            ),
                                            hintStyle: TextStyle(
                                                letterSpacing: 1.2,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.black.withOpacity(0.4)),
                                            labelStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 1.2,
                                                color: AppColors.black.withOpacity(0.4)),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey.withOpacity(0.2),
                                                  width: 1.5),
                                              borderRadius: BorderRadius.circular(7),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey.withOpacity(0.2),
                                                  width: 1.5),
                                              borderRadius: BorderRadius.circular(7),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red.withOpacity(0.8),
                                                  width: 1.5),
                                              borderRadius: BorderRadius.circular(7),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 100.h <670 ? 0:10,),
                                      Container(

                                        width: 90.w,
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            PageTransition.fadeInNavigation(page: HomeScreen());
                                          },
                                          child: const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(13),
                                              child: Text(
                                                'Sign In',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 19,
                                                  fontFamily: 'InterMedium',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 100.h <670 ? 0:10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:  [
                                          Text(
                                            'Don’t have an  ID or forgot password?',
                                            style: TextStyle(
                                                color: AppColors.primary,
                                                fontSize: 9.sp,
                                                fontFamily: 'InterMedium'),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 100.h <670 ? 0:10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          for(int index=0;index<socialButtons.length;index++)
                                            Container(
                                              width: 71.w / 7,
                                              height: 71.w / 7,
                                              margin: EdgeInsets.only(
                                                  right: index ==
                                                      socialButtons.length - 1
                                                      ? 0
                                                      : 5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color:
                                                    Colors.grey.withOpacity(0.4),
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(5)),
                                              child: Padding(
                                                padding: const EdgeInsets.all(6),
                                                child:
                                                Image.asset(socialButtons[index]),
                                              ),
                                            ),
                                        ],
                                      ),
                                      SizedBox(height: 100.h <670 ? 0:10,),
                                      Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 22, right: 22),
                                            child: Text(
                                              'Your Apple ID is the account you use to access all Apple services.',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                height: 1.6,
                                                letterSpacing: 0.2,
                                                fontSize: 10.sp,
                                              ),
                                            ),
                                          )),
                                      SizedBox(height: 100.h <670 ? 0:10,),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 6, right: 6),
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                  'Your Apple ID information is used to enable Apple Services when you sign in,including iCloudBackup which automatically backup the data on your device in case you need to replace or restore it.',
                                                  style: TextStyle(
                                                      color: AppColors.black
                                                          .withOpacity(0.5),
                                                      height: 1.8,
                                                      fontSize: 9.5.sp)),
                                              TextSpan(
                                                  text:
                                                  ' See how your data is managed...',
                                                  style: const TextStyle(
                                                      color: AppColors.primary,
                                                      height: 1.7,
                                                      fontSize: 12),
                                                  recognizer: TapGestureRecognizer()
                                                    ..onTap = () {
                                                      print(
                                                        'Terms of Service"',
                                                      );
                                                    }),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 100.h <670 ? 0:10,),
                                    ],
                                  ),
                                ),
                              ),
                            )

                          ],
                        ),
                      ),
                    ),
                  )),
            ]),
      ),
    );
  }
}
