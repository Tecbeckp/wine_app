import 'package:bordeaux/screens/home_screen.dart';
import 'package:bordeaux/screens/sign_up_screen.dart';
import 'package:delayed_display/delayed_display.dart';

import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../common_widgets/colors.dart';
import '../common_widgets/common_loader.dart';
import '../common_widgets/page_transition.dart';
import '../helpers/constants.dart';
import '../models/user_model.dart';
import 'login_with_apple.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> signInFormField = GlobalKey();


  _divider() {
    return const SizedBox(height: 15);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'assets/images/image1.png',
              fit: BoxFit.cover,
            ),
          ),
          Form(
            key: signInFormField,
            child: Positioned(
                top: 90,
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
                          const SizedBox(height: 50),
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
                                          'Welcome back',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 18.sp),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Welcome back, Please enter your details.',
                                          style: TextStyle(

                                              fontSize: 8.sp),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(

                                      child: TextFormField(
                                        controller: emailController,
                                        validator: (val) =>
                                            val!.isEmpty || !val.contains("@")
                                                ? "enter a valid email"
                                                : null,
                                        decoration: InputDecoration(
                                          hintText: 'Name / Email / Phone',
                                          labelText: 'Apple ID',
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
                                    InkWell(
                                      onTap: () {
                                        PageTransition.fadeInNavigation(page: HomeScreen());
                                      },
                                      child: Container(
                                        width: 90.w,
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(13),
                                            child:

                                                 Text(
                                                    'Sign In',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17,
                                                      fontFamily: 'InterMedium',
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Forgot password?',
                                          style: TextStyle(
                                              color: AppColors.primary,
                                              fontSize: 10.sp,
                                              fontFamily: 'InterMedium'),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            PageTransition.fadeInNavigation(page: SignUpScreen());
                                          },
                                          child: Text(
                                            'Don’t have an account? Signup',
                                            style: TextStyle(
                                                color: AppColors.primary,
                                                fontSize: 10.sp,
                                                fontFamily: 'InterMedium'),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                       Container(
                                         width: 36.w,
                                         height: 0.5,
                                         color: Colors.black,
                                       ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5,right: 5),
                                          child: Text('Or',style: TextStyle(fontWeight: FontWeight.bold),),
                                        ),

                                        Container(
                                          width: 36.w,
                                          height: 0.5,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
SizedBox(
  height: 20,
),
                                    Row(mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                         decoration: BoxDecoration(

                                           borderRadius: BorderRadius.circular(5),
                                           border: Border.all(
                                             color: Colors.grey.withOpacity(0.3)
                                           )
                                         ),
                                         child: Padding(
                                           padding: const EdgeInsets.only(top: 12,bottom: 12,right: 7,left: 7),
                                           child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                             children: [
                                               Image.asset('assets/images/google.png',height: 17,width: 17,),
                                               SizedBox(
                                                 width: 5,
                                               ),
                                               Text('Log in with google',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 8.sp,),)


                                             ],
                                           ),
                                         ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(

                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.grey.withOpacity(0.3)
                                              )
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 12,bottom: 12,right: 7,left: 7),

                                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset('assets/images/facebook_login.png',height: 14,width: 17,),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text('Log in with facebook',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 8.sp,),)


                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
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
          ),
        ]),
      ),
    );
  }


}
