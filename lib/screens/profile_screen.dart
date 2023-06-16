import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../common_widgets/colors.dart';
import '../common_widgets/common_loader.dart';
import '../common_widgets/common_widgets.dart';
import '../common_widgets/drawer.dart';
import '../helpers/constants.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool private = false;
  List<bool> herbsCheck = [false];
  RxList<dynamic> winesList = [].obs;
  bool public = true;
  bool? value1;

  bool isLoader = false;
  List<bool> showOptions = List.filled(4, false, growable: true);
  getData() async {
    setState(() {
      isLoader = true;
    });
    await chatGptResponse("thai");
    // await authorize();
    // await fetchData();
    // await fetchStepData();
    setState(() {
      isLoader = false;
    });
  }

  Future<void> chatGptResponse(mealType) async {
    OpenAI.apiKey = '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';
    //OpenAI.apiKey = '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'; //4
    final chatCompletion = await OpenAI.instance.chat.create(
      model: 'gpt-3.5-turbo',
      //model: 'gpt-4',
      messages: [
        const OpenAIChatCompletionChoiceMessageModel(
          content: "recommend a few wines based on Thai cuisine",
          role: OpenAIChatMessageRole.user,
        ),
      ],
    );
    var abc = chatCompletion.choices.first.message.content;
    // chat = abc.toString().split("\n");
    winesList.value = abc.toString().split(RegExp(r'\d+\.\s'));
  }

  List<_SalesData> data = [
    _SalesData('May 04', 0),
    _SalesData('May 05', 01),
    _SalesData('May 06', 02),
    _SalesData('May 07', 01),
    _SalesData('May 08', 02)
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
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
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            // Get.to(()=>ChartScreen());
                          },
                          child: Text(
                            'Profile',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Interbold',
                                fontSize: 21),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Stack(children: [
                              SizedBox(
                                height: 115,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    (userData.imageUrl != "" &&
                                            userData.imageUrl != null)
                                        ? Image.network(
                                            userData.imageUrl,
                                            height: 87,
                                            width: 87,
                                          )
                                        : Image.asset(
                                            'assets/images/profile.png',
                                            height: 87,
                                            width: 87,
                                          )
                                  ],
                                ),
                              ),
                            ]),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          userData.displayName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Interbold',
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => EditProfileScreen());
                                          },
                                          child: Container(
                                            height: 32,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColors.primary,
                                                    width: 1.5),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Image.asset(
                                                  'assets/images/Edit.png'),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            await Share.share(
                                              "Share",
                                              subject: "subject",
                                            );
                                          },
                                          child: Container(
                                            height: 32,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                color: AppColors.primary,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(7.0),
                                              child: Image.asset(
                                                  'assets/images/share_icon.png'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '@${userData.displayName}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    userData.bio == ""
                        ? SizedBox.shrink()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 80.w,
                                  child: Text(
                                    userData.bio.toString(),
                                    maxLines: 10,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Interbold',
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    userData.bio == ""
                        ? SizedBox.shrink()
                        : SizedBox(
                            height: 9,
                          ),
                    userData.address == ""
                        ? SizedBox.shrink()
                        : Row(
                            children: [
                              Image.asset(
                                'assets/images/location_icon.png',
                                height: 38,
                                width: 28,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              SizedBox(
                                width: 70.w,
                                child: Text(
                                  userData.address.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 10,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Interbold',
                                      fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      width: 90.w,
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  public = false;
                                  private = true;
                                });
                              },
                              child: Container(
                                width: 42.w,
                                decoration: BoxDecoration(
                                    color: private == true
                                        ? Colors.white
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(6)),
                                child: Center(
                                    child: Text(
                                  'Private',
                                  style: TextStyle(
                                      color: private == true
                                          ? Colors.black
                                          : Colors.white,
                                      fontFamily: 'InterMedium'),
                                )),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  public = true;
                                  private = false;
                                });
                              },
                              child: Container(
                                width: 42.w,
                                decoration: BoxDecoration(
                                    color: public == true
                                        ? Colors.white
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(6)),
                                child: Center(
                                    child: Text(
                                  'Public',
                                  style: TextStyle(
                                      color: public == true
                                          ? Colors.black
                                          : Colors.white,
                                      fontFamily: 'InterMedium'),
                                )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 90.w,
                      decoration: containerDecoration(),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Favorite Meal Plans',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          for (int i = 0; i < 4; i++)
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Image.asset(
                                              'assets/images/profile_wine.png',
                                              height: 90,
                                              width: 90,
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: const Text(
                                                      'Schrader Cellars',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Interbold',
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            showOptions[i] =
                                                                !showOptions[i];
                                                          });
                                                        },
                                                        child: Container(
                                                          width: 15,
                                                          height: 15,
                                                          child:
                                                              showOptions[i] ==
                                                                      true
                                                                  ? Image.asset(
                                                                      'assets/images/arrow_up.png',
                                                                      scale: 4,
                                                                      color: AppColors
                                                                          .primary,
                                                                    )
                                                                  : Image.asset(
                                                                      'assets/images/arrow_down.png',
                                                                      scale: 4,
                                                                    ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                        height: 25,
                                                        width: 46,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: AppColors
                                                                .primary),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.white,
                                                              size: 16,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              '4.0',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Packs in generous steeped plum, boysenberry and mulberry flavors...',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    color: AppColors.black
                                                        .withOpacity(0.7),
                                                    fontSize: 13),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Visibility(
                                      visible: showOptions[i],
                                      child: Container(
                                        height: 230,
                                        margin: const EdgeInsets.only(top: 7),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                width: 1.5)),
                                        child: SfCartesianChart(
                                            primaryXAxis: CategoryAxis(),
                                            enableAxisAnimation: true,
                                            // Chart title

                                            // Enable legend

                                            title: ChartTitle(
                                                text: 'How much user drink',
                                                textStyle: TextStyle(
                                                    color: AppColors.primary,
                                                    fontSize: 12)),
                                            // Enable tooltip
                                            tooltipBehavior:
                                                TooltipBehavior(enable: true),
                                            series: <
                                                ChartSeries<_SalesData,
                                                    String>>[
                                              LineSeries<_SalesData, String>(
                                                  dataSource: data,
                                                  xValueMapper:
                                                      (_SalesData sales, _) =>
                                                          sales.year,
                                                  yValueMapper:
                                                      (_SalesData sales, _) =>
                                                          sales.sales,
                                                  color: AppColors.primary,
                                                  // Enable data label
                                                  dataLabelSettings:
                                                      DataLabelSettings(
                                                          isVisible: true))
                                            ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 13,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Recommend Wines',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 21),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    isLoader == true
                        ? Center(child: CommonLoader())
                        : Column(
                            children: [
                              for (int i = 0; i < winesList.length; i++)
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Container(
                                      width: 90.w,
                                      decoration: containerDecoration(),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Image.asset(
                                              'assets/images/intercept.png',
                                              height: 120,
                                              width: 80.w,
                                              fit: BoxFit.fitWidth,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  winesList[i].split(' ')[0],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              winesList[i],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: AppColors.black
                                                      .withOpacity(0.7),
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                    const SizedBox(
                      height: 30,
                    ),
                    CommonWidgets.footer()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static containerDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(11),

      boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            // shadow color
            blurRadius: 15,
            // shadow radius
            offset: const Offset(15, 10),
            // shadow offset
            spreadRadius: 0.2,
            // The amount the box should be inflated prior to applying the blur
            blurStyle: BlurStyle.normal // set blur style
            ),
      ],

      // boxShadow: [
      //   BoxShadow(
      //     color: Colors.grey.withOpacity(0.2),
      //     spreadRadius: 3,
      //     blurRadius: 1,
      //     offset: Offset(0, 6),
      //     // changes position of shadow
      //   ),
      // ],
    );
  }

  static commonDivider() {
    return Divider(
      thickness: 1.5,
      color: Colors.grey.withOpacity(0.3),
    );
  }

  static commomContainer() {
    return Container(
      height: 2,
      color: Colors.grey.withOpacity(0.3),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
