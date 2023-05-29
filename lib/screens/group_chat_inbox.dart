import 'dart:io';
import 'package:bordeaux/screens/profile_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../common_widgets/colors.dart';
import '../common_widgets/global_variables.dart';
import '../common_widgets/page_transition.dart';
import '../helpers/constants.dart';
import '../models/user_model.dart';
import 'package:image_picker/image_picker.dart';

class GroupChatInbox extends StatefulWidget {
  const GroupChatInbox({Key? key}) : super(key: key);

  @override
  State<GroupChatInbox> createState() => _GroupChatInboxState();
}

class _GroupChatInboxState extends State<GroupChatInbox> {
  final TextEditingController CommunityTextfieldController = TextEditingController();

  final int maxLines = 4;

  bool isExpanded = false;

  final picker = ImagePicker();
  late PickedFile pickedFile;
  Future _getImage() async {
    File imageFile = File(pickedFile.path);
  }
  addFileAlertDialog(BuildContext context) {
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
                                  "Please select media",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        )),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            Get.back();
                            pickedFile = (await picker.getImage(
                                source: ImageSource.gallery))!;
                            _getImage();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 1.5,

                                    color: AppColors.primary
                                ),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.asset(
                                'assets/images/gallery.png',
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 35,
                        ),
                        InkWell(
                          onTap: () async {
                            print('File picker');
                            FilePickerResult? result = await FilePicker.platform.pickFiles();

                            if (result != null) {
                              File file = File(result.files.single.path.toString());
                            }

                            else {
                              // User canceled the picker
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 1.5,
                                    color: AppColors.primary
                                ),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.asset(
                                'assets/images/file.png',
                                color: Colors.black,
                                width: 35,
                                height: 35,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          });
        });
  }
  List<GroupChatMessage> messages = [
    GroupChatMessage(
      sentBy: true,
      userData: userData,
      messageType: "image",
      dateTime: "18:06",
    ),

    GroupChatMessage(
      sentBy: true,
      userData: userData,
      messageType: "text",
      dateTime: "18:06",
    ),
    GroupChatMessage(
      sentBy: false,
      userData: userData,
      messageType: "text",
      dateTime: "18:06",
    ),
    GroupChatMessage(
      sentBy: true,
      userData: userData,
      messageType: "image",
      dateTime: "18:06",
    ),
    GroupChatMessage(
      sentBy: false,
      userData: userData,
      messageType: "image",
      dateTime: "18:06",
    ),
  ];
  List<String> name = [
    "sender",
    "reciever",
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:
      PreferredSize(
        preferredSize: const Size.fromHeight(65.0),
        child: AppBar(backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          titleSpacing: 10,
          automaticallyImplyLeading:false,

          leading: InkWell(splashColor: Colors.transparent,focusColor: Colors.transparent,
              onTap: (){
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios,size: 18,
                  color:
                  Colors.black
              )),
          title: Column(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Image.asset('assets/images/community.png',
                    height: 15,
                    width: 15,
                    color: Colors.black,
                  ),

                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    'The salad Makers',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,color: Colors.black,
                        fontSize: 14
                    ),
                  ),

                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text('21 Member(s)',style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF0F2038).withOpacity(0.5),
                  ),),
                ],
              )
            ],
          ),
          actions:  [
            Row(
              children: [
                InkWell(splashColor: Colors.transparent,focusColor: Colors.transparent,
                  onTap: (){},

                  child: Image.asset('assets/images/Info.png',height: 20,width: 20,
                    color: Colors.black,

                  ),),
                SizedBox(
                  width: 20,
                )
              ],
            )
          ],
        ),
      ),


      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(
                    left: 0, right: 0,  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      messages[index].sentBy == true?
                      sentByUser(messages[index]):

                      sentByOther(messages[index]),
                      // Align(
                      //   alignment:
                      //   (messages[index].sentBy == true
                      //       ? Alignment.topLeft
                      //       : Alignment.topRight
                      //   ),
                      //
                      //
                      //   child: sentByUser(messages[index]),
                      // ),
                      const SizedBox(
                        height: 5,
                      ),
                      // Align(
                      //   alignment:
                      //   (messages[index].sentBy == false
                      //       ? Alignment.topLeft
                      //       : Alignment.topRight),
                      //   child: Column(
                      //     children: [
                      //       SizedBox(
                      //         height: 5,
                      //       ),
                      //       Row(
                      //         children: [
                      //           Column(
                      //             children: [
                      //               Image.asset('assets/images/wade.png',height: 40,width: 40,
                      //               ),
                      //             ],
                      //           ),
                      //           SizedBox(
                      //             width: 10,
                      //           ),
                      //           Expanded(
                      //             child: Column(
                      //               children: [
                      //                 Row(
                      //                   children: [
                      //                     Text('Wade Warren',style: TextStyle(
                      //                         fontWeight: FontWeight.bold
                      //                     ),),
                      //                     SizedBox(
                      //                       width: 10,
                      //                     ),
                      //                     Padding(
                      //                       padding: const EdgeInsets.only(top: 3),
                      //                       child: Text('9:10 AM',style: TextStyle(
                      //                           fontSize: 12,color: AppColors.black.withOpacity(0.5),
                      //                           fontFamily: "InterMedium"
                      //                       )),
                      //                     )
                      //                   ],
                      //                 ),
                      //
                      //               ],
                      //             ),
                      //           ),
                      //           SizedBox(
                      //             width: 5,
                      //           ),
                      //         ],
                      //       ),
                      //
                      //       Container(
                      //         child:Padding(
                      //           padding: const EdgeInsets.only(left: 50),
                      //           child: Column(
                      //             children: [
                      //               Column(
                      //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                 children: [
                      //                   messages[index].messageType == 'text'?
                      //                   Text(
                      //                     'In purus in felis volutpat massa massa iaculis rhoncus pretium. Et amet nam nisl amet nunc a porttitor est sed.',
                      //                     maxLines: isExpanded ? null : maxLines,
                      //                     overflow: TextOverflow.ellipsis,
                      //                     style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      //                       fontWeight: FontWeight.normal,
                      //                       color: Colors.black,
                      //                       height: 2,
                      //                     ),
                      //                   )
                      //                       :
                      //                   messages[index].messageType == 'image'?
                      //                       Container(
                      //                         height: 20,
                      //                         width: 20,
                      //                         color: Colors.red,
                      //                       ):
                      //                   Container(
                      //                     height: 20,
                      //                     width: 20,
                      //                     color: Colors.black,
                      //                   )
                      //
                      //
                      //
                      //
                      //                 ],
                      //               ),
                      //               SizedBox(
                      //                 height: 12,
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   )
                      // ),
                    ],
                  ),
                );
              },
            ),
          ),




          SizedBox(
            height: 55,
            child: Row(
              children: [

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3,right: 3,top: 0,bottom: 5),
                    child: TextField(
                      //keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                      controller: CommunityTextfieldController,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.grey.withOpacity(0.1))),
                        contentPadding: EdgeInsets.only(top: 5),
                        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: InkWell(splashColor: Colors.transparent,focusColor: Colors.transparent,
                            onTap: (){
                            },
                            child: Container(
                                height: 10,
                                width: 40,
                                child: Icon(Icons.send,
                                  size: 23,
                                  color: AppColors.black,
                                )
                            ),
                          ),
                        ),
                        suffixIconConstraints: BoxConstraints(maxHeight: 20,minHeight: 20,),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 7),
                            child: InkWell(
                              onTap: (){
                                addFileAlertDialog(context);
                              },
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.grey.withOpacity(0.1)
                                ),
                                child: Center(child: Icon(Icons.add,size: 18,)
                                  // Icon(Icons.add,size: 18,
                                  //   color: Colors.black,
                                  // )

                                ),
                              ),
                            ),
                          ),
                        ),
                        prefixIconConstraints: BoxConstraints(maxHeight: 25,minHeight: 25,),
                        // label: TeSxt(sendTipController.text),
                        filled:true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.withOpacity(0.1))
                        ),
                        enabledBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                          // width: 0.0 produces a thin "hairline" border
                          borderSide: const BorderSide(color: Colors.grey, width: 0.0,),
                        ),
                        hintText: 'Tap to type...',
                        hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.normal,
                          color:  AppColors.black.withOpacity(0.3),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {

                        });
                      },
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
  sentByOther(GroupChatMessage message){
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: 80.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),


        ),
        padding: const EdgeInsets.only(left: 16,right: 16,),
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CircleAvatar(
                //   backgroundColor: Colors.transparent,
                //   radius: 23,
                //   backgroundImage:  AssetImage(message.userData.imageUrl,
                //   ),
                // ),
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 19,
                  backgroundImage:  AssetImage('assets/images/image1.png',
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Text(
                              // message.userData.displayName,
                              'Fahad',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),
            Container(
              child:Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        message.messageType == 'text'?
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Text(
                            'In purus in felis volutpat massa massa iaculis rhoncus pretium. Et amet nam nisl amet nunc a porttitor est sed.',
                            maxLines: isExpanded ? null : maxLines,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              height: 1.5,
                            ),
                          ),
                        )
                            :
                        message.messageType == 'image'?
                        Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                                alignment:Alignment.topLeft,
                                child: Image.asset('assets/images/image2.png',height: 20.h,width: 60.w,))
                          ],
                        ):
                        Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              color: Colors.black,
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: Text(
                                  // message.dateTime,
                                    '11:12',
                                    style: TextStyle(
                                        fontSize: 12,color: AppColors.black.withOpacity(0.5),
                                        fontFamily: "InterMedium"
                                    )),
                              )
                            ],
                          ),
                        ),

                      ],
                    ),
                    SizedBox(
                      height: 12,
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

  sentByUser(GroupChatMessage message){
    return Align(
      alignment:Alignment.topRight,
      child: Container(
        width: 80.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),


        ),
        padding: const EdgeInsets.only(left: 16,right: 16,),
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // CircleAvatar(
                //   backgroundColor: Colors.transparent,
                //   radius: 23,
                //   backgroundImage:  AssetImage(message.userData.imageUrl,
                //   ),
                // ),
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 15,
                  backgroundImage:  AssetImage('assets/images/image10.png',
                  ),
                ),

                // SizedBox(
                //   width: 8,
                // ),
                // Expanded(
                //   child: Column(
                //     children: [
                //
                //       Padding(
                //         padding: const EdgeInsets.only(top: 10),
                //         child: Row(
                //           children: [
                //             Text(
                //               // message.userData.displayName,
                //               'Fahad',
                //               style: TextStyle(
                //                   fontSize: 15,
                //                   fontWeight: FontWeight.bold
                //               ),),
                //             SizedBox(
                //               width: 20,
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.only(top: 3),
                //               child: Text(
                //                 // message.dateTime,
                //                   '11:12',
                //                   style: TextStyle(
                //                       fontSize: 12,color: AppColors.black.withOpacity(0.5),
                //                       fontFamily: "InterMedium"
                //                   )),
                //             )
                //           ],
                //         ),
                //       ),
                //
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   width: 5,
                // ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      message.messageType == 'text'?
                      Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text(
                          'In purus in felis volutpat massa massa iaculis rhoncus pretium. Et amet nam nisl amet nunc a porttitor est sed.',
                          maxLines: isExpanded ? null : maxLines,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            height: 1.5,
                          ),
                        ),
                      )
                          :
                      message.messageType == 'image'?
                      Row(mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                              alignment:Alignment.topLeft,
                              child: Image.asset('assets/images/image3.png',height: 20.h,width: 60.w,))
                        ],
                      ):
                      Row(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            color: Colors.black,
                          ),
                        ],
                      ),

                      Row(mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10,top: 3),
                            child: Text(
                              // message.dateTime,
                                '11:12',
                                style: TextStyle(
                                    fontSize: 12,color: AppColors.black.withOpacity(0.5),
                                    fontFamily: "InterMedium"
                                )),
                          )
                        ],
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
}


class GroupChatMessage {
  UserModel userData;
  bool sentBy;
  String messageType;
  String dateTime;
  GroupChatMessage(
      {
        required this.userData,
        required this.sentBy,
        required this.messageType,
        required this.dateTime,
      });
}

