
import 'package:delayed_display/delayed_display.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../common_widgets/colors.dart';
import '../common_widgets/common_loader.dart';
import '../helpers/constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  bool loader = false;
  final GlobalKey<FormState> signUpFormField = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: signUpFormField,
      child: Scaffold(
        body: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Stack(fit: StackFit.expand, children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2),
                BlendMode.darken,
              ),
              child: Image.asset(
                'assets/images/background_grocery.png',
                fit: BoxFit.fill,
              ),
            ),
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
                          DelayedDisplay(
                            delay: Duration(
                              milliseconds: 300,
                            ),
                            fadeIn: true,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 17, right: 17, bottom: 5, top: 7),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Sign Up with Email ID',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 18.sp),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      height: 7.h,
                                      child: TextFormField(
                                        controller: nameController,
                                        validator: (val) => val!.isEmpty
                                            ? "enter a valid username"
                                            : null,
                                        decoration: InputDecoration(
                                          hintText: 'NAME',
                                          labelText: 'NAME',
                                          prefixIcon: Image.asset(
                                            'assets/images/user_icon.png',
                                            scale: 3,
                                          ),
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.2,
                                              fontSize: 12,
                                              color: AppColors.black
                                                  .withOpacity(0.4)),
                                          labelStyle: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.2,
                                              fontSize: 12,
                                              color: AppColors.black
                                                  .withOpacity(0.4)),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    Colors.red.withOpacity(0.8),
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      height: 7.h,
                                      child: TextFormField(
                                        controller: emailController,
                                        validator: (val) =>
                                            val!.isEmpty || !val.contains("@")
                                                ? "enter a valid email"
                                                : null,
                                        decoration: InputDecoration(
                                          hintText: 'EMAIL ',
                                          labelText: 'EMAIL ID',
                                          prefixIcon: Image.asset(
                                            'assets/images/user_icon.png',
                                            scale: 3,
                                          ),
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.2,
                                              fontSize: 12,
                                              color: AppColors.black
                                                  .withOpacity(0.4)),
                                          labelStyle: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.2,
                                              fontSize: 12,
                                              color: AppColors.black
                                                  .withOpacity(0.4)),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    Colors.red.withOpacity(0.8),
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      height: 7.h,
                                      child: TextFormField(
                                        controller: passwordController,
                                        validator: (value) {
                                          // add your custom validation here.
                                          if (value!.isEmpty) {
                                            return 'Please enter valid password';
                                          }
                                          if (value.length < 6) {
                                            return 'Must be more than 6 charater';
                                          }
                                        },
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
                                              color: AppColors.black
                                                  .withOpacity(0.4)),
                                          labelStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.2,
                                              color: AppColors.black
                                                  .withOpacity(0.4)),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    Colors.red.withOpacity(0.8),
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      height: 7.h,
                                      child: TextFormField(
                                        controller: confirmPassword,
                                        validator: (val) {
                                          if (val!.isEmpty)
                                            return 'Please enter valid password';
                                          if (val != passwordController.text)
                                            return 'Password mismatch';
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'CONFIRM PASSWOR',
                                          labelText: 'CONFIRM PASSWORD',
                                          prefixIcon: Image.asset(
                                            'assets/images/lock_icon.png',
                                            scale: 3,
                                          ),
                                          hintStyle: TextStyle(
                                              letterSpacing: 1.2,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.black
                                                  .withOpacity(0.4)),
                                          labelStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.2,
                                              color: AppColors.black
                                                  .withOpacity(0.4)),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    Colors.red.withOpacity(0.8),
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      height: 7.h,
                                      child: TextFormField(
                                        controller: phoneNumberController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          // for below version 2 use this
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]')),
// for version 2 and greater youcan also use this
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        validator: (value) {
                                          // add your custom validation here.
                                          if (value!.isEmpty) {
                                            return 'Please enter valid password';
                                          }
                                          if (value.length < 6) {
                                            return 'Must be more than 6 charater';
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'PHONE NUMBER',
                                          labelText: 'PHONE NUMBER',
                                          prefixIcon: Image.asset(
                                            'assets/images/lock_icon.png',
                                            scale: 3,
                                          ),
                                          hintStyle: TextStyle(
                                              letterSpacing: 1.2,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.black
                                                  .withOpacity(0.4)),
                                          labelStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.2,
                                              color: AppColors.black
                                                  .withOpacity(0.4)),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    Colors.red.withOpacity(0.8),
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: 90.w,
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(13),
                                          child: loader == true
                                              ? Center(child: CommonLoader())
                                              : Text(
                                                  'Sign Up',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 19,
                                                    fontFamily: 'InterMedium',
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      height: 100.h < 670 ? 0 : 10,
                                    ),
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
      ),
    );
  }

}
