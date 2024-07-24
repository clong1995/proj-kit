import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:kit/nio.dart';

import '/func/auth.dart';
import '/widget/toast.dart';
import 'src/send.dart';

//方便kit使用
Future<T> nio<S extends BaseReq, T extends BaseRes>(
  String uri, {
  S? req,
  T? res,
  Uint8List? binary,
}) async {
  //初始化返回值
  res ??= EmptyRes() as T;

  if (uri.isEmpty) {
    res.state = "url为空";
    Toast.show(res.state);
    return res;
  }

  req ??= EmptyReq() as S;

  //参数
  req.t = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  req.a = Auth.accessKeyID;

  //转string
  String jsonString = jsonEncode(req);

  //发送数据
  Map<String, dynamic> result = await send(
    uri,
    jsonString,
    binary: binary,
  );
  res.state = result["state"];
  dynamic data = result["data"];
  if (data == null) {
    return res;
  }

  res.data = data;
  //序列化数据
  try {
    res.fromJson();
  } catch (e) {
    Toast.show(e.toString());
    rethrow;
  }
  return res;
}
