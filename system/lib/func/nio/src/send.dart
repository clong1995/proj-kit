import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../auth.dart';
import '../../md5.dart';
import '/widget/toast.dart';

String _host = "";
String _userAgent = "";

void sendHost(String host, String userAgent) {
  String urlPattern = r'^(https?:\/\/)?' // 协议
      r'((([a-zA-Z0-9\-]+\.)+[a-zA-Z]{2,})|' // 域名
      r'((\d{1,3}\.){3}\d{1,3}))' // 或者IP地址
      r'(:\d+)?(\/[-a-zA-Z0-9@:%_\+.~#?&//=]*)?$'; // 端口和路径
  RegExp urlRegExp = RegExp(urlPattern);
  if (!urlRegExp.hasMatch(host)) {
    throw "host 格式错误 $host";
  }
  _host = host;
  _userAgent = userAgent;
}

Future<Map<String, dynamic>> send(
  String uri,
  String jsonString, {
  Uint8List? binary,
}) async {
  //loading
  bool loading = false;
  Timer timer = Timer(const Duration(seconds: 3), () {
    loading = true;
    Toast.loading("处理中...");
  });

  //请求地址
  Uri url = Uri.parse(_host + uri);

  //返回结果
  Map<String, dynamic> res = {
    "state": "",
  };

  String paramSig = _sign(jsonString);
  int code;
  String? sig;
  String body;
  if (binary != null && binary.isNotEmpty) {
    StreamedResponse resp;
    try {
      // 创建多部分请求
      var request = MultipartRequest(
        'POST',
        url, // 请求的URL
      );
      // 设置请求头
      request.headers['Content-Sign'] = paramSig;

      // 添加二进制数据
      request.files.add(MultipartFile.fromBytes(
        'file',
        binary,
        filename: 'binary_data',
      ));
      // 添加其他字段
      request.fields['body'] = jsonString;
      // 发送请求
      resp = await request.send().timeout(const Duration(seconds: 10));
    } on TimeoutException catch (e) {
      _log(url, paramSig, jsonString, "$e");
      res["state"] = "接口超时";
      Toast.show(res["state"]);
      return res;
    } catch (e) {
      _log(url, paramSig, jsonString, "$e");
      res["state"] = "接口请求失败";
      Toast.show(res["state"]);
      return res;
    } finally {
      //请求结束，关闭loading等待
      timer.cancel();
      if (loading) {
        Toast.dismiss();
      }
    }
    code = resp.statusCode;
    sig = resp.headers["x"];
    body = await resp.stream.bytesToString();
  } else {
    Response resp;
    Map<String, String> headers = {"content-sign": paramSig};
    if (!kIsWeb) {
      headers["User-Agent"] = _userAgent;
    }
    try {
      resp = await post(
        url,
        headers: headers,
        body: jsonString,
      ).timeout(const Duration(seconds: 10));
    } on TimeoutException catch (e) {
      _log(url, paramSig, jsonString, "$e");
      res["state"] = "接口超时";
      Toast.show(res["state"]);
      return res;
    } catch (e) {
      _log(url, paramSig, jsonString, "$e");
      res["state"] = "接口请求失败:$e";
      Toast.show(res["state"]);
      return res;
    } finally {
      //请求结束，关闭loading等待
      timer.cancel();
      if (loading) {
        Toast.dismiss();
      }
    }
    code = resp.statusCode;
    sig = resp.headers["content-sign"];
    body = resp.body;
  }
  //状态码
  if (code != 200) {
    res["state"] = "接口错误码:$code";
    _log(url, paramSig, jsonString, res["state"]);
    Toast.show(res["state"]);
    if (code == 406) {
      //签名错误
      //Auth.clean();
    }
    return res;
  }

  //提取签名
  if (sig == null || sig == "") {
    //没有签名
    res["state"] = "接口没有签名";
    _log(url, paramSig, jsonString, res["state"]);
    Toast.show(res["state"]);
    return res;
  }

  //校验
  if (!_verifySign(body, sig)) {
    res["state"] = "接口签名错误";
    _log(url, paramSig, jsonString, res["state"]);
    Toast.show(res["state"]);
    return res;
  }

  //序列化
  Map<String, dynamic> jsonMap = jsonDecode(body);

  //手动序列化外围字段
  dynamic state = jsonMap["state"];
  if (state == null) {
    res["state"] = "未发现state字段,返回值不满足序列化条件";
    _log(url, paramSig, jsonString, res["state"]);
    Toast.show(res["state"]);
    return res;
  }

  //出现错误，也不序列化
  if (state != "OK") {
    res["state"] = state;
    _log(url, paramSig, jsonString, res["state"]);
    Toast.show(res["state"]);
    return res;
  }

  //检查时间
  dynamic timestamp = jsonMap["timestamp"];
  if (timestamp == null) {
    res["state"] = "未发现timestamp字段,返回值不满足序列化条件";
    _log(url, paramSig, jsonString, res["state"]);
    Toast.show(res["state"]);
    return res;
  }
  /* int now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  int st = timestamp as int;

  if (!(st - 5 <= now && now <= st + 10)) {
    res["state"] = "请求失效";
    _log(url, paramSig, jsonString, res["state"]);
    Toast.show(res["state"]);
    return res;
  }*/

  _log(url, paramSig, jsonString, body);

  //满足需求
  res["state"] = state;

  //数据
  dynamic data = jsonMap["data"];
  if (data == null) {
    //不序列化
    return res;
  }
  res["data"] = data;
  return res;
}

void _log(Uri url, String paramSig, String req, String res) {
  print("┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
  print("┃ 地址: $url");
  print("┃ 签名: $paramSig");
  print("┃ 参数: $req");
  print("┃ 结果: $res");
  print("┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
}

String _sign(String message) {
  if (message == "") {
    return "";
  }
  return Md5.str(message + Auth.secretAccessKey);
}

//验证
bool _verifySign(String message, String signature) {
  if (message == "" || signature == "") {
    return false;
  }
  return signature == _sign(message);
}
