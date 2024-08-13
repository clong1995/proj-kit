import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<Widget?> checkUpdate({
  required String versionStore,
  required void Function() callBack,
}) async {
  void Function(double)? updateProgress;
  //获取当前版本
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String appVersion = "${packageInfo.version}+${packageInfo.buildNumber}";
  String appName = packageInfo.appName;

  Response resp = await get(
    Uri.parse("$versionStore/versions.json"),
  );
  if (resp.statusCode != 200) {
    callBack();
    return null;
  }
  dynamic jsonArray = jsonDecode(utf8.decode(resp.bodyBytes));
  List<_VersionData> versionList =
      jsonArray.map<_VersionData>((e) => _VersionData.fromJson(e)).toList();
  if (versionList.isEmpty) {
    callBack();
    return null;
  }
  _VersionData newVersion = versionList.first;
  if (newVersion.version == appVersion) {
    callBack();
    return null;
  }

  String downloadUrl =
      "$versionStore/version/$appName-${newVersion.version}.exe";

  if (!newVersion.force) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          if (newVersion.description.isNotEmpty) Text(newVersion.description),
          const SizedBox(height: 15),
          _Progress(
            update: (void Function(double) update) async {
              updateProgress = update;
            },
          ),
          const SizedBox(height: 15),
          const Text("是否更新?"),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: callBack,
                child: const Text("稍后提醒"),
              ),
              const SizedBox(
                width: 10,
              ),
              FilledButton(
                onPressed: () async {
                  await _updateApp(downloadUrl, updateProgress);
                  callBack();
                },
                child: const Text("现在更新"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        if (newVersion.description.isNotEmpty) Text(newVersion.description),
        const SizedBox(
          height: 15,
        ),
        _Progress(
          update: (void Function(double) update) async {
            await _updateApp(downloadUrl, update);
            callBack();
          },
        ),
        const SizedBox(
          height: 15,
        ),
        const Text("正在更新中..."),
      ],
    ),
  );
}

class _VersionData {
  final String version;
  final bool force;
  final String description;

  _VersionData({
    required this.version,
    required this.force,
    required this.description,
  });

  factory _VersionData.fromJson(dynamic json) => _VersionData(
        version: json['version'] ?? "",
        force: json['force'] ?? false,
        description: json['description'] ?? "",
      );
}

class _Progress extends StatefulWidget {
  final void Function(void Function(double)) update;

  const _Progress({
    required this.update,
  });

  @override
  State<_Progress> createState() => _ProgressState();
}

class _ProgressState extends State<_Progress> {
  double value = 0;

  @override
  void initState() {
    super.initState();
    widget.update(update);
  }

  @override
  Widget build(BuildContext context) => CircularProgressIndicator(value: value);

  void update(double val) => setState(() {
        value = val;
      });
}

Future<void> _updateApp(
  String downloadUrl,
  void Function(double)? updateProgress,
) async {
  final Directory temporaryDirectory = await getTemporaryDirectory();
  String filePath = join(
      temporaryDirectory.path, "${DateTime.now().microsecondsSinceEpoch}.exe");
  final File newApp = File(filePath);
  if (!newApp.existsSync()) {
    await newApp.create(recursive: true);
  }
  Completer<bool> completer = Completer<bool>();
  downloadUrl = downloadUrl.replaceAll('+', '%2B');
  Request request = Request('GET', Uri.parse(downloadUrl));

  StreamedResponse response = await request.send();
  int contentLength = response.contentLength ?? 0;
  List<int> bytes = [];
  response.stream.listen(
    (List<int> newBytes) {
      bytes.addAll(newBytes);
      if (bytes.isNotEmpty) {
        updateProgress?.call(bytes.length / contentLength);
      }
    },
    onDone: () async {
      completer.complete(true);
    },
    onError: (e) {},
    cancelOnError: true,
  );
  await completer.future;
  await newApp.writeAsBytes(bytes, flush: true);
  ProcessResult result = await Process.run(newApp.path, []);
  if (result.exitCode == 0) {
    /*Future.delayed(const Duration(seconds: 1), (){
        exit(0);
      });*/
  }
  return;
}
