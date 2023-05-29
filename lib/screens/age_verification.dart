import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../common_widgets/colors.dart';
import '../common_widgets/page_transition.dart';


class AgeVerification extends StatefulWidget {
  const AgeVerification({Key? key}) : super(key: key);

  @override
  State<AgeVerification> createState() => _AgeVerificationState();
}
final TextEditingController ageVerificationController = TextEditingController();
TextEditingController dateinput = TextEditingController();

final GlobalKey<FormState> ageVerificationFormFieldKey = GlobalKey();

class _AgeVerificationState extends State<AgeVerification> {
  @override
  void initState() {
    ageVerificationController.text = ""; //set the initial value of text field
    super.initState();
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
            key: ageVerificationFormFieldKey,
            child: Positioned(
                top: 100,
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
                          const SizedBox(height: 70),
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
                                          'Age Verification',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 18.sp),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'You must be 21 years old to access this website.\nPlease verify your age.',textAlign: TextAlign.center,
                                          style: TextStyle(

                                              fontSize: 9.sp),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(

                                      child: TextFormField(
                                        readOnly: true,  //set it true, so that user will not able to edit text
                                        onTap: () async {
                                          DateTime? pickedDate = await showDatePicker(
                                              context: context, initialDate: DateTime.now(),
                                              builder: (BuildContext context, Widget? child) {
                                                return Theme(
                                                  data: Theme.of(context).copyWith(
                                                    colorScheme: ColorScheme.light(
                                                      primary: AppColors.primary, // header background color
                                                      onPrimary: Colors.white, // header text color
                                                      onSurface: Colors.black, // body text color
                                                    ),
                                                    textButtonTheme: TextButtonThemeData(
                                                      style: TextButton.styleFrom(
                                                        foregroundColor: Colors.red, // button text color
                                                      ),
                                                    ),
                                                  ),
                                                  child: child!,
                                                );
                                              },
                                              firstDate: DateTime(1900), //DateTime.now() - not to allow to choose before today.
                                              lastDate: DateTime(2101)
                                          );

                                          if(pickedDate != null ){
                                            print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                            print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                            //you can implement different kind of Date Format here according to your requirement

                                            setState(() {
                                              ageVerificationController.text = formattedDate; //set output date to TextField value.
                                            });
                                          }else{
                                            print("Date is not selected");
                                          }
                                        },
                                        controller: ageVerificationController,
                                        validator: (val) =>
                                        val!.isEmpty || !val.contains("@")
                                            ? "enter a valid email"
                                            : null,
                                        decoration: InputDecoration(
                                          hintText: 'DD / MM / YY',
                                          labelText: 'DATE OF BIRTH',
                                          prefixIcon: Icon(Icons.calendar_month,color: Colors.grey,),
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
                                      height: 40,
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
                                          child:

                                          Text(
                                            'Submit',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontFamily: 'InterMedium',
                                            ),
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
                                        color: AppColors.primary.withOpacity(0.3),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(13),
                                          child:

                                          Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color: AppColors.primary,
                                              fontSize: 17,
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
          ),
        ]),
      ),
    );
  }
}
