import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'file_downloader_stub.dart'
    if (dart.library.html) 'file_downloader_web.dart'
    if (dart.library.io) 'file_downloader_io.dart' as file_download;

class FileDownloader {
  // 下载文件并返回字节数据
  static Future<Uint8List> downloadFile(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('文件下载失败: 状态码 = ${response.statusCode}');
    }
  }

  // 适配保存文件的方法
  static Future<String?> saveFile(Uint8List data, String filename) async {
   return await file_download.saveFile(data, filename);
  }

  // 直接下载到本地
  static Future<String?> downloadLinkFile({required String url, required String filename}) async {
    final data = await downloadFile(url);
    return await file_download.saveFile(data, filename);
  }
}
