import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class Toast {
  static void show(String msg) {
    toastification.show(
      alignment: Alignment.center,
      title: Text(msg),
      showProgressBar: false,
      autoCloseDuration: const Duration(seconds: 2),
      animationDuration: Duration.zero,
      pauseOnHover: false,
    );
  }

  static void loading(String msg) {
    toastification.show(
      alignment: Alignment.center,
      title: Text(msg),
      icon: const Icon(Icons.sync),
      closeButtonShowType: CloseButtonShowType.none,
      closeOnClick: true,
      pauseOnHover: false,
      showProgressBar: false,
    );
  }

  static void dismiss() {
    toastification.dismissAll();
  }
}
