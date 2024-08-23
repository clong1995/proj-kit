import 'package:flutter/material.dart';
import 'package:system/func/auth.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool? auth;

  @override
  void initState() {
    super.initState();
    Auth.load().then((bool value) {
      auth = value;
      setState(() {});
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("$auth"),
    );
  }
}
