import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../common_widgets/colors.dart';
import '../common_widgets/common_loader.dart';
import '../common_widgets/common_widgets.dart';
import '../common_widgets/drawer.dart';
import '../common_widgets/page_transition.dart';
import '../helpers/constants.dart';
import 'group_chat_inbox.dart';

class GroupChatScreen extends StatefulWidget {
  bool addingMember;
  String groupTitle;

  GroupChatScreen(
      {Key? key, required this.addingMember, this.groupTitle = "abc"})
      : super(key: key);

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, dynamic>> membersList = [];
  List<Map<dynamic, dynamic>> groupsList = [];
  List? groupChatList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  getData() async {
    setState(() {
      isLoading = true;
    });
    var groupId;
    await _firestore.collection('users').doc(userDocId.value).get().then((map) {
      setState(() {
        membersList.add({
          "name": map['displayName'],
          "email": map['email'],
          "uid": map['id'],
          "FcmToken": map['FcmToken'],
          "imageUrl": map['imageUrl'],
        });
      });
    });

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("groups").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i].data() as Map;
      if (widget.groupTitle == a['name']) {
        groupId = a['id'];
      }
    }
    var documentSnapshot = await FirebaseFirestore.instance
        .collection("groups")
        .doc(groupId)
        .get();
    List arrayData = documentSnapshot.data() == null
        ? []
        : documentSnapshot.data()!["members"];
    if (kDebugMode) {
      print('Array data: $arrayData');
    }
    if (arrayData.isNotEmpty) {
      for (int i = 0; i < arrayData.length; i++) {
        membersList.add(arrayData[i]);
      }
    }
    if (kDebugMode) {
      print(membersList);
    }
    await _firestore.collection('groups').doc(groupId).update({
      "members": membersList,
    });
    await _firestore
        .collection('users')
        .doc(userDocId.value)
        .collection('groups')
        .doc(groupId)
        .set({
      "name": widget.groupTitle,
      "id": groupId,
      'creationTime': FieldValue.serverTimestamp(),
    });

    await getAllGroupChatWithMoreInfo();
  }

  getAllGroupChatWithMoreInfo() async {
    setState(() {
      isLoading = true;
    });
    groupChatList = [];
    List membersListOfThisGroup = [];
    await FirebaseFirestore.instance
        .collection(('groups'))
        .orderBy('groupOrder', descending: true)
        .get()
        .then((snapshot) async {
      List<DocumentSnapshot> allGroups = snapshot.docs;
      for (DocumentSnapshot ds in allGroups) {
        setState(() {
          membersListOfThisGroup = ds['members'];
          print(
              '=========== this is length ${membersListOfThisGroup.length} of members of ${ds.id} with email ');
        });

        for (Map singleGroup in membersListOfThisGroup) {
          if (singleGroup['email'] == EmailConst.value) {
            print('===== Yes Matched, yet Exit in this Group ======');

            await FirebaseFirestore.instance
                .collection('groups')
                .doc(ds.get('id'))
                .collection('chats')
                // .where('type', isEqualTo: 'notification')
                .orderBy('time', descending: true)
                .get()
                .then((snapshot) async {
              List<DocumentSnapshot> allChatMessagesOfThisGroup = snapshot.docs;

              // setState(() {
              //   unReadMessageCounter = 0;
              // });

              ///----------
              // for (DocumentSnapshot singleChatDoc
              //     in allChatMessagesOfThisGroup) {
              //   List seenUsersList = singleChatDoc['seenBy'];
              //
              //   if (seenUsersList.contains(userDocId.value)) {
              //     print('===== Message has been read by this user  =====');
              //   } else {
              //     print('===== Message not read by =====');
              //     unReadMessageCounter = unReadMessageCounter + 1;
              //   }
              // }

              if (allChatMessagesOfThisGroup.isEmpty) {
                print('==== this chats is empty =====');

                ///-----Add Group Info to a Group List
                groupChatList!.add({
                  'groupID': ds.get('id'),
                  'groupName': ds.get('name'),
                  'members': ds['members'],

                  //------Total Unread Messages
                  'unReadMessages': 0,

                  //-----Group Created On Date
                  'createdOn': DateFormat('dd MMM yy').format(
                      DateTime.parse(ds['creationTime'].toDate().toString())),

                  // //-----Group Image URL
                  // 'groupImage': ds['imageUrl'],

                  // //------Last Message Sender
                  // 'lastMessageSender': '',
                  //------Last Message on Chat
                  'lastMessage': 'No messages yet',
                  //------Last Message Time / Formatted
                  'lastMessageTime': '',
                });
              } else {
                ///-----Add Group Info to a Group List
                print('=========== why this is 1 ${ds['creationTime']}');
                print(
                    '=========== why this is 2 ${DateFormat('dd MMM yy').format(DateTime.parse(ds['creationTime'].toDate().toString()))}');

                groupChatList!.add({
                  'groupID': ds.get('id'),
                  'groupName': ds.get('name'),
                  'members': ds['members'],

                  // //------Total Unread Messages
                  // 'unReadMessages': unReadMessageCounter,

                  //-----Group Created On Date
                  'createdOn':
                      '${DateFormat('dd MMM yy').format(DateTime.parse(ds['creationTime'].toDate().toString()))}',
                  // 'creationTime': ds['creationTime'],

                  // //-----Group Image URL
                  // 'groupImage': ds['imageUrl'],

                  //------Last Message Sender
                  'lastMessageSender': allChatMessagesOfThisGroup[0]['sendBy'],
                  //------Last Message on Chat
                  'lastMessage': allChatMessagesOfThisGroup[0]['message'],
                  // 'lastMessage': allChatMessagesOfThisGroup[0]['message'],
                  //------Last Message Time / Formatted
                  'lastMessageTime': DateFormat('hh:mm:a').format(
                      DateTime.parse(allChatMessagesOfThisGroup[0]['time']
                          .toDate()
                          .toString())),
                });
              }
            });
          } else {
            print('===== Email Not Matched ======');
          }
        }
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.addingMember ? getData() : getAllGroupChatWithMoreInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        endDrawer: MyDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 80,
                color: Colors.black,
                child: CommonWidgets.CommonAppBar(() {
                  scaffoldKey.currentState!.openEndDrawer();
                }),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 22, right: 15, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      'Group',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
              ),
              isLoading
                  ? const Center(child: CommonLoader())
                  : Column(
                      children: [
                        for (int index = 0;
                            index < groupChatList!.length;
                            index++)
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 22, right: 22, bottom: 10),
                            child: DelayedDisplay(
                              delay: Duration(
                                milliseconds: (index + 1) * 250,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black.withOpacity(0.1)),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 8, bottom: 8),
                                  child: ListTile(
                                    onTap: () {
                                      PageTransition.fadeInNavigation(
                                          page: GroupChatInbox(
                                        groupChatId: groupChatList![index]
                                            ['groupID'],
                                        membersCount: groupChatList![index]
                                                ['members']
                                            .length,
                                        title: groupChatList![index]
                                            ['groupName'],
                                      ));
                                    },
                                    contentPadding: EdgeInsets.zero,
                                    style: ListTileStyle.drawer,
                                    selectedTileColor: Colors.transparent,
                                    leading: Image.asset(
                                      'assets/images/icon.png',
                                      color: Colors.black,
                                    ),
                                    subtitle: Row(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 55.w,
                                              child: Text(
                                                groupChatList![index]
                                                    ['lastMessage'],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: AppColors.black
                                                        .withOpacity(0.5)),
                                              ),
                                            ),
                                            // const Icon(
                                            //   Icons.done_all,
                                            //   color: AppColors.primary,
                                            //   size: 18,
                                            // )
                                          ],
                                        ),
                                      ],
                                    ),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          groupChatList![index]['groupName'] ??
                                              "",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'OpenSansBold',
                                              color: Colors.black),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            children: [
                                              Text(
                                                groupChatList![index]
                                                    ['lastMessageTime'],
                                                style: TextStyle(
                                                    color: AppColors.black
                                                        .withOpacity(0.5),
                                                    fontSize: 12),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    selected: true,
                                  ),
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
