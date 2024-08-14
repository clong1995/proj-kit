import 'package:window_manager/window_manager.dart';

Future<void> desktopState(String state) async {
  switch (state) {
    case "min":
      await windowManager.minimize();
      break;
    case "toggle":
      if (!(await windowManager.isMaximized())) {
        await windowManager.maximize();
      } else {
        await windowManager.unmaximize();
      }
      break;
    case "max":
      await windowManager.maximize();
      break;
    case "unmax":
      await windowManager.unmaximize();
      break;
    case "close":
      await windowManager.close();
      break;
  }
}
