export 'src/storage_none.dart'
    if (dart.library.html) 'src/storage_web.dart'
    if (dart.library.io) 'src/storage_io.dart';
