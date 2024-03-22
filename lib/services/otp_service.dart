import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smart_pay_mobile/utils/constants.dart';

class OtpService {
  Future<Map<String, dynamic>> getToken(String email, String token) async {
    const apiUrl = '${Constants.baseUrl}/auth/email/verify';

    try {
      final response = await http.post(Uri.parse(apiUrl), body: {
        'email': email,
        'token': token,
      });

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
    } catch (error) {
      return {
        'success': false,
        'message': 'An error occurred: $error',
        'data': null,
      };
    }
  }
}
