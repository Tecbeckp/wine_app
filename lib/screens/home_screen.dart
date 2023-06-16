import 'package:bordeaux/screens/age_verification.dart';
import 'package:bordeaux/screens/profile_screen.dart';
import 'package:bordeaux/screens/search_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_openai/openai.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

import '../RestApi.dart';
import '../common_widgets/colors.dart';
import '../common_widgets/common_loader.dart';
import '../common_widgets/common_widgets.dart';
import '../common_widgets/drawer.dart';
import '../common_widgets/page_transition.dart';
import '../controllers/general_controller.dart';
import '../helpers/constants.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  final bool fromStart;

  const HomeScreen({Key? key, this.fromStart = true}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> membersList = [];
  List<String> groupList = [];
  final generalController = Get.find<GeneralController>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController symptomsController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  List<bool> herbsCheck = [false, false, false, false, false, false];
  bool isLoading = false;
  List<String> selectedValues = [];
  var dropdownFieldController = TextEditingController();
  bool showOptions = false;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var loggedInFree = 0;
  bool groupAvailable = false;

  List<String> backgroundImages = [
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image3.png',
    'assets/images/image4.png',
    'assets/images/image5.png',
    'assets/images/image6.png',
    'assets/images/image7.png',
    'assets/images/image8.png',
    'assets/images/image9.png',
    'assets/images/image10.png',
    'assets/images/image11.png',
  ];

  @override
  void initState() {
    // TODO: implement initState
    generalController.backgroundImageCounter(
        generateRandomNumber(0, backgroundImages.length));
    super.initState();
    print(loggedInGlobal.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      endDrawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100.h < 740
                  ? showOptions
                      ? 133.h
                      : 115.h
                  : showOptions
                      ? 124.h
                      : 103.h,
              width: 100.w,
              child: Stack(fit: StackFit.expand, children: [
                // widget.fromStart ?
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.darken,
                  ),
                  child: Image.asset(
                    'assets/images/image1.png',
                    fit: BoxFit.fill,
                  ),

                  // Image.asset(
                  //   backgroundImages[
                  //       generalController.backgroundImageCounter.value],
                  //   fit: BoxFit.fill,
                  // ),
                ),
                // Obx(() =>
                //     ColorFiltered(
                //   colorFilter: ColorFilter.mode(
                //     Colors.black.withOpacity(0.3),
                //     BlendMode.darken,
                //   ),
                //   child: Image.asset(
                //     backgroundImages[generalController.backgroundImageCounter.value],
                //     fit: BoxFit.fill,
                //   ),
                // )),
                // Image.asset('assets/images/background_grocery.png',fit: BoxFit.fill,),
                Positioned(
                    top: 100.h < 740 ? 50 : 60,
                    child: SizedBox(
                      width: 100.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              PageTransition.fadeInNavigation(
                                  page: ProfileScreen());
                            },
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  'assets/images/logo_white.png',
                                  height: 25,
                                  width: 25,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'BORDEAUX',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      fontFamily: 'ManropeBold'),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        // <-- SEE HERE
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(15.0),
                                        ),
                                      ),
                                      builder: (context) {
                                        return Wrap(children: [
                                          StatefulBuilder(builder:
                                              (BuildContext context,
                                                  StateSetter setState) {
                                            return const ChattingView();
                                          }),
                                        ]);
                                      });
                                },
                                child: Image.asset(
                                  'assets/images/chatbot.png',
                                  height: 27,
                                  width: 27,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
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
                      ),
                    )),

                Positioned(
                  top: 100.h < 740 ? 97 : 110,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 100.w,
                        child: Center(
                          child: Text(
                            'Your personal\n Sommelier from\n home',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                height: 1.5,
                                fontSize: 23.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100.h < 740 ? 2.h : 3.h,
                      ),
                      SizedBox(
                        width: 100.w,
                        child: const Center(
                          child: Text(
                            'Learn tasting methods to pair wine with your favorite\n foods!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white, height: 1.7, fontSize: 12),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100.h < 740 ? 2.h : 3.h,
                      ),
                      SizedBox(
                        width: 100.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 88.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: symptomsController,
                                      decoration: InputDecoration(
                                        prefixIcon: Image.asset(
                                          'assets/images/search_icon.png',
                                          scale: 3.5,
                                        ),
                                        prefixIconConstraints:
                                            const BoxConstraints(
                                                maxHeight: 25,
                                                minHeight: 25,
                                                maxWidth: 50,
                                                minWidth: 50),
                                        hintText: "Tell us about the meal",
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10.sp),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
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
                                    const SizedBox(height: 20),
                                    placesAutoCompleteTextField(),
                                    const SizedBox(height: 20),
                                    Column(
                                      children: [
                                        TextFormField(
                                          controller: dropdownFieldController,
                                          readOnly: true,
                                          onTap: () {
                                            setState(() {
                                              showOptions = !showOptions;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            suffixIconConstraints:
                                                const BoxConstraints(
                                                    minWidth: 50,
                                                    maxWidth: 50,
                                                    minHeight: 22,
                                                    maxHeight: 50),
                                            suffixIcon: InkWell(
                                                child: showOptions == true
                                                    ? Image.asset(
                                                        'assets/images/arrow_up.png',
                                                        scale: 3.5,
                                                      )
                                                    : Image.asset(
                                                        'assets/images/arrow_down.png',
                                                        scale: 3.5,
                                                      )),
                                            prefixIconConstraints:
                                                const BoxConstraints(
                                                    maxHeight: 25,
                                                    minHeight: 25,
                                                    maxWidth: 50,
                                                    minWidth: 50),
                                            hintText: "Wine Type",
                                            hintStyle: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14),
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
                                                  color: Colors.red
                                                      .withOpacity(0.8),
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: showOptions,
                                          child: Container(
                                            height: 340,
                                            margin:
                                                const EdgeInsets.only(top: 7),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    width: 1.5)),
                                            child: Column(
                                              children: [
                                                for (int i = 0;
                                                    i < dropDownImages.length;
                                                    i++)
                                                  Container(
                                                    color: Colors.white,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        if (selectedValues
                                                            .contains(
                                                                dropDownTitles[
                                                                    i])) {
                                                          selectedValues.remove(
                                                              dropDownTitles[
                                                                  i]);
                                                          herbsCheck[i] = false;
                                                        } else {
                                                          selectedValues.add(
                                                              dropDownTitles[
                                                                  i]);
                                                          herbsCheck[i] = true;
                                                        }
                                                        dropdownFieldController
                                                                .text =
                                                            selectedValues
                                                                .join(',');
                                                        setState(() {});
                                                      },
                                                      child: ListTile(
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          leading: Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                              height: 32,
                                                              width: 32,
                                                              child:
                                                                  Image.asset(
                                                                dropDownImages[
                                                                    i],
                                                              )),
                                                          title: Text(
                                                            dropDownTitles[i],
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 15),
                                                          ),
                                                          trailing: Container(
                                                            height: 20,
                                                            width: 20,
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 8),
                                                            decoration: BoxDecoration(
                                                                color: herbsCheck[
                                                                        i]
                                                                    ? AppColors
                                                                        .primary
                                                                    : Colors
                                                                        .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.2),
                                                                    width: 1)),
                                                            child: const Center(
                                                                child: Icon(
                                                              Icons.check,
                                                              color:
                                                                  Colors.white,
                                                              size: 15,
                                                            )),
                                                          )),
                                                    ),
                                                  )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: showOptions ? 3 : 20),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Container(
                                        height: 6.h,
                                        width: 90.w,
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                        ),
                                        child: InkWell(
                                          onTap: () async {
                                            ageVerified.value
                                                ? (dropdownFieldController
                                                        .text.isNotEmpty)
                                                    ? {
                                                        setState(() {
                                                          isLoading = true;
                                                        }),
                                                        await chatGptResponse(
                                                            symptomsController
                                                                .text,
                                                            dropdownFieldController
                                                                .text),
                                                        PageTransition
                                                            .fadeInNavigation(
                                                                page:
                                                                    SearchPages(
                                                          symptom:
                                                              symptomsController
                                                                  .text,
                                                          selectedTypes:
                                                              selectedValues,
                                                        )),
                                                        setState(() {
                                                          isLoading = false;
                                                        }),
                                                      }
                                                    : {
                                                        setState(() async {
                                                          for (int i = 0;
                                                              i <
                                                                  dropDownImages
                                                                      .length;
                                                              i++) {
                                                            selectedValues.add(
                                                                dropDownTitles[
                                                                    i]);
                                                            herbsCheck[i] =
                                                                true;
                                                            dropdownFieldController
                                                                    .text =
                                                                selectedValues
                                                                    .join(',');
                                                          }
                                                          setState(() {
                                                            isLoading = true;
                                                          });
                                                          await chatGptResponse(
                                                              symptomsController
                                                                  .text,
                                                              dropdownFieldController
                                                                  .text);
                                                          PageTransition
                                                              .fadeInNavigation(
                                                                  page:
                                                                      SearchPages(
                                                            symptom:
                                                                symptomsController
                                                                    .text,
                                                            selectedTypes:
                                                                selectedValues,
                                                          ));

                                                          setState(() {
                                                            isLoading = false;
                                                          });
                                                        })
                                                      }
                                                : {
                                                    PageTransition
                                                        .fadeInNavigation(
                                                            page:
                                                                AgeVerification(
                                                      symptom:
                                                          symptomsController
                                                              .text,
                                                      selectedTypes:
                                                          selectedValues,
                                                    )),
                                                    await chatGptResponse(
                                                        symptomsController.text,
                                                        dropdownFieldController
                                                            .text),
                                                  };
                                          },
                                          child: isLoading
                                              ? const Center(
                                                  child: CommonLoader())
                                              : const Center(
                                                  child: Text(
                                                    'Search Wine Selection',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: showOptions ? 0 : 10),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Visibility(
                        visible: !showOptions,
                        child: loggedInGlobal.value
                            ? const SizedBox.shrink()
                            : Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: SizedBox(
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Sign In ',
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.primary,
                                                fontSize: 11.sp,
                                                height: 1.7),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                print("hello");
                                                generalController
                                                    .backgroundImageCounter(
                                                        generateRandomNumber(
                                                            0,
                                                            backgroundImages
                                                                .length));
                                                print(generalController
                                                    .backgroundImageCounter
                                                    .value);
                                                PageTransition.fadeInNavigation(
                                                    page: const LoginScreen());
                                              }),
                                        TextSpan(
                                            text: ' for your medical records.',
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            CommonWidgets.footer()
          ],
        ),
      ),
    );
  }

  Future<void> chatGptResponse(mealType, wine) async {
    OpenAI.apiKey = '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';
    //OpenAI.apiKey = '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'; //4
    if (kDebugMode) {
      print(
        "you are a top sommelier for a high end restaurant, recommend a few '$wine' wines based on this my meal ('$mealType')",
      );
    }
    final chatCompletion = await OpenAI.instance.chat.create(
      model: 'gpt-3.5-turbo',
      //model: 'gpt-4',
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          content:
              "you are a top sommelier for a high end restaurant, recommend a few '$wine' wines based on this my meal ('$mealType')",
          role: OpenAIChatMessageRole.user,
        ),
      ],
    );
    var abc = chatCompletion.choices.first.message.content;
    // chat = abc.toString().split("\n");
    chatRespList = abc.toString().split(RegExp(r'\d+\.\s'));

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("searches").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i].data() as Map;
      groupList.add(a['search']);
    }
    if (groupList.contains(mealType)) {
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        var a = querySnapshot.docs[i].data() as Map;
        if (mealType == a['search']) {
          if (a['fcmToken'] != fcmToken.value) {
            ApiService.sendNotification(fcmToken.value, mealType);
          }
        }
      }
    } else {
      createGroup(mealType);
      userData.notification
          ? await ApiService.sendNotification(fcmToken.value, mealType)
          : null;
    }
    await FirebaseFirestore.instance.collection('searches').doc().set({
      'search': mealType,
      'fcmToken': fcmToken.value,
    });
  }

  void createGroup(symptoms) async {
    String groupId = const Uuid().v1();

    await _firestore.collection('groups').doc(groupId).set({
      "id": groupId,
      "name": symptoms.toString(),
      "members": membersList,
      'creationTime': FieldValue.serverTimestamp(),
      'imageUrl': '',
      'groupOrder': FieldValue.serverTimestamp(),
    });
    await _firestore
        .collection('users')
        .doc(userDocId.value)
        .collection('groups')
        .doc(groupId)
        .set({
      "name": symptoms.toString(),
      "id": groupId,
      'creationTime': FieldValue.serverTimestamp(),
    });
  }

  placesAutoCompleteTextField() {
    return Container(
      child: GooglePlaceAutoCompleteTextField(
          textEditingController: locationController,
          googleAPIKey: "AIzaSyBDOMNCVC2eacCxKYuRxIwCz4w-QjV_l5Y",
          inputDecoration: InputDecoration(
            prefixIcon: Image.asset(
              'assets/images/location_on.png',
              scale: 3.5,
            ),
            prefixIconConstraints: const BoxConstraints(
                maxHeight: 25, minHeight: 25, maxWidth: 50, minWidth: 50),
            hintText: "Location",
            hintStyle: TextStyle(color: Colors.grey, fontSize: 10.sp),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.grey.withOpacity(0.2), width: 1.5),
              borderRadius: BorderRadius.circular(7),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.grey.withOpacity(0.2), width: 1.5),
              borderRadius: BorderRadius.circular(7),
            ),
            errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.red.withOpacity(0.8), width: 1.5),
              borderRadius: BorderRadius.circular(7),
            ),
          ),

          // inputDecoration: InputDecoration(
          //   border: InputBorder.none,
          //   hintText: "Search your location",
          // ),
          debounceTime: 800,
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: (prediction) {
            print('Fahad this is enter location1');
            print(
              "placeDetails" + prediction.lng.toString(),
            );
            // address=prediction.description.toString();
            // print(address);
            print(
              "placeDetails" + prediction.lat.toString(),
            );
          },
          itmClick: (prediction) {
            locationController.text = prediction.description!;
            locationController.selection = TextSelection.fromPosition(
                TextPosition(offset: prediction.description!.length));
          }
          // default 600 ms ,
          ),
    );
  }

  List dropDownTitles = [
    'Red',
    'White',
    'Rose',
    'Sparking',
    'Dessert',
  ];

  List<String> dropDownImages = [
    'assets/images/wine_glass.png',
    'assets/images/wine_glass2.png',
    'assets/images/rose.png',
    'assets/images/sparking.png',
    'assets/images/dessert.png',
  ];
}

