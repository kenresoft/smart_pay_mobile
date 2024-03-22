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

  static String getFirstName(String fullName) {
    List<String> nameParts = fullName.split(' ');
    if (nameParts.isNotEmpty) {
      return nameParts.first;
    } else {
      return ''; // Return an empty string if full name is empty or invalid
    }
  }
}
