import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smart_pay_mobile/utils/constants.dart';

class SignInService {
  static const url = '${Constants.baseUrl}/auth/login';

  static Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
    required String deviceName,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          'device_name': deviceName,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      } else if (response.statusCode == 422) {
        final Map<String, dynamic> errorResponse = jsonDecode(response.body);
        final Map<String, dynamic> errors = errorResponse['errors'];
        return {'status': false, 'message': errorResponse['message'], 'errors': errors};
      } else {
        // Handle other status codes if needed
        return {'error': jsonDecode(response.body)['message']};
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
