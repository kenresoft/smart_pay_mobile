import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_pay_mobile/utils/constants.dart';

class IdentityService {
  static const String url = '${Constants.baseUrl}/auth/register';

  static Future<Map<String, dynamic>> registerUser({
    required String fullName,
    required String userName,
    required String email,
    required String password,
    required String countryCode,
    required String deviceName,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(url), // Replace 'register' with your actual registration endpoint
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'full_name': fullName,
          'username': userName,
          'email': email,
          'password': password,
          'country': countryCode,
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
        return {'error': jsonDecode(response.body)['message']};
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
