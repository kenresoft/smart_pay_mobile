import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  Future<Map<String, dynamic>> authenticateUser(String email, String otpCode) async {
    const apiUrl = 'https://mobile-test-2d7e555a4f85.herokuapp.com/api/v1/auth/email/verify';

    try {
      final response = await http.post(Uri.parse(apiUrl), body: {
        'email': email,
        'token': otpCode,
      });

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': responseData['status'] == true,
          'message': responseData['message'],
          'data': responseData['data'],
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to authenticate. Please try again later.',
          'data': null,
        };
      }
    } catch (error) {
      return {
        'success': false,
        'message': 'An error occurred: $error',
        'data': null,
      };
    }
  }
}
