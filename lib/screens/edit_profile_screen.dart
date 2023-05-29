import 'dart:io';

import 'package:bordeaux/screens/profile_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as path;
import 'package:sizer/sizer.dart';

import '../common_widgets/colors.dart';
import '../common_widgets/common_loader.dart';
import '../common_widgets/global_variables.dart';
import '../common_widgets/page_transition.dart';
import '../common_widgets/texfield_input_decorations.dart';
import '../helpers/constants.dart';
import '../models/user_model.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController confirmPassword = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();

  final TextEditingController infoController = TextEditingController();

  final TextEditingController imageController = TextEditingController();
  final GlobalKey<FormState> editKey = GlobalKey();

  SimpleAlertDialog(BuildContext context) {
    // set up the AlertDialog
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              elevation: 0,
              contentPadding: EdgeInsets.zero,

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              // title: Text("Notice"),
              // content: Text("Launching this missile will destroy the entire universe. Is this what you intended to do?"),
              actions: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: 5.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Please select correct option",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            Get.back();

                          },
                          child: Container(
                            child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Image.asset(
                                  'assets/images/cam.png',
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        InkWell(
                          onTap: () async {
                            Get.back();

                          },
                          child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Image.asset(
                                'assets/images/gallery.png',
                              )),
                        )
                      ],
                    )
                  ],
                ),
              ],
            );
          });
        });
  }


  var selectedimage;
  bool isLoading = false;
  late PickedFile _pickedFile;

  File? myFile = File(imagepath.value);
  late PickedFile pickedFile;
  String? imageUrl;
  File? imageFile;
  final picker = ImagePicker();
  bool processingStatus = false;


  getData() {
    imageUrl = userData.imageUrl;
    nameController.text = userData.displayName;
    emailController.text = userData.email;
    phoneNumberController.text = userData.phoneNumber;
    addressController.text = userData.address ?? "";
    infoController.text = userData.bio ?? "";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: editKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, 160),
                    painter: CurvedPainterTop(),
                  ),
                  Positioned(
                      top: 40,
                      left: 20,
                      child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          ))),
                  SizedBox(
                    height: 105,
                    width: 105,
                    child: (processingStatus)
                        ? Container(
                            height: 150,
                            width: 100,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Processing Image'),
                                  CommonLoader(),
                                ],
                              ),
                            ),
                          )
                        : Stack(children: [
                            Positioned(
                              bottom: 0,
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: imageFile != null
                                      ? DecorationImage(
                                          fit: BoxFit.contain,
                                          image: FileImage(imageFile!),
                                        )
                                      : (userData.imageUrl != "" &&
                                              userData.imageUrl != null)
                                          ? DecorationImage(
                                              fit: BoxFit.contain,
                                              image: NetworkImage(
                                                  userData.imageUrl),
                                            )
                                          : const DecorationImage(
                                              fit: BoxFit.contain,
                                              image: AssetImage(
                                                  'assets/images/profile.png')),
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      SimpleAlertDialog(context);
                                    },
                                    child:
                                        Image.asset('assets/images/camera.png'),
                                  ),
                                )),
                          ]),
                  )
                ],
              ),
              CommonSizeBox(),
              SizedBox(
                // height: 50,
                width: 90.w,
                child: CommonTextfield(
                  hintText: 'Name',
                  validator: (val) =>
                      val!.isEmpty ? "enter a valid username" : null,
                  myController: nameController,
                  image: Image.asset(
                    'assets/images/user_icon.png',
                    scale: 3,
                  ),
                  labelText: "Name",
                ),
              ),
              CommonSizeBox(),
              SizedBox(
                // height: 50,
                width: 90.w,
                child: CommonTextfield(
                  hintText: 'EMAIL',
                  validator: (val) =>
                      val!.isEmpty ? "enter a valid Email" : null,
                  myController: emailController,
                  image: Image.asset(
                    'assets/images/email_icon.png',
                    scale: 2,
                  ),
                  labelText: "EMAIL",
                ),
              ),
              CommonSizeBox(),
              // SizedBox(height: 50,
              //   width: 90.w,
              //
              //   child: CommonTextfield(
              //     hintText: 'PASSWORD',
              //     validator: (val) => val!.isEmpty
              //         ? "enter a valid Password"
              //         : null,myController: passwordController,image: Image.asset('assets/images/lock_icon.png',scale: 3,),labelText: "PASSWORD",
              //
              //   ),
              //
              // ),
              // CommonSizeBox(),
              // SizedBox(height: 50,
              //   width: 90.w,
              //
              //   child: CommonTextfield(
              //     hintText: 'CONFIRM PASSWORD',
              //     validator: (val) => val!.isEmpty
              //         ? "enter a valid Email"
              //         : null,myController: confirmPassword,image: Image.asset('assets/images/lock_icon.png',scale: 3,),labelText: "CONFIRM PASSWORD",
              //
              //   ),
              //
              // ),
              // CommonSizeBox(),
              SizedBox(
                // height: 50,
                width: 90.w,
                child: CommonTextfield(
                  numKeypad: true,
                  hintText: 'PHONE NO.',
                  validator: (val) =>
                      val!.isEmpty ? "enter a valid Number" : null,
                  myController: phoneNumberController,
                  image: Image.asset(
                    'assets/images/phone.png',
                    scale: 3,
                  ),
                  labelText: "PHONE NO.",
                ),
              ),
              CommonSizeBox(),
              SizedBox(
                // height: 50,
                width: 90.w,
                child: CommonTextfield(
                  hintText: 'ADDRESS',
                  validator: (val) =>
                      val!.isEmpty ? "enter a valid Address" : null,
                  myController: addressController,
                  image: Image.asset(
                    'assets/images/location_icon.png',
                    scale: 3,
                    color: Colors.black,
                  ),
                  labelText: "ADDRESS",
                ),
              ),
              CommonSizeBox(),
              SizedBox(
                // height: 50,
                width: 90.w,
                child: CommonTextfield(
                  hintText: 'INFO',
                  validator: (val) =>
                      val!.isEmpty ? "enter a valid Address" : null,
                  myController: infoController,
                  image: Image.asset(
                    'assets/images/Info.png',
                    scale: 2,
                    color: Colors.black,
                  ),
                  labelText: "INFO",
                ),
              ),
              CommonSizeBox(),
              SizedBox(
                width: 100.w,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                            color: AppColors.primary,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: isLoading
                                ? const Center(child: CommonLoader())
                                : Text(
                                    'Update',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                          )

                          // Icon(Icons.check,size: 24,color: Colors.white,),
                          ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // bottomNavigationBar: Stack(
        //   children: [
        //
        //     CustomPaint(
        //     size: Size(100.w,190),
        //     painter: CurvedPainterBottom(),
        //   ),
        //
        //   Positioned(
        //     top: 20,
        //     child: SizedBox(
        //       width: 100.w,
        //       child: Padding(
        //         padding: const EdgeInsets.only(left: 20,right: 20),
        //         child: Row(mainAxisAlignment: MainAxisAlignment.end,
        //           children: [
        //
        //             Container(
        //
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.all(Radius.circular(10)),
        //                 color: AppColors.primary,
        //               ),
        //               child: Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Text('Update',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),
        //               )
        //
        //               // Icon(Icons.check,size: 24,color: Colors.white,),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        //   ]
        // ),
      ),
    );
  }

  Widget CommonSizeBox() {
    return SizedBox(
      height: 20,
    );
  }

}

class PickedFile {
}

class CurvedPainterBottom extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black.withOpacity(0.9)
      ..strokeWidth = 15;

    var path = Path();

    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.7,
        size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9,
        size.width * 1.0, size.height * 0.8);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CurvedPainterTop extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black.withOpacity(0.9)
      ..strokeWidth = 15;

    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);

    path.lineTo(size.width, size.height * 0.35);
    path.lineTo(size.width * 0.5, size.height);
    path.lineTo(0, size.height * 0.65);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CurvedPainterTop oldDelegate) {
    return false;
  }
}
