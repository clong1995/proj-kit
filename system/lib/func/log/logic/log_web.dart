
import '../log_mixin.dart';

class _Log with LogMixin {
  @override
  void init({String? logPrefix}) {}

  @override
  Future<void> log(String message) async {
    print(message);
  }
}

final log = _Log();
