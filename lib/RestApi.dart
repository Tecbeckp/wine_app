import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService {
  ApiService._();

  static final ApiService _instance = ApiService._();

  static ApiService get instance => _instance;
  var token = "".obs;

  static sendNotification(fcmToken, groupTitle) async {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAAzlZli8E:APA91bE-7xiIUZ6y5W3t1vXY6c8H_GBIDG34XL94oTstAHeCQn7te4ePGSzhhGLxJQ434_x-jBHnieAnLknXcudd8mkj7C-8Vgb5PWZs0r60VXlZ2NF42DYbTcO1NagpWRlL_3RDndt-',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body':
                "would you like to join group of people with similar problems",
            'title': "Group creation",
            'sound': 'default'
          },
          'priority': 'normal',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'groupTitle': groupTitle,
            'status': 'done'
          },
          'to': fcmToken.toString()
        },
      ),
    );
  }
}
