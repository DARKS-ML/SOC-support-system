import 'dart:developer';

import 'package:http/http.dart' as http;

class GlobalalService {
  // Notification result data
  static Future notification() async {
    try {
      final response = await http.get(
        Uri.parse(
          "http://127.0.0.1:8000/api/v1/notification/",
        ),
      );
      final responseBody = [response.statusCode, response.body];
      log(responseBody.toString());
      return responseBody;
    } catch (e) {
      rethrow;
    }
  }
}
