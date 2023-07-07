import 'package:bordeaux/screens/login_screen.dart';
import 'package:bordeaux/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'common_widgets/page_transition.dart';
import 'controllers/general_controller.dart';
import 'helpers/commonDialogBox.dart';
import 'helpers/constants.dart';
import 'screens/group_chat_screen.dart';

Future<void> _handleMessage(RemoteMessage message) async {
  print("_handleMessage");
  print(message);
  bool login = await getUserLoggedIn();
  if (login) {
    var userid = await getUserData();

    customDialog.showErrorDialog(
      title: "Group Join",
      description: "want to join group of people with similar issues ? ",
      btnNoPressed: () {
        Get.back();
      },
      btnYesPressed: () {
        PageTransition.fadeInNavigation(
            page: GroupChatScreen(
          addingMember: true,
          groupTitle: groupNotificationTitle,
        ));
      },
    );
  } else {
    PageTransition.fadeInNavigation(page: const LoginScreen());
  }
}

Future<void> onSelectNotification(String? payload) async {
  print("onSelectNotification");
  print(payload);

  bool login = await getUserLoggedIn();
  if (login) {
    var userid = await getUserData();

    customDialog.showErrorDialog(
      title: "Group Join",
      description: "want to join group of people with similar issues ? ",
      btnNoPressed: () {
        Get.back();
      },
      btnYesPressed: () {
        PageTransition.fadeInNavigation(
            page: GroupChatScreen(
          addingMember: true,
          groupTitle: groupNotificationTitle,
        ));
      },
    );
  } else {
    PageTransition.fadeInNavigation(page: const LoginScreen());
  }
}

Future<void> _selectNotification(RemoteMessage message) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      const AndroidNotificationDetails(
          'high_importance_channel', 'High Importance Notifications',
          importance: Importance.high,
          priority: Priority.high,
          icon: "@mipmap/ic_launcher");
  NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  print("message.data");
  groupNotificationTitle = message.data['groupTitle'];

  await FlutterLocalNotificationsPlugin().show(123, message.notification!.title,
      message.notification!.body, platformChannelSpecifics,
      payload: 'data');

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings();
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  FlutterLocalNotificationsPlugin().initialize(initializationSettings,
      onSelectNotification: onSelectNotification);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((_handleMessage));
  FirebaseMessaging.onMessage.listen((_selectNotification));

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title // description
      importance: Importance.high,
      playSound: true);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  FirebaseMessaging.instance.requestPermission(
      sound: true, badge: true, alert: true, provisional: true);
  /*  payload = await notificationAppLaunchDetails!.payload;
  if (payload != null) {
    route = '/second';
  } */
//  Stripe.publishableKey =
  //    "pk_test_51N8u8JAvobntCO1MbPMHxQhCk5liwtZV3yNANTx4ZkFIXBm1LUgFejyLM02EYiSrgzgU1QixFMoJVDPnV6IvVnIG00Fi2iaR7R";
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    getFCM();
  }

  getFCM() async {
    FirebaseMessaging.instance.getToken().then((value) {
      fcmToken.value = value!;
      print("Token saved");
      print(fcmToken.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, deviceType) {
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.black,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
        );
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);

        Get.put(GeneralController());

        return GetMaterialApp(
          title: 'Tylt',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Interregular',
          ),
          home: const SplashScreen(),
          //HealthApp()
        );
      },
    );
  }
}
