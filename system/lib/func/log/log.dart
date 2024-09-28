import 'logic/log_stub.dart'
    if (dart.library.html) 'logic/log_web.dart'
    if (dart.library.io) 'logic/log_desktop.dart' as l;

Future<void> log(String message) async {
  l.log.log(message);
}
