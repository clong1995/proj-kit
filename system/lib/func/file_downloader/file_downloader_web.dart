import 'dart:typed_data';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

Future<String?> saveFile(Uint8List data, String filename) async {
  final blob = html.Blob([data]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  html.AnchorElement(href: url)
    ..setAttribute("download", filename)
    ..click();
  html.Url.revokeObjectUrl(url);
  return null;
}
