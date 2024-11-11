
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kit/def.dart';
import 'package:kit/kit.dart';
import 'package:package/package.dart';
import 'package:package/register.dart' as reg;
import 'package:rpx/rpx.dart';
import 'package:system/func/app_version.dart';
import 'package:system/func/bridge/bridge.dart';
import '/func/log/log.dart';
import 'package:ui_adapt/ui_adapt.dart';
import 'package:ui_page_view_item/ui_page_view_item.dart';
import 'package:ui_table/ui_table.dart';

import 'builder.dart';
import 'func/auth.dart';
import 'func/certificates.dart';
import 'func/check_update.dart';
import 'func/datetime_format.dart';
import 'func/desktop_state.dart';
import 'func/file_downloader/file_downloader.dart';
import 'func/file_picker.dart';
import 'func/nav.dart';
import 'func/nio/nio.dart';
import 'func/nio/src/send.dart';
import 'func/sid.dart';
import 'theme.dart';
import 'widget/alert/confirm.dart';
import 'widget/alert/custom.dart';
import 'widget/alert/delete.dart';
import 'widget/alert/info.dart';
import 'widget/cached_image.dart';
import 'widget/check_button.dart';
import 'widget/date_picker.dart';
import 'widget/delete_button.dart';
import 'widget/desktop_bar.dart';
import 'widget/drop_button.dart';
import 'widget/input.dart';
import 'widget/multiple_drop_button.dart';
import 'widget/search_input.dart';
import 'widget/toast.dart';
import 'widget/tool_bar.dart';
import 'func/window_manager/window_manager.dart' as wm;

Future<void> kitInit(
  Iterable<Register Function()> registers, {
  //请求地址的host，如 https://api.abc.com
  required String host,
  required String userAgent,
  //null:根据屏幕自动适配,
  //0:不使用适配
  //数字: 按照指定大小适配
  double? rpx,
  //窗体大小
  Size? windowSize,
}) async {
  if (!kIsWeb) {
    setCertificates();
  }
  //系统设置
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
  ));

  //注册包
  Package.register(registers.map((Register Function() element) => () {
        Register r = element();
        return reg.Register(r.name, r.packageBuilder);
      }));

  //设置全局的请求host
  sendHost(host, userAgent);

  //竖屏
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // web大小
  if (windowSize != null && kIsWeb) {
    BridgeFactory.webBridge()
        .setWindowSize(windowSize.width, windowSize.height);
  }

  await wm.windowManager.init(windowSize);

  //单位
  Rpx.init(rpx);

  //初始化kit
  kit = Kit(
      rpx: Rpx.rpx,
      appTheme: appTheme(),
      builder: builder,
      //包管理
      package: Package.package,
      //网络图片
      cachedImage: CachedImage.image,
      //自适应
      adaptBox: UiAdapt.new,
      //弹窗
      alertConfirm: confirm,
      alertDelete: delete,
      alertInfo: info,
      alertCustom: custom,
      alertContent: CustomContent.new,
      //输入框
      input: Input.new,
      //工具栏
      toolBar: ToolBar.new,
      //搜索框
      searchInput: SearchInput.new,
      //表格
      table: UiTable.new,
      //凭证
      authInit: Auth.init,
      authInitWeak: Auth.initWeak,
      authUid: Auth.userID,
      authLoad: Auth.load,
      authClean: Auth.clean,
      authState: Auth.state,
      //删除按钮
      deleteButton: DeleteButton.new,
      //选择按钮
      checkButton: CheckButton.new,
      dropButton: DropButton.new,
      multipleDropButton: MultipleDropButton.new,
      // 日期选择
      datePicker: DatePicker.new,
      dateToStr: DateTimeFormat.toStr,
      formatDateStr: DateTimeFormat.toDateStr,

      //请求
      nio: nio,

      //Toast
      toast: Toast.show,
      toastLoading: Toast.loading,
      toastDismiss: Toast.dismiss,

      //路由操作
      push: Nav.push,
      pushAndRemove: Nav.pushAndRemove,
      pop: Nav.pop,
      routeArgs: Nav.routeArgs,
      pickFile: FilePickerWrapper.pickFile,
      // 链接文件下载
      downloadFile: FileDownloader.downloadLinkFile,
      networkFileBytes: FileDownloader.downloadFile,
      saveFile: FileDownloader.saveFile,
      //唯一ID
      sid: sid,
      //检查更新
      checkUpdate: checkUpdate,
      //桌面bar
      desktopBar: DesktopBar.new,
      //设置
      desktopState: desktopState,
      desktopDragging: desktopDragging,
      pageViewItem: UiPageViewItem.new,
      log: log,
      windowManager: wm.windowManager,
      appVersion: appVersion,
      webBridge: BridgeFactory.webBridge());
}
