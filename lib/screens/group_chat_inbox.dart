import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common_widgets/colors.dart';
import '../helpers/constants.dart';
import '../models/user_model.dart';

class GroupChatInbox extends StatefulWidget {
  final groupChatId;
  final membersCount;
  final title;

  const GroupChatInbox(
      {Key? key,
      required this.groupChatId,
      required this.membersCount,
      required this.title})
      : super(key: key);

  @override
  State<GroupChatInbox> createState() => _GroupChatInboxState();
}

class _GroupChatInboxState extends State<GroupChatInbox> {
  final TextEditingController messageTextField = TextEditingController();
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  final int maxLines = 4;

  bool isExpanded = false;

  String imageUrl = "";
  XFile? pickedImage;
  File? imageFile;
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
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Please select media",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            Get.back();
                            getImage();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.5, color: AppColors.primary),
                                borderRadius: BorderRadius.circular(15)),
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
                        const SizedBox(
                          width: 35,
                        ),
                        InkWell(
                          onTap: () async {
                            Get.back();
                            getFile();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.5, color: AppColors.primary),
                                borderRadius: BorderRadius.circular(15)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65.0),
        child: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          titleSpacing: 10,
          automaticallyImplyLeading: false,
          leading: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back_ios,
                  size: 18, color: Colors.black)),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/community.png',
                    height: 15,
                    width: 15,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    widget.title.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    '${widget.membersCount} Member(s)',
                    style: TextStyle(
                      fontSize: 13,
                      color: const Color(0xFF0F2038).withOpacity(0.5),
                    ),
                  ),
                ],
              )
            ],
          ),
          actions: [
            Row(
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  child: Image.asset(
                    'assets/images/Info.png',
                    height: 20,
                    width: 20,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
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
            child: buildListMessage(),
          ),
          SizedBox(
            height: 55,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 3, right: 3, top: 0, bottom: 5),
                    child: TextField(
                      //keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                      controller: messageTextField,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.1))),
                        contentPadding: const EdgeInsets.only(top: 5),
                        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            onTap: () async {
                              onSendMessage(messageTextField.text, "text", "",
                                  "", "", 0, "", "");
                              messageTextField.clear();
                            },
                            child: SizedBox(
                              height: 10,
                              width: 40,
                              child: Image.asset(
                                'assets/images/send_inbox.png',
                                scale: 3,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        suffixIconConstraints: const BoxConstraints(
                          maxHeight: 20,
                          minHeight: 20,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 7),
                            child: InkWell(
                              onTap: () {
                                addFileAlertDialog(context);
                              },
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.grey.withOpacity(0.1)),
                                child: const Center(
                                    child: Icon(
                                  Icons.add,
                                  size: 18,
                                )
                                    // Icon(Icons.add,size: 18,
                                    //   color: Colors.black,
                                    // )

                                    ),
                              ),
                            ),
                          ),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          maxHeight: 25,
                          minHeight: 25,
                        ),
                        // label: TeSxt(sendTipController.text),
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.1))),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          // width: 0.0 produces a thin "hairline" border
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 0.0,
                          ),
                        ),
                        hintText: '|Message # General',
                        hintStyle:
                            Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.black.withOpacity(0.3),
                                ),
                      ),
                      onChanged: (value) {
                        setState(() {});
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

  Widget buildListMessage() {
    return widget.groupChatId.isNotEmpty
        ? StreamBuilder<QuerySnapshot>(
            stream: _fireStore
                .collection('groups')
                .doc(widget.groupChatId)
                .collection('chats')
                .orderBy('time', descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  itemCount: snapshot.data!.docs.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> chatMap = snapshot.data!.docs[index]
                        .data() as Map<String, dynamic>;

                    return buildItem(chatMap);
                  },
                );
              } else {
                return Container();
              }
            },
          )
        : const Center(
            child: CircularProgressIndicator(
              color: Colors.yellow,
            ),
          );
  }

  Widget buildItem(Map<String, dynamic> chatMap) {
    if (chatMap['sendBy'] == NameConst.value) {
      // Right (my message)
      return Align(
        alignment: Alignment.topRight,
        child: Container(
          width: 60.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 15,
                    backgroundImage: AssetImage(
                      'assets/images/image10.jpg',
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        chatMap['type'] == "text"
                            ? Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: Text(
                                  chatMap['message'],
                                  // maxLines: isExpanded ? null : maxLines,
                                  // overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                        height: 1.5,
                                      ),
                                ),
                              )
                            : chatMap['type'] == 'document'
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Image.network(
                                            chatMap['message'],
                                            height: 20.h,
                                            width: 50.w,
                                          ))
                                    ],
                                  )
                                : Container(
                                    width: 60.w,
                                    height: 54,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.7),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(5),
                                        )),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/file.png',
                                                color: Colors.black,
                                                width: 35,
                                                height: 35,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  // Get.to(DocumentView(documentUrl: message.attachment));
                                                  if (!await launchUrl(
                                                      Uri.parse(
                                                          chatMap['message']),
                                                      mode: LaunchMode
                                                          .inAppWebView)) {
                                                    throw Exception(
                                                        'Could not launch ${chatMap['message']}');
                                                  }
                                                },
                                                child: SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                    chatMap['description'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10, top: 3),
                              child: Text(
                                  chatMap['time'] == null
                                      ? ""
                                      : DateFormat('d MMM yy hh:mm:a').format(
                                          DateTime.parse(chatMap['time']
                                              .toDate()
                                              .toString())),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.black.withOpacity(0.5),
                                      fontFamily: "InterMedium")),
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
      // return Align(
      //   alignment: Alignment.topRight,
      //   child: SizedBox(
      //     width: 75.w,
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.end,
      //       children: <Widget>[
      //         chatMap['type'] == "text"
      //             // Text
      //             ? Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Align(
      //                     alignment: Alignment.topRight,
      //                     child: Row(crossAxisAlignment: CrossAxisAlignment.start,
      //
      //                       children: [
      //
      //                         Container(
      //                           decoration: BoxDecoration(
      //                             // color: Colors.green,
      //                             borderRadius: BorderRadius.circular(10),
      //                           ),
      //                           padding: const EdgeInsets.only(
      //                             left: 16,
      //                             right: 16,
      //                           ),
      //                           child: Column(
      //                             crossAxisAlignment:
      //                             CrossAxisAlignment.start,
      //
      //                             children: [
      //                               const SizedBox(
      //                                 height: 5,
      //                               ),
      //                               Padding(
      //                                 padding: const EdgeInsets.only(top: 10),
      //                                 child: Row(
      //                                   children: [
      //
      //                                     const SizedBox(
      //                                       width: 20,
      //                                     ),
      //
      //                                     Padding(
      //                                       padding:
      //                                           const EdgeInsets.only(top: 3),
      //                                       child: Text(
      //                                           // message.dateTime,
      //                                           chatMap['time'] == null ? "" : "",
      //                                           style: TextStyle(
      //                                               fontSize: 12,
      //                                               color: AppColors.black
      //                                                   .withOpacity(0.5),
      //                                               fontFamily: "InterMedium")),
      //                                     )
      //                                   ],
      //                                 ),
      //                               ),
      //
      //                               Container(
      //                                 width: 150,
      //                                 child: Text(
      //                            'er',
      //                                   maxLines: isExpanded ? null : maxLines,
      //                                   overflow: TextOverflow.ellipsis,
      //                                   style: Theme.of(context).textTheme.titleSmall?.copyWith(
      //                                     fontWeight: FontWeight.normal,
      //                                     color: Colors.black,
      //                                     height: 1.5,
      //                                   ),
      //                                 ),
      //                               ),
      //                              // Text(
      //                              //      chatMap['message'],textAlign: TextAlign.start,
      //                              //
      //                              //      maxLines: isExpanded ? null : maxLines,
      //                              //
      //                              //      style: Theme.of(context)
      //                              //          .textTheme
      //                              //          .titleSmall
      //                              //          ?.copyWith(
      //                              //            fontWeight: FontWeight.normal,
      //                              //            color: Colors.black,
      //                              //            height: 1.5,
      //                              //          ),
      //                              //
      //                              //  ),
      //                               const SizedBox(
      //                                 height: 12,
      //                               ),
      //                             ],
      //                           ),
      //                         ),
      //                         const SizedBox(
      //                           width: 5,
      //                         ),
      //
      //                         const Padding(
      //                           padding: EdgeInsets.only(top: 0),
      //                           child: CircleAvatar(
      //                             backgroundColor: Colors.transparent,
      //                             radius: 15,
      //                             backgroundImage:
      //                                 AssetImage('assets/images/image3.jpg'),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                   const SizedBox(
      //                     height: 10,
      //                   ),
      //
      //                   // Container(
      //                   //   padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      //                   //   width: 50.w,
      //                   //   decoration: const BoxDecoration(
      //                   //     // color: Colors.black,
      //                   //     color: Colors.yellow,
      //                   //     borderRadius: BorderRadius.only(
      //                   //       topRight: Radius.circular(18),
      //                   //       topLeft: Radius.circular(18),
      //                   //       bottomLeft: Radius.circular(18),
      //                   //     ),
      //                   //   ),
      //                   //   margin:
      //                   //   const EdgeInsets.only(bottom: 10, right: 10),
      //                   //
      //                   //   child: Column(
      //                   //     crossAxisAlignment: CrossAxisAlignment.start,
      //                   //     children: [
      //                   //       Text(
      //                   //         '${chatMap['sendBy']}'.toUpperCase(),
      //                   //         style: GoogleFonts.montserrat(
      //                   //             fontSize: 12.sp,
      //                   //             color: Colors.white,
      //                   //             fontWeight: FontWeight.w500),
      //                   //       ),
      //                   //       SizedBox(
      //                   //         height: 1.h,
      //                   //       ),
      //                   //       Text(
      //                   //         chatMap['message'],
      //                   //         style: GoogleFonts.montserrat(
      //                   //             fontSize: 12.sp,
      //                   //             color: Colors.white,
      //                   //             fontWeight: FontWeight.w400),
      //                   //       ),
      //                   //     ],
      //                   //   ),
      //                   // ),
      //                   // Padding(
      //                   //   padding: EdgeInsets.only(right: 5.w),
      //                   //   child: Text(
      //                   //     chatMap['time'] == null ? "" : "",
      //                   //     // : '${DateFormat('d MMM yy hh:mm:a').format(DateTime.parse(chatMap['time'].toDate().toString()))}',
      //                   //     style: GoogleFonts.montserrat(
      //                   //         fontSize: 9.sp,
      //                   //         color: Colors.black26,
      //                   //         fontWeight: FontWeight.w500),
      //                   //     // '${}',
      //                   //   ),
      //                   // ),
      //                 ],
      //               )
      //             : chatMap['type'] == "image"
      //                 ? Row(
      //                     mainAxisAlignment: MainAxisAlignment.end,
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Align(
      //                           alignment: Alignment.topLeft,
      //                           child: Image.asset(
      //                             'assets/images/image3.jpg',
      //                             height: 20.h,
      //                             width: 60.w,
      //                           ))
      //                     ],
      //                   )
      //                 : Row(
      //                     mainAxisAlignment: MainAxisAlignment.end,
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Align(
      //                           alignment: Alignment.topLeft,
      //                           child: Image.asset(
      //                             'assets/images/image3.jpg',
      //                             height: 20.h,
      //                             width: 60.w,
      //                           ))
      //                     ],
      //                   )
      //       ],
      //     ),
      //   ),
      // );
    } else {
      // Left (peer message).......................

      return Align(
        alignment: Alignment.topLeft,
        child: Container(
          width: 80.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 19,
                    backgroundImage: AssetImage(
                      'assets/images/image1.jpg',
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
                                chatMap['sendBy'],
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          chatMap['type'] == "text"
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Text(
                                    chatMap['message'],
                                    // maxLines: isExpanded ? null : maxLines,

                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          height: 1.5,
                                        ),
                                  ),
                                )
                              : chatMap['type'] == 'document'
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Image.network(
                                              chatMap['message'],
                                              height: 20.h,
                                              width: 60.w,
                                            ))
                                      ],
                                    )
                                  : Container(
                                      width: 60.w,
                                      height: 54,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.7),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(5),
                                          )),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/file.png',
                                                  color: Colors.black,
                                                  width: 35,
                                                  height: 35,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    // Get.to(DocumentView(documentUrl: message.attachment));
                                                    if (!await launchUrl(
                                                        Uri.parse(
                                                            chatMap['message']),
                                                        mode: LaunchMode
                                                            .inAppWebView)) {
                                                      throw Exception(
                                                          'Could not launch ${chatMap['message']}');
                                                    }
                                                  },
                                                  child: SizedBox(
                                                    width: 100,
                                                    child: Text(
                                                      chatMap['description'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color: Colors.blue),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                          Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 3),
                                  child: Text(
                                      // message.dateTime,
                                      chatMap['time'] == null ? "" : "",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              AppColors.black.withOpacity(0.5),
                                          fontFamily: "InterMedium")),
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

      // return Container(
      //   margin: const EdgeInsets.only(bottom: 10),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: <Widget>[
      //       const SizedBox(
      //         height: 5,
      //       ),
      //       Row(
      //         children: <Widget>[
      //           chatMap['type'] == "text"
      //               ?
      //           Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Column(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       mainAxisAlignment: MainAxisAlignment.start,
      //                       children: [
      //                         Row(mainAxisAlignment: MainAxisAlignment.start,
      //                           crossAxisAlignment: CrossAxisAlignment.start,
      //                           children: [
      //                             const Padding(
      //                               padding:
      //                                   EdgeInsets.only(top: 10),
      //                               child: CircleAvatar(
      //                                 backgroundColor: Colors.transparent,
      //                                 radius: 19,
      //                                 backgroundImage: AssetImage(
      //                                   'assets/images/image1.jpg',
      //                                 ),
      //                               ),
      //                             ),
      //                             const SizedBox(
      //                               width: 5,
      //                             ),
      //                             Container(
      //                               padding: const EdgeInsets.fromLTRB(
      //                                   15, 10, 15, 10),
      //                               width: 65.w,
      //                               decoration: BoxDecoration(
      //                                 borderRadius: BorderRadius.circular(10),
      //                               ),
      //                               margin: const EdgeInsets.only(
      //                                   bottom: 10, right: 10),
      //                               child: Column(
      //                                 crossAxisAlignment:
      //                                     CrossAxisAlignment.start,
      //                                 children: [
      //                                   Row(
      //                                     children: [
      //                                       Text(
      //                                         '${chatMap['sendBy']}'
      //                                             .toUpperCase(),
      //                                         style: const TextStyle(
      //                                             fontSize: 15,
      //                                             fontWeight:
      //                                                 FontWeight.bold),
      //                                       ),
      //                                       const SizedBox(
      //                                         width: 20,
      //                                       ),
      //                                       Padding(
      //                                         padding: const EdgeInsets.only(
      //                                             top: 3),
      //                                         child: Text(
      //                                             // message.dateTime,
      //                                             chatMap['time'] == null
      //                                                 ? ""
      //                                                 : "",
      //                                             style: TextStyle(
      //                                                 fontSize: 12,
      //                                                 color: AppColors.black
      //                                                     .withOpacity(0.5),
      //                                                 fontFamily:
      //                                                     "InterMedium")),
      //                                       )
      //                                     ],
      //                                   ),
      //
      //                                   Container(
      //                                     // width: 40.w,
      //                                     child: Text(chatMap['message'],
      //                                         maxLines:
      //                                             isExpanded ? null : maxLines,
      //                                         overflow: TextOverflow.ellipsis,
      //                                         style: Theme.of(context)
      //                                             .textTheme
      //                                             .titleSmall
      //                                             ?.copyWith(
      //                                               fontWeight:
      //                                                   FontWeight.normal,
      //                                               color: Colors.black,
      //                                               height: 1.5,
      //                                             )),
      //                                   ),
      //                                 ],
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       ],
      //                     ),
      //                     // Text(
      //                     //   '${chatMap['timestamp']}',
      //                     //   // '${DateFormat("yMd").format(DateFormat("yyyy-MM-dd").parse(chatMap['timestamp']))}',
      //                     //   style: GoogleFonts.montserrat(
      //                     //       fontSize: 12.sp,
      //                     //       color: Colors.black,
      //                     //       fontWeight: FontWeight.w500),
      //                     // ),
      //                   ],
      //                 )
      //               : chatMap['type'] == "image"
      //                   ? Row(
      //                       mainAxisAlignment: MainAxisAlignment.end,
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Align(
      //                             alignment: Alignment.topLeft,
      //                             child: Image.asset(
      //                               'assets/images/image3.jpg',
      //                               height: 20.h,
      //                               width: 60.w,
      //                             ))
      //                       ],
      //                     )
      //                   : Row(
      //                       mainAxisAlignment: MainAxisAlignment.end,
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Align(
      //                             alignment: Alignment.topLeft,
      //                             child: Image.asset(
      //                               'assets/images/image3.jpg',
      //                               height: 20.h,
      //                               width: 60.w,
      //                             ))
      //                       ],
      //                     )
      //           //     : Row(
      //           //   mainAxisAlignment:
      //           //   MainAxisAlignment.center,
      //           //   children: [
      //           //     Padding(
      //           //       padding:
      //           //       EdgeInsets.only(bottom: 1.h),
      //           //       child: Column(
      //           //         crossAxisAlignment:
      //           //         CrossAxisAlignment.start,
      //           //         children: [
      //           //           Container(
      //           //             width: 65.w,
      //           //             padding:
      //           //             const EdgeInsets.all(15),
      //           //             decoration:
      //           //             const BoxDecoration(
      //           //               color: Colors.black,
      //           //               // border: Border.all(
      //           //               //     color: Colors.black),
      //           //               borderRadius:
      //           //               BorderRadius.only(
      //           //                 topRight:
      //           //                 Radius.circular(18),
      //           //                 topLeft:
      //           //                 Radius.circular(18),
      //           //                 bottomRight:
      //           //                 Radius.circular(18),
      //           //               ),
      //           //             ),
      //           //             margin: const EdgeInsets.only(
      //           //                 bottom: 10, right: 10),
      //           //             child: Row(
      //           //               children: [
      //           //                 Icon(
      //           //                   Icons.delete,
      //           //                   color: Colors.black,
      //           //                   size: 30.sp,
      //           //                 ),
      //           //                 SizedBox(
      //           //                   width: 2.h,
      //           //                 ),
      //           //                 Column(
      //           //                   crossAxisAlignment:
      //           //                   CrossAxisAlignment
      //           //                       .start,
      //           //                   children: [
      //           //                     Text(
      //           //                       '${chatMap['sendBy']}'
      //           //                           .toUpperCase(),
      //           //                       // chatMap['sendBy'],
      //           //                       style: GoogleFonts
      //           //                           .montserrat(
      //           //                           fontSize:
      //           //                           12.sp,
      //           //                           color: Colors
      //           //                               .black,
      //           //                           fontWeight:
      //           //                           FontWeight
      //           //                               .w500),
      //           //                     ),
      //           //                     SizedBox(
      //           //                       height: 1.h,
      //           //                     ),
      //           //                     Text(
      //           //                       '\$${chatMap['paymentDues']}',
      //           //                       style: GoogleFonts
      //           //                           .montserrat(
      //           //                           fontSize:
      //           //                           12.sp,
      //           //                           color: Colors
      //           //                               .black,
      //           //                           fontWeight:
      //           //                           FontWeight
      //           //                               .w600),
      //           //                     ),
      //           //                     SizedBox(
      //           //                       height: .5.h,
      //           //                     ),
      //           //                     Text(
      //           //                       chatMap['message'],
      //           //                       style: GoogleFonts
      //           //                           .montserrat(
      //           //                           fontSize:
      //           //                           11.sp,
      //           //                           color: Colors
      //           //                               .black,
      //           //                           fontWeight:
      //           //                           FontWeight
      //           //                               .w400),
      //           //                     ),
      //           //                     SizedBox(
      //           //                       height: 1.h,
      //           //                     ),
      //           //                   ],
      //           //                 ),
      //           //               ],
      //           //             ),
      //           //           ),
      //           //           Padding(
      //           //             padding: EdgeInsets.only(
      //           //                 left: 2.w),
      //           //             child: Text(
      //           //               chatMap['time'] == null
      //           //                   ? ""
      //           //                   : "",
      //           //               //  : '${DateFormat('d MMM yy hh:mm:a').format(DateTime.parse(chatMap['time'].toDate().toString()))}',
      //           //               style:
      //           //               GoogleFonts.montserrat(
      //           //                   fontSize: 9.sp,
      //           //                   color:
      //           //                   Colors.black26,
      //           //                   fontWeight:
      //           //                   FontWeight
      //           //                       .w500),
      //           //               // '${}',
      //           //             ),
      //           //           ),
      //           //         ],
      //           //       ),
      //           //     ),
      //           //   ],
      //           // )
      //         ],
      //       ),
      //     ],
      //   ),
      // );
    }
  }

  void onSendMessage(
      String content,
      String type,
      String description,
      String dueDate,
      String status,
      int paymentDues,
      String startTime,
      String endTime) async {
    if (content.isNotEmpty) {
      Map<String, dynamic> chatData = {
        "sendBy": NameConst.value,
        "message": content,
        "type": type,
        'description': description,
        "time": FieldValue.serverTimestamp(),
        "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
        // "status": "unread",
        "sender": userDocId.value
        // "currentTime": DateTime.now(),
      };

      await _fireStore
          .collection('groups')
          .doc(widget.groupChatId)
          .update({'groupOrder': FieldValue.serverTimestamp()});

      await _fireStore
          .collection('groups')
          .doc(widget.groupChatId)
          .collection('chats')
          .doc(DateTime.now().millisecondsSinceEpoch.toString())
          .set(chatData);
    } else {
      Fluttertoast.showToast(
          msg: 'Nothing to send', backgroundColor: Colors.grey);
    }
  }

  Future getFile() async {
    FilePickerResult? result = (await FilePicker.platform.pickFiles());
    var fileTitle = result!.files.single.name;
    if (result != null) {
      imageFile = File(result.files.single.path!);
      if (imageFile != null) {
        setState(() {
          // isLoading = true;
        });
        uploadFile(fileTitle);
      }
    }
    //imageFile = File(file?.path);
  }

  Future uploadFile(String fileTitle) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    UploadTask uploadTask = uploadFile1(imageFile!, fileName);
    try {
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        // isLoading = false;
        onSendMessage(imageUrl, "file", fileTitle, "", "", 0, "", "");
      });
    } on FirebaseException catch (e) {
      setState(() {
        //  isLoading = false;
      });
      Fluttertoast.showToast(msg: e.message ?? e.toString());
    }
  }

  Future getImage() async {
    pickedImage =
        await picker.pickImage(source: ImageSource.gallery, maxWidth: 1920);
    var fileTitle = pickedImage!.name;
    imageFile = File(pickedImage!.path);
    if (pickedImage != null) {
      setState(() {
        // isLoading = true;
      });
      uploadImage(fileTitle);
    }
    //imageFile = File(file?.path);
  }

  Future uploadImage(String fileTitle) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    UploadTask uploadTask = uploadFile1(imageFile!, fileName);
    try {
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        //isLoading = false;
        onSendMessage(imageUrl, "document", fileTitle, "", "", 0, "", "");
      });
    } on FirebaseException catch (e) {
      setState(() {
        // isLoading = false;
      });
      Fluttertoast.showToast(msg: e.message ?? e.toString());
    }
  }

  UploadTask uploadFile1(File image, String fileName) {
    Reference reference = storage.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(image);
    return uploadTask;
  }
}

class GroupChatMessage {
  UserModel userData;
  bool sentBy;
  String messageType;
  String dateTime;

  GroupChatMessage({
    required this.userData,
    required this.sentBy,
    required this.messageType,
    required this.dateTime,
  });
}
