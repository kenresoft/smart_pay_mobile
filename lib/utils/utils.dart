import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class Utils {
  static Future<String?> getDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo? androidInfo;
    IosDeviceInfo? iosInfo;

    try {
      if (!kIsWeb) {
        if (defaultTargetPlatform == TargetPlatform.android) {
          androidInfo = await deviceInfo.androidInfo;
          return androidInfo.model;
        } else if (defaultTargetPlatform == TargetPlatform.iOS) {
          iosInfo = await deviceInfo.iosInfo;
          return iosInfo.name;
        }
      }
    } catch (e) {
      print('Error getting device name: $e');
    }
    return null;
  }

  static String getFirstName(String? fullName) {
    if (fullName == null || fullName.trim().isEmpty) {
      return ''; // Return an empty string if fullName is null or empty
    }

    if (fullName.trim().split(' ').length > 1) {
      List<String> nameParts = fullName.trim().split(' ');
      return nameParts.first;
    } else {
      return fullName.trim(); // Return the full name as is if it's a single word
    }
  }


  static String? maskEmail(String email) {
    if (email.isEmpty || !email.contains('@')) {
      return null; // Return the original email if it's empty or doesn't contain '@'
    }

    List<String> parts = email.split('@');
    String maskedUsername = parts[0][0] + '*' * (parts[0].length - 1); // Mask the username part
    return '$maskedUsername@${parts[1]}';
  }
}
