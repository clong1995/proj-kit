import 'dart:io';

import 'package:path_provider/path_provider.dart';
import '/func/datetime_format.dart';

import '../log_mixin.dart';

class _Log with LogMixin {
  String _logPrefix = "";

  Future<File> _getlogFile() async {
    final directory = await getApplicationDocumentsDirectory();
    var date = DateTimeFormat.toStr(DateTime.now(), "yyyyMMdd");
    String dir = Uri.file(Directory.current.path).pathSegments.last;
    String path = directory.path;
    if (dir != "") {
      path = "$path/$dir";
    }
    if (_logPrefix != "") {
      path = "$path/${_logPrefix}_$date.log";
    } else {
      path = "$path/$date.log";
    }
    var file = File(path);
    if (!file.existsSync()) file.createSync(recursive: true);
    return file;
  }

  @override
  void init({String? logPrefix}) {
    _logPrefix = logPrefix ?? "";
  }

  @override
  Future<void> log(String message) async {
    File file = await _getlogFile();
    var datestamp = DateTimeFormat.toStr(DateTime.now(), "yyyy-MM-dd HH:mm:ss");
    await file.writeAsString("$datestamp $message\r\n", mode: FileMode.append);
  }
}

var log = _Log();
