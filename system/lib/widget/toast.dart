import 'package:flutter/cupertino.dart';
import 'package:toastification/toastification.dart';

class Toast {
  static void show(String msg) {
    toastification.show(
      title: Text(msg),
      showProgressBar: false,
      autoCloseDuration: const Duration(seconds: 2),
      animationDuration: Duration.zero,
    );
  }

  static void loading(String msg) {}

  static void dismiss() {
    toastification.dismissAll();
  }
}
