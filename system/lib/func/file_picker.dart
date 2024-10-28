



import 'package:file_picker/file_picker.dart';

class FilePickerWrapper {
  static Future<List<int>?> pickFile({List<String>? allowedExtensions}) async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
      allowMultiple: false,
    );
    /*
    List<int>? dataBytes;
    if (!kIsWeb) {
      final excelFile = pickedFile?.files.single.path;
      if (excelFile != null) {
        dataBytes = await File(excelFile).readAsBytes();
      }
    } else {
      dataBytes = pickedFile?.files.single.bytes;
    }*/
    return  pickedFile?.files.single.bytes;
  }
}
