import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_pay_mobile/utils/constants.dart';

class SignUpService {

  Future<Map<String, dynamic>> authenticateEmail(String email) async {
    final Uri apiUrl = Uri.parse('${Constants.baseUrl}/auth/email');
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
      } else if (response.statusCode == 422) {
        final Map<String, dynamic> errorResponse = jsonDecode(response.body);
        final Map<String, dynamic> errors = errorResponse['errors'];
        return {'status': false, 'message': errorResponse['message'], 'errors': errors};
      } else {
        // Handle other status codes if needed
        return {'error': jsonDecode(response.body)['message']};
      }
    } catch (error) {

      return {'error': error};
    }
  }
}