class ChattingView extends StatefulWidget {
  const ChattingView({Key? key}) : super(key: key);

  @override
  State<ChattingView> createState() => _ChattingViewState();
}

class _ChattingViewState extends State<ChattingView> {
  final TextEditingController textFieldController = TextEditingController();

  List<ChatMessage> messages = [
    ChatMessage(
        messageContent:
            "Ut pellentesque auctor hac tristique diam aliquet nulla consectetur praesent. Vel condimentum nunc semper diam sed.",
        messageType: "receiver",
        dateTime: "18:06"),
    ChatMessage(
        messageContent:
            "Aliquam est morbi amet euismod viverra in. Nunc enim nullam pur Viverra proin.",
        messageType: "sender",
        dateTime: "18:06 AM"),
    ChatMessage(
        messageContent:
            "Ut pellentesque auctor hac tristique diam aliquet nulla consectetur praesent. Vel condimentum nunc semper diam sed.",
        messageType: "receiver",
        dateTime: "18:06 AM"),
    ChatMessage(
        messageContent:
            "Sollicitudin netus nascetur nulla nisi ac quis pharetra laoreet. ",
        messageType: "sender",
        dateTime: "18:06 AM"),
    ChatMessage(
        messageContent:
            "Ut pellentesque auctor hac tristique diam aliquet nulla consectetur praesent. Vel condimentum nunc semper diam sed.",
        messageType: "receiver",
        dateTime: "18:06 AM"),
  ];
  List<String> name = [
    "sender",
    "reciever",
  ];
  List dropDownTitles = [
    'Recipes',
    'Exercises',
    'Food/ingredients',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Container(
            height: 90,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white),
                        child: Center(
                            child: Image.asset(
                          'assets/images/chat_icon.png',
                          height: 30,
                          width: 30,
                          color: AppColors.primary,
                        )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'I\'m Surely!',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Nice to meet you',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 70.h,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.only(
                            left: 14, right: 14, top: 10, bottom: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment:
                                  (messages[index].messageType == "receiver"
                                      ? Alignment.topLeft
                                      : Alignment.topRight),
                              child: Container(
                                width: 80.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      (messages[index].messageType == "receiver"
                                          ? Colors.grey.shade200
                                          : AppColors.primary),
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  messages[index].messageContent,
                                  style: TextStyle(
                                      fontSize: 14,
                                      height: 1.7,
                                      color: (messages[index].messageType ==
                                              "receiver"
                                          ? Colors.black
                                          : Colors.white)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Align(
                              alignment:
                                  (messages[index].messageType == "receiver"
                                      ? Alignment.topLeft
                                      : Alignment.topRight),
                              child: Text(
                                messages[index].dateTime,
                                style: const TextStyle(
                                    fontSize: 11, color: AppColors.dateTime),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: 62,
                  padding:
                      const EdgeInsets.only(left: 20, right: 0, bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 7,
                        blurRadius: 7,
                        offset:
                            const Offset(5, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: textFieldController,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Message...",
                              hintStyle: TextStyle(
                                  fontSize: 12, color: AppColors.black),
                              contentPadding:
                                  EdgeInsets.only(bottom: 10, right: 10)),
                        ),
                      ),
                      Image.asset(
                        'assets/images/microphone.png',
                        height: 40,
                        width: 20,
                      ),
                      const SizedBox(width: 6),
                      Image.asset(
                        'assets/images/gallery.png',
                        height: 40,
                        width: 20,
                      ),
                      const SizedBox(width: 10),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.primary),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset('assets/images/send.png'),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  String messageContent;
  String messageType;
  String dateTime;

  ChatMessage(
      {required this.messageContent,
      required this.messageType,
      required this.dateTime});
}

class DropDownList {
  String title;
  String image;

  DropDownList(this.title, this.image);
}

class _ViewItem extends StatelessWidget {
  String item;
  bool itemSelected;
  final Function(String) selected;

  _ViewItem(
      {required this.item, required this.itemSelected, required this.selected});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding:
          EdgeInsets.only(left: size.width * .032, right: size.width * .098),
      child: Row(
        children: [
          SizedBox(
            height: 24.0,
            width: 24.0,
            child: Checkbox(
              value: itemSelected,
              onChanged: (val) {
                selected(item);
              },
              activeColor: AppColors.primary,
            ),
          ),
          SizedBox(
            width: size.width * .025,
          ),
          Text(
            item,
          ),
        ],
      ),
    );
  }
}

class CustomMultiselectDropDown extends StatefulWidget {
  final Function(List<String>) selectedList;
  final List<String> listOFStrings;

  CustomMultiselectDropDown(
      {required this.selectedList, required this.listOFStrings});

  @override
  createState() {
    return _CustomMultiselectDropDownState();
  }
}

class _CustomMultiselectDropDownState extends State<CustomMultiselectDropDown> {
  List<String> listOFSelectedItem = [];
  String selectedText = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: ExpansionTile(
        iconColor: Colors.grey,
        title: Text(
          listOFSelectedItem.isEmpty ? "Select" : listOFSelectedItem[0],
        ),
        children: <Widget>[
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.listOFStrings.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                child: _ViewItem(
                    item: widget.listOFStrings[index],
                    selected: (val) {
                      selectedText = val;
                      if (listOFSelectedItem.contains(val)) {
                        listOFSelectedItem.remove(val);
                      } else {
                        listOFSelectedItem.add(val);
                      }
                      widget.selectedList(listOFSelectedItem);
                      setState(() {});
                    },
                    itemSelected: listOFSelectedItem
                        .contains(widget.listOFStrings[index])),
              );
            },
          ),
        ],
      ),
    );
  }
}
