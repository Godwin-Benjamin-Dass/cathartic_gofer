import 'dart:convert';

import 'package:http/http.dart' as http;

class NotificationService {
  static Future<void> postData(String title, String body, String token) async {
    final url =
        Uri.parse('https://message-3pso.onrender.com/api/notification/send');
    final Map<String, dynamic> data = {
      "title": title,
      "body": body,
      "receiverToken": token
    };
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('Response: ${response.statusCode}');
    } else {
      print('Failed to make POST request. Status code: ${response.statusCode}');
      print('Response: ${response}');
    }
  }
}
