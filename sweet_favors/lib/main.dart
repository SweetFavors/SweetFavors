import 'package:flutter/material.dart';
import 'package:sweet_favors/pages/Wish/wish_details.dart';
import 'package:sweet_favors/pages/home.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      theme: ThemeData(fontFamily: 'Inter'),
      home: Home(),
      // home: WishDetails(),

  );
 }
 }