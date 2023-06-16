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
            'key=AAAAw5EslJU:APA91bEXg4QzADxHk0SapmwbCZjqESAy_S0-KGJd0m_8u1st6BDlfhFiHZkymrIVQDZPAYQVc6unyr4k_cQvPsss-1LHMw7q0ZvL67tdE-Qm1YrBAit2RqFptnBT8oitJ-ZE-kmNJs1R',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body':
                "would you like to join group of people with similar cuisines interest",
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
