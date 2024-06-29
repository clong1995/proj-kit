import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

import 'md5.dart';

Future<String> guid() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (kIsWeb) {
    Map<String, dynamic> data = (await deviceInfo.webBrowserInfo).data;
    List<String> sortedKeys = data.keys.toList()..sort();
    Map<String, String> sortedMap = {
      for (var key in sortedKeys) key: data[key].toString()
    };
    String jsonString = jsonEncode(sortedMap);
    return Md5.str(jsonString);
  } else if (defaultTargetPlatform == TargetPlatform.windows) {
    return (await deviceInfo.windowsInfo).deviceId;
  } else if (defaultTargetPlatform == TargetPlatform.linux) {
    return (await deviceInfo.linuxInfo).machineId ?? "";
  } else if (defaultTargetPlatform == TargetPlatform.macOS) {
    return (await deviceInfo.macOsInfo).systemGUID ?? "";
  } else if (defaultTargetPlatform == TargetPlatform.android) {
    return (await deviceInfo.androidInfo).id;
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    return (await deviceInfo.iosInfo).identifierForVendor ?? "";
  }
  return "";
}
