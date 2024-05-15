import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_favors/provider/token_provider.dart';
import 'Auth/login.dart';
import 'Auth/login_or_register.dart';
import 'Auth/sign_up.dart';
import 'pages/Navbar/first_home_page.dart';
import 'pages/Navbar/friend_page.dart';
import 'pages/Navbar/new_wish_add.dart';
import 'pages/Navbar/discover_page.dart';
import 'pages/home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TokenProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final tokenProvider = Provider.of<TokenProvider>(context, listen: false);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Inter'),
      home: tokenProvider.token == null
          ? const LoginOrRegister()
          : const FirstHomePage(),
    );
  }
}
