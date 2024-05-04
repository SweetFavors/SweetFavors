import 'package:flutter/material.dart';

class Friendpage extends StatelessWidget {
  const Friendpage({super.key});

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fourth Page"),
      ),
      body: const Center(
        child: Text("This is the content of the Fourth Page"),
      ),
    );
  }
}