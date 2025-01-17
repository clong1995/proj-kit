import 'package:package_info_plus/package_info_plus.dart';

Future<String> appVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}
