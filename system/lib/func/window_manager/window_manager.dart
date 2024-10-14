import 'impl/window_manager_stub.dart'
    if (dart.library.html) 'impl/window_manager_web.dart'
    if (dart.library.io) 'impl/window_manager_io.dart';

final windowManager = WindowManager();
