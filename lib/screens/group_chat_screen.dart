import 'package:bordeaux/screens/profile_screen.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

import '../common_widgets/colors.dart';
import '../common_widgets/common_loader.dart';
import '../common_widgets/common_widgets.dart';
import '../common_widgets/drawer.dart';
import '../common_widgets/page_transition.dart';
import '../helpers/constants.dart';
import 'group_chat_inbox.dart';

class GroupChatScreen extends StatefulWidget {


  GroupChatScreen(
      {Key? key, })
      : super(key: key);

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  bool isLoading = false;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();


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
                  for (int index = 0; index < 10; index++)
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
                                    page: const GroupChatInbox());
                              },
                              contentPadding: EdgeInsets.zero,
                              style: ListTileStyle.drawer,
                              selectedTileColor: Colors.transparent,
                              leading: Image.asset(
                                'assets/images/chat.png',
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
                                          'Hi,I heard you are doing great and learning a lot of new things',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.black
                                                  .withOpacity(0.5)),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.done_all,
                                        color: AppColors.primary,
                                        size: 18,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              title: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Name",
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
                                          '11:20 am',
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
