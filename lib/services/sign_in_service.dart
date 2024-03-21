import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_pay_mobile/constants.dart';

class LoginService {
  static Future<bool> login(String email, String password) async {
    String apiUrl = '${Constants.baseUrl}/auth/login';

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'email': email.trim(),
          'password': password.trim(),
          'device_name': 'web',
        },
      );

      if (response.statusCode == 200) {
        // Parse response JSON
        var responseData = jsonDecode(response.body);
        var status = responseData['status'];
        var errors = responseData['errors'];

        if (status == true) {
          // Login successful
          return true;
        } else if (errors != null && errors.isNotEmpty) {
          // Handle errors in the error object
          print('Errors in response: $errors');
          return false;
        } else {
          // Unexpected response format
          print('Unexpected response format');
          return false;
        }
      } else {
        // Handle other HTTP errors
        print('Error: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      // Handle exceptions
      print('Exception during login: $e');
      return false;
    }
  }
}
