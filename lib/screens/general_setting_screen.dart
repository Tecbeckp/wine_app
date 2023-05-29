import 'package:bordeaux/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_widgets/colors.dart';
import '../common_widgets/common_widgets.dart';
import '../common_widgets/drawer.dart';
import '../common_widgets/page_transition.dart';


class GeneralSettingPage extends StatefulWidget {
  const GeneralSettingPage({Key? key}) : super(key: key);

  @override
  State<GeneralSettingPage> createState() => _GeneralSettingPageState();
}

class _GeneralSettingPageState extends State<GeneralSettingPage> {
  bool _accountConnectedValue = false;
  bool _twoFactorValue = false;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final animationDuration = Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        endDrawer:  MyDrawer(),
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
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 25),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'General Setting',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Interbold',
                            fontSize: 21,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    // Webhooks(),
                    // SizedBox(
                    //   height: 15,
                    // ),
                    // AddUser(),

                    //AccountConnected(),
                    // SizedBox(
                    //   height: 1,
                    // ),
                    //UniqueColorOrSound(),
                    Profile(),
                    SizedBox(
                      height: 10,
                    ),

                    Notification(),
                    TwoFactorAuthentication(),
                    SizedBox(
                      height: 1,
                    ),
                    Billing(),
                    SizedBox(
                      height: 15,
                    ),
                    SignOut(),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              CommonWidgets.footer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget Webhooks() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Add webhooks to select specific channels/servers from discord/slack',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, height: 1.5, fontSize: 14),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              children: [
                Container(
                  height: 35,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                      child: Text(
                    'Add',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'Adipiscing ut risus enim faucibus amet urna a orci. Mauris auctor.',
          style: TextStyle(
              fontSize: 13,
              color: AppColors.black.withOpacity(0.6),
              height: 1.5),
        ),
        SizedBox(
          height: 15,
        ),
        CommonDivider(),
      ],
    );
  }

  Widget AddUser() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Add specific users/hashtags from twitter',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, height: 1.5, fontSize: 14),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              children: [
                Container(
                  height: 35,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                      child: Text(
                    'Add',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'Tellus vulputate laoreet a pellentesque nisi fames consectetur at.',
          style: TextStyle(
              fontSize: 13,
              color: AppColors.black.withOpacity(0.6),
              height: 1.5),
        ),
        SizedBox(
          height: 15,
        ),
        CommonDivider(),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget AccountConnected() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Accounts connected (authorized apps)',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Column(
              children: [
                Transform.scale(
                  scale: 0.8,
                  child: CupertinoSwitch(
                    activeColor: AppColors.primary,
                    value: _accountConnectedValue,
                    onChanged: (bool value) {
                      setState(() {
                        _accountConnectedValue = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          'Massa arcu donec donec scelerisque phasellus tellus sed risus.',
          style: TextStyle(
              fontSize: 13,
              color: AppColors.black.withOpacity(0.6),
              height: 1.5),
        ),
        SizedBox(
          height: 15,
        ),
        CommonDivider(),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget UniqueColorOrSound() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Add unique colors/sounds to keywords',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  height: 35,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                      child: Text(
                    'Add',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'Vitae euismod urna adipiscing in sagittis est amet. Ultrices tristique.',
          style: TextStyle(
              fontSize: 13,
              color: AppColors.black.withOpacity(0.6),
              height: 1.5),
        ),
        SizedBox(
          height: 15,
        ),
        CommonDivider(),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget Notification() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Enable/disable notifications, notifications schedule',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, height: 1.5, fontSize: 15),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              children: [
                Container(
                  height: 35,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                      child: Text(
                    'Add',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'Nunc elit semper diam risus fames. Vulputate cras tempus id nulla.',
          style: TextStyle(
              fontSize: 13,
              color: AppColors.black.withOpacity(0.6),
              height: 1.5),
        ),
        SizedBox(
          height: 15,
        ),
        CommonDivider(),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget TwoFactorAuthentication() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Two-factor authentication',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                            fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              children: [
                Transform.scale(
                  scale: 0.8,
                  child: CupertinoSwitch(
                    activeColor: AppColors.primary,
                    value: _twoFactorValue,
                    onChanged: (bool value) {
                      setState(() {
                        _twoFactorValue = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'Tempor arcu massa dapibus consequat et aliquam morbi sit. Quam.',
          style: TextStyle(
              fontSize: 13,
              color: AppColors.black.withOpacity(0.6),
              height: 1.5),
        ),
        SizedBox(
          height: 15,
        ),
        CommonDivider(),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget Billing() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Billing',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                            fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 15,
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'Cras vitae eu in vitae nunc sit. Mauris sapien eu quam cras vel.',
          style: TextStyle(
              fontSize: 13,
              color: AppColors.black.withOpacity(0.6),
              height: 1.5),
        ),
        SizedBox(
          height: 15,
        ),
        Divider(
          height: 1,
          color: Colors.grey.withOpacity(0.5),
        ),
      ],
    );
  }

  Widget Profile() {
    return InkWell(
      onTap: () {
        PageTransition.fadeInNavigation(page: ProfileScreen());
      },
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Profile',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Cras vitae eu in vitae nunc sit. Mauris sapien eu quam cras vel.',
            style: TextStyle(
                fontSize: 13,
                color: AppColors.black.withOpacity(0.6),
                height: 1.5),
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            height: 1,
            color: Colors.grey.withOpacity(0.5),
          ),
        ],
      ),
    );
  }

  Widget SignOut() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Signout',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                            fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 15,
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'Est augue ornare in leo. Duis ultricies commodo lobortis vitae.',
          style: TextStyle(
              fontSize: 13,
              color: AppColors.black.withOpacity(0.6),
              height: 1.5),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  static Widget CommonDivider() {
    return Divider(
      thickness: 1,
      color: Colors.grey.withOpacity(0.4),
    );
  }
}
