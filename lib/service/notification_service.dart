import 'dart:convert';

import 'package:http/http.dart' as http;

class NotificationService {
  static Future<void> postData() async {
    final url = Uri.parse(
        'https://message-3pso.onrender.com/send'); 
    final Map<String, dynamic> data = {
      "title": "APPLICATION",
      "body": "NOTIFICATION",
      "receiverToken":
          "cNWRRp64QVa2xAF3Y1rNte:APA91bGfh5DZomevW0_hT2tw3H3UEVRmmXKMYh7SmKQH_d4k6Rt589C0GPyp1G_IKyTduq3NZY1jndmeUuWjuJ3KUI6W9nxT1RxQkz6MkO2l0JYNL5_NAVXL1iTNmKlbMNVFTzH_zqYL"
    };
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data), 
    );

    if (response.statusCode == 200) {
      print('Response: ${response.body}');
    } else {
      print('Failed to make POST request. Status code: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  }
}
