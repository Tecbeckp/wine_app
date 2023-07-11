import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_openai/openai.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../common_widgets/colors.dart';
import '../common_widgets/common_loader.dart';
import '../common_widgets/common_widgets.dart';
import '../common_widgets/drawer.dart';
import '../helpers/constants.dart';
import '../models/category_model.dart';

class SearchPages extends StatefulWidget {
  final String symptom;
  final List<String> selectedTypes;

  const SearchPages(
      {Key? key, required this.symptom, required this.selectedTypes})
      : super(key: key);

  @override
  State<SearchPages> createState() => _SearchPagesState();
}

class _SearchPagesState extends State<SearchPages> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String _selectedOption = '';
  bool showDetail = false;
  bool detailLoading = false;
  var detailIndex;
  var detailResponse;
  List<CategoryModel> categories = dummyExercises;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedOption = widget.selectedTypes[0];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDetail == false
            ? Get.back()
            : (setState(() {
                showDetail = false;
              }));
        return false;
      },
      child: Scaffold(
        key: scaffoldKey,
        endDrawer: MyDrawer(),
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.black,
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    'assets/images/icon.png',
                    color: Colors.white,
                    height: 25,
                    width: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Tylt',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: 'ManropeBold'),
                  )
                ],
              ),
              actions: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        scaffoldKey.currentState!.openEndDrawer();
                      },
                      child: Image.asset(
                        'assets/images/drawer.png',
                        height: 20,
                        width: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                )
              ],
              pinned: true,
              expandedHeight: 230,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: [
                    Container(
                      color: AppColors.appBarBlackContainer,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 80,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    prefixIcon: Image.asset(
                                      'assets/images/search_icon.png',
                                      color: AppColors.black,
                                    ),
                                    prefixIconConstraints: const BoxConstraints(
                                        maxHeight: 25,
                                        minHeight: 25,
                                        maxWidth: 50,
                                        minWidth: 50),
                                    hintText: widget.symptom,
                                    hintStyle: const TextStyle(
                                        color: AppColors.black, fontSize: 14),
                                    disabledBorder: InputBorder.none,
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Container(
                                height: 50,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: DropdownButtonFormField<String>(
                                      decoration: const InputDecoration(
                                        border: InputBorder
                                            .none, // Set border to none
                                        focusedBorder: InputBorder
                                            .none, // Set focused border to none
                                        enabledBorder: InputBorder.none,
                                      ),
                                      hint: Text(_selectedOption),
                                      items: widget.selectedTypes
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                value.contains('Red')
                                                    ? 'assets/images/wine_glass.png'
                                                    : value.contains('White')
                                                        ? 'assets/images/wine_glass2.png'
                                                        : value.contains('Rose')
                                                            ? 'assets/images/rose.png'
                                                            : value.contains(
                                                                    'Sparking')
                                                                ? 'assets/images/sparking.png'
                                                                : 'assets/images/dessert.png',
                                                height: 20,
                                                width: 20,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                value,
                                                style: const TextStyle(
                                                    color: AppColors.black,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedOption = newValue!;
                                          if (_selectedOption == 'Exercises') {
                                            categories = dummyExercises;
                                          } else if (_selectedOption ==
                                              'Recipes') {
                                            categories = dummyRecipes;
                                          } else if (_selectedOption ==
                                              'Ingredients') {
                                            categories = dummyFoods;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 40),
                    child: showDetail == false
                        ? Text(
                            _selectedOption,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'InterMedium',
                                fontSize: 20),
                          )
                        : const SizedBox(),
                  ),
                  showDetail
                      ? SizedBox(
                          width: 100.w,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: detailLoading
                                ? const Center(child: CommonLoader())
                                : Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            showDetail = false;
                                          });
                                        },
                                        child: Row(
                                          children: const [
                                            Icon(
                                              Icons.arrow_back_ios_new,
                                              size: 18,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: const [
                                          Text(
                                            'Buy Wines',
                                            style: TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        children: [
                                          for (int index = 0;
                                              index < 5;
                                              index++)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 10,
                                                  right: 10,
                                                  left: 10),
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                height: 170,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 0.1),
                                                      blurRadius: 11.6487,
                                                      offset:
                                                          Offset(0, 2.32975),
                                                    ),
                                                  ],
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/wine_bottle.png',
                                                      height: 135,
                                                      width: 100,
                                                      fit: BoxFit.fitHeight,
                                                    ),
                                                    const SizedBox(
                                                      width: 9,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 20),
                                                            child: Text(
                                                                'Cabernet Sauvignon',
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 15,
                                                                )),
                                                          ),
                                                          const SizedBox(
                                                            height: 6,
                                                          ),
                                                          Text(
                                                              'This French-origin grape was first made famous by the wines of Bordeaux.',
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  height: 1.5,
                                                                  color: AppColors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.8),
                                                                  fontSize:
                                                                      13)),
                                                          SizedBox(
                                                            height: 6,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Image.asset(
                                                                'assets/images/location_icon.png',
                                                                height: 15,
                                                                width: 15,
                                                                color: AppColors
                                                                    .primary,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            2),
                                                                child: SizedBox(
                                                                  width: 40.w,
                                                                  child: const Text(
                                                                      '2464 Royal Ln. Mesa... ',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          height:
                                                                              1.5,
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              10)),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(children: [
                                                                Container(
                                                                    height: 36,
                                                                    width: 54,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: AppColors
                                                                          .heartContainer
                                                                          .withOpacity(
                                                                              0.17),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                    ),
                                                                    child: const Center(
                                                                        child: Text(
                                                                      '\$15',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              AppColors.primary),
                                                                    ))),
                                                              ]),
                                                              Container(
                                                                  height: 28,
                                                                  width: 28,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: AppColors
                                                                        .heartContainer
                                                                        .withOpacity(
                                                                            0.17),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            3.6),
                                                                  ),
                                                                  child:
                                                                      const Center(
                                                                          child:
                                                                              Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: 3,
                                                                        left: 3,
                                                                        bottom:
                                                                            3,
                                                                        right:
                                                                            4),
                                                                    child: Icon(
                                                                      Icons
                                                                          .favorite_border,
                                                                      color: AppColors
                                                                          .primary,
                                                                    ),
                                                                  ))),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: const [
                                          Text(
                                            'Cabernet Sauvignon',
                                            style: TextStyle(
                                                fontSize: 21,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          'The world’s most popular red wine grape is a natural cross between Cabernet Franc and Sauvignon Blanc from Bordeaux, France. Cabernet Sauvignon is loved for its high concentration and age worthiness. Wine drinkers today can find many Cabernet Sauvignon options in the market.\n\n Some Cabernet Sauvignon wines are sumptuous and fruity, others are savory and smoky. It all depends on where the Cabernet Sauvignon grows and how it’s made into wine.',
                                          style: TextStyle(
                                              height: 2.3,
                                              color: AppColors.black
                                                  .withOpacity(0.8),
                                              fontSize: 13)),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        children: const [
                                          Text(
                                            'Primary Flavors',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Interbold',
                                              fontSize: 21,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          const DelayedDisplay(
                                              delay: Duration(
                                                milliseconds: 300,
                                              ),
                                              child: Icon(
                                                Icons.check,
                                                color: AppColors.primary,
                                                size: 21,
                                              )),
                                          const SizedBox(
                                            width: 9,
                                          ),
                                          Text(
                                            'Black Cherry',
                                            style: TextStyle(
                                              color: AppColors.black
                                                  .withOpacity(0.7),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 13,
                                      ),
                                      Row(
                                        children: [
                                          const DelayedDisplay(
                                              delay: Duration(
                                                milliseconds: 700,
                                              ),
                                              child: Icon(
                                                Icons.check,
                                                color: AppColors.primary,
                                                size: 21,
                                              )),
                                          const SizedBox(
                                            width: 7,
                                          ),
                                          Text(
                                            'Black Currant',
                                            style: TextStyle(
                                                color: AppColors.black
                                                    .withOpacity(0.7)),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 13,
                                      ),
                                      Row(
                                        children: [
                                          const DelayedDisplay(
                                              delay: Duration(
                                                milliseconds: 1100,
                                              ),
                                              child: Icon(
                                                Icons.check,
                                                color: AppColors.primary,
                                                size: 21,
                                              )),
                                          const SizedBox(
                                            width: 7,
                                          ),
                                          Text(
                                            'Cedar',
                                            style: TextStyle(
                                                color: AppColors.black
                                                    .withOpacity(0.7)),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 13,
                                      ),
                                      Row(
                                        children: [
                                          const DelayedDisplay(
                                              delay: Duration(
                                                milliseconds: 1500,
                                              ),
                                              child: Icon(
                                                Icons.check,
                                                color: AppColors.primary,
                                                size: 21,
                                              )),
                                          const SizedBox(
                                            width: 7,
                                          ),
                                          Text(
                                            'Baking Spices',
                                            style: TextStyle(
                                                color: AppColors.black
                                                    .withOpacity(0.7)),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 13,
                                      ),
                                      Row(
                                        children: [
                                          const DelayedDisplay(
                                              delay: Duration(
                                                milliseconds: 1900,
                                              ),
                                              child: Icon(
                                                Icons.check,
                                                color: AppColors.primary,
                                                size: 21,
                                              )),
                                          const SizedBox(
                                            width: 7,
                                          ),
                                          Text(
                                            'Graphite',
                                            style: TextStyle(
                                                color: AppColors.black
                                                    .withOpacity(0.7)),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 35,
                                      ),
                                      Row(
                                        children: const [
                                          Text(
                                            '1. Bordeaux, France',
                                            style: TextStyle(
                                                fontSize: 21,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                          'The world’s most popular red wine grape is a natural cross between Cabernet Franc and Sauvignon Blanc from Bordeaux, France. Cabernet Sauvignon is loved for its high concentration and age worthiness. Wine drinkers today can find many Cabernet Sauvignon options in the market.\n\n Some Cabernet Sauvignon wines are sumptuous and fruity, others are savory and smoky. It all depends on where the Cabernet Sauvignon grows and how it’s made into wine.',
                                          style: TextStyle(
                                              height: 2.3,
                                              color: AppColors.black
                                                  .withOpacity(0.8),
                                              fontSize: 13)),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Image.asset(
                                          'assets/images/detail_page.png'),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                          ),
                        )
                      : Column(
                          children: [
                            for (int index = 0;
                                index < chatRespList.length;
                                index++)
                              GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    detailLoading = true;
                                    showDetail = true;
                                  });
                                  OpenAI.apiKey =
                                      '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';
                                  //OpenAI.apiKey = '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'; //4
                                  if (kDebugMode) {
                                    print(
                                      "Describe the following wines with details :${chatRespList[index]}",
                                    );
                                  }
                                  final chatCompletion =
                                      await OpenAI.instance.chat.create(
                                    model: 'gpt-3.5-turbo',
                                    // model: 'gpt-4',
                                    messages: [
                                      OpenAIChatCompletionChoiceMessageModel(
                                        content:
                                            "Describe the following wines with details :${chatRespList[index]}",
                                        role: OpenAIChatMessageRole.user,
                                      ),
                                    ],
                                  );
                                  setState(() {
                                    detailResponse = chatCompletion
                                        .choices.first.message.content;
                                    detailLoading = false;
                                    detailIndex = index;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, right: 10, left: 10),
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.1),
                                          blurRadius: 11.6487,
                                          offset: Offset(0, 2.32975),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/wine_bottle.png',
                                                      height: 90,
                                                      width: 90,
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            chatRespList[index]
                                                                .split(' ')[0],
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 15,
                                                            )),
                                                        const SizedBox(
                                                          height: 6,
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                                chatRespList[
                                                                    index],
                                                                maxLines: 3,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    height: 1.5,
                                                                    color: AppColors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.7),
                                                                    fontSize:
                                                                        13)),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/red_icon.png',
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                  const SizedBox(
                                                    width: 7,
                                                  ),
                                                  const Text(
                                                    "Red",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 13),
                                                  ),
                                                  const SizedBox(
                                                    width: 12,
                                                  ),
                                                  Image.asset(
                                                    'assets/images/wine_glass2.png',
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                  const SizedBox(
                                                    width: 7,
                                                  ),
                                                  const Text(
                                                    "Flavors",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 13),
                                                  ),
                                                  const SizedBox(
                                                    width: 12,
                                                  ),
                                                  Image.asset(
                                                    'assets/images/location_icon_black.png',
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                  const SizedBox(
                                                    width: 7,
                                                  ),
                                                  const Text(
                                                    "5 Km",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 13),
                                                  ),
                                                ],
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  FirebaseFirestore.instance
                                                      .collection('users')
                                                      .doc(userDocId.value)
                                                      .collection("favourites")
                                                      .doc()
                                                      .set({
                                                    'content':
                                                        chatRespList[index],
                                                  });
                                                },
                                                child: Container(
                                                    height: 28,
                                                    width: 28,
                                                    decoration: BoxDecoration(
                                                      color: AppColors
                                                          .heartContainer
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: const Center(
                                                        child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 3,
                                                          left: 3,
                                                          bottom: 3,
                                                          right: 4),
                                                      child: Icon(
                                                        Icons.favorite_border,
                                                        color:
                                                            AppColors.primary,
                                                      ),
                                                    ))),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                  CommonWidgets.footer(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
