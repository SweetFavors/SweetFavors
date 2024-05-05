import 'package:flutter/material.dart';
import 'package:sweet_favors/Auth/login.dart';
import 'package:sweet_favors/Auth/login_or_register.dart';
import 'package:sweet_favors/Auth/sign_up.dart';
import 'package:sweet_favors/pages/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Inter'),
      home: const LoginOrRegister(),
      // home: WishDetails(),
    );
  }
}
