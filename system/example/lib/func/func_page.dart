import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:system/func/file_downloader/file_downloader.dart';
import 'package:system/func/file_picker.dart';

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
                Uint8List data = await FileDownloader.downloadFile(
                    "https://bj-eschool.oss-cn-beijing.aliyuncs.com/template/%E5%AD%A6%E7%94%9F%E4%BF%A1%E6%81%AF%E9%87%87%E9%9B%86.xlsx");
                //send(uri, jsonString)
                await FileDownloader.saveFile(data, 'xxx.xlsx');
              },
              child: const Text("下载模板")),
          FilledButton(
              onPressed: () async {
                Uint8List data = await FileDownloader.downloadFile(
                    "https://bj-eschool.oss-cn-beijing.aliyuncs.com/template/%E5%AD%A6%E7%94%9F%E4%BF%A1%E6%81%AF%E9%87%87%E9%9B%86.xlsx");
                //send(uri, jsonString)
                // final data  =   await FilePickerWrapper.pickFile(allowedExtensions: ['xlsx']);
                final excel = Excel.decodeBytes(data);
                final list = Uint8List.fromList(excel.encode() ?? []);
                //  final sheet = excel.sheets['学生信息'];

                /*
              sheet
                    ?.cell(
                        CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 4))
                    .value = TextCellValue("测试");

                    excel.copy(sheet!.sheetName, "学生成绩");
                    */
               // excel.save();
                debugPrint("原始数据长度: ${data.length}");
                debugPrint("修改后数据长度: ${excel.encode()?.length}");
               // await FileDownloader.saveFile(list, "myName.xlsx");
              },
              child: const Text("修改更新 模板")),
        ],
      ),
    );
  }
}
