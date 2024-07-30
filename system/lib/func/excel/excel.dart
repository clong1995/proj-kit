/*
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';

class ExcelConfig {}

String? cellValueToStr(CellValue? value) {
  switch (value) {
    case null:
      return null;
    case TextCellValue():
      return value.value;
    case FormulaCellValue():
      return value.toString();
    case IntCellValue():
      return "${value.value}";
    case BoolCellValue():
      return value.value ? '是' : '否';
    case DoubleCellValue():
      return "${value.value}";
    case DateCellValue():
      String year = value.year.toString();
      String month = value.month.toString().padLeft(2, '0');
      String day = value.day.toString().padLeft(2, '0');
      return "$year-$month-$day 00:00:00";
    case TimeCellValue():
      String h = value.hour.toString().padLeft(2, '0');
      String m = value.minute.toString().padLeft(2, '0');
      return "$h:$m";
    case DateTimeCellValue():
      String year = value.year.toString();
      String month = value.month.toString().padLeft(2, '0');
      String day = value.day.toString().padLeft(2, '0');
      String h = value.hour.toString().padLeft(2, '0');
      String m = value.minute.toString().padLeft(2, '0');
      String s = value.second.toString().padLeft(2, '0');
      return "$year-$month-$day $h:$m:$s";
  }
}

class SheetConfig {
  final List<String> headers;
  final int ignoreRows;
  final int? index;
  final String? sheetName;
  final String? key;

  SheetConfig(
      {this.index,
      this.sheetName,
      this.key,
      this.headers = const [],
      this.ignoreRows = 0})
      : assert(key == null || headers.contains(key),
            "headers must contains the key: $key");
}

typedef SheetRowData = Map<String, List<Value>>;
typedef SheetHeader = List<String>;
typedef ExcelData = Map<String, List<SheetRowData>>;

class Value {
  final String? value;
  final String colName;

  Value(this.value, this.colName);

  // 重写 == 运算符
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is Value && value == other.value && other.colName == colName;
  }

  // 重写 hashCode 属性
  @override
  int get hashCode => value.hashCode ^ colName.hashCode;

  @override
  String toString() => 'Value(value: $value, age: $colName)';

  Map<String, dynamic> toJson() {
    return {'value': value, 'colName': colName};
  }
}

ExcelData readExcel(Excel excel, SheetConfig sheetConfig) {
  ExcelData data = ExcelData();
  List<SheetRowData> sheetValues = [];
  for (var sheet in excel.sheets.values) {
    if (sheet.rows.isEmpty) continue;
    if (sheet.rows.length <= sheetConfig.ignoreRows) continue;
    final rows = sheet.rows.sublist(sheetConfig.ignoreRows);
    if (rows.isEmpty) continue;
    // 遍历headers
    //Map<String, int> headMap = {};
    Map<int, String> headerIndex = {};
    Map<String, int> headerMap = {};
    // 寻找对应头所在的列 <索引:标题>
    headerIndex = rows[0].fold(headerIndex, (map, d) {
      final value = cellValueToStr(d?.value);
      debugPrint(value);
      if (d != null && value != null && value.trim() != "") {
        if (sheetConfig.headers.where((h) => value.startsWith(h)).isNotEmpty) {
          map[d.columnIndex] = value;
        }
      }
      return map;
    });
    // 寻找对应头所在的列 <标题:索引>
    headerMap = rows[0].fold(headerMap, (map, d) {
      final value = cellValueToStr(d?.value);
      if (d != null && value != null && value.trim() != "") {
        if (sheetConfig.headers.where((h) => value.startsWith(h)).isNotEmpty) {
          map[value] = d.columnIndex;
        }
      }
      return map;
    });

    debugPrint(headerIndex.keys.toString());
    debugPrint(headerMap.keys.toString());

    // 保证 excel 列数量大于需要数量
    if (headerMap.keys.length < sheetConfig.headers.length) {
      debugPrint("当前sheet不符合要求:保证 excel 列数量小于需要数量");
      continue;
    }
    // 保证配置中的 headers 都在excel头中出现过。
    final exists = sheetConfig.headers.any((h) {
      return headerMap.keys.where((e) => e.startsWith(h)).isNotEmpty;
    });
    if (!exists) {
      debugPrint("当前sheet不符合要求:配置中的一些列没有出现过!");
      continue;
    }
    // 获取实际的数据行,并将每个单元格数据转化为Value(colName,value)
    // 并删除都为 [null] 的行
    // 因为我们已经知道每一列对应的 标题  headerIndex[colmIndex]
    // 本次处理结果就是将每一列转化为我们需要的格式 Value(colName,value)
    var dataRows = sheet.rows.skip(sheetConfig.ignoreRows + 1).map((row) {
      return row
          .where((d) => d != null && headerIndex[d.columnIndex] != null)
          .map((d) {
        return Value(cellValueToStr(d?.value), headerIndex[d?.columnIndex]!);
      }).toList();
    }).toList();

    var targetKey = "";
    // 如果配置已经设定了key，就需要找到 key全名称
    if (sheetConfig.key != null) {
      final keys = headerMap.keys.where((k) => k.startsWith(sheetConfig.key!));
      if (keys.isNotEmpty) targetKey = keys.elementAt(0);
    }
    debugPrint("target key = $targetKey");
    // 验证target key 所在列的数据是否唯一
    if (targetKey != "") {
      if (headerMap[targetKey] == null) {
        continue;
      }
      int columnIndex = headerMap[targetKey]!;
      dataRows =
          dataRows.where((row) => row[columnIndex].value != null).toList();
      if (dataRows.map((d) => d[columnIndex]).toSet().length !=
          dataRows.length) {
        debugPrint("target key 存在重复");
        continue;
      }
    } else {
      // 过滤空行
      dataRows = dataRows
          .where((row) =>
              row.where((v) => v.value != null && v.value != "").isNotEmpty)
          .toList();
    }
    debugPrint("保证 targetKey 对应的列数据唯一");
    sheetValues = [];
    for (int i = 0; i < dataRows.length; i++) {
      SheetRowData dataMap = SheetRowData();
      // 如果未设置key，则使用行序号作为key值

      final String dataKey = sheetConfig.key == null
          ? "$i"
          : dataRows[i].firstWhere((v) => v.colName == targetKey).value!;

      final list = dataRows[i];
      dataMap[dataKey] = list;
      sheetValues.add(dataMap);
    }
    data[sheet.sheetName] = sheetValues;
    // 当前 sheet 就是 sheetConfig 的数据
  }
  return data;
}*/
