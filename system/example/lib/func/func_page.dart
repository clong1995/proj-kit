import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:system/func/file_downloader/file_downloader.dart';

class FuncPage extends StatelessWidget {
  const FuncPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilledButton(
              onPressed: () async {
      Uint8List data =   await  FileDownloader.downloadFile("https://bj-eschool.oss-cn-beijing.aliyuncs.com/template/%E5%AD%A6%E7%94%9F%E4%BF%A1%E6%81%AF%E9%87%87%E9%9B%86.xlsx");
                //send(uri, jsonString)
             await  FileDownloader.saveFile(data, 'xxx.xlsx');
              },
              child: const Text("下载模板")),
        ],
      ),
    );
  }
}
