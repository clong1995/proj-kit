import 'package:example/button/intro.dart';
import 'package:flutter/material.dart';

import 'drop_button_page.dart';

class ButtonRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'intro':
        return MaterialPageRoute(builder: (context) => const IntroList());
      case 'dropbutton':
        return MaterialPageRoute(builder: (context) => const DropButtonPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
        builder: (_) => const Scaffold(body: Center(child: Text('Error}'))));
  }
}

final nestedNavigatorKey = GlobalKey<NavigatorState>();