import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUpService {
  static const String baseUrl = 'https://mobile-test-2d7e555a4f85.herokuapp.com/api/v1';

  Future<Map<String, dynamic>> authenticateEmail(String email) async {
    final Uri apiUrl = Uri.parse('$baseUrl/auth/email'); // Example endpoint for email authentication
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    final Map<String, dynamic> body = {
      'email': email,
    };

    try {
      final http.Response response = await http.post(apiUrl, headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      } else {
        return {'error': 'Failed to connect to the server. Please try again later.'};
      }
    } catch (error) {
      return {'error': 'An error occurred. Please try again later.'};
    }
  }
}
