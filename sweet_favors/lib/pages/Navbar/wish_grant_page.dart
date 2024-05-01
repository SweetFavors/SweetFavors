import 'package:flutter/material.dart';

class WishGrantPage extends StatelessWidget {
  const WishGrantPage({super.key});

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Page"),
      ),
      body: const Center(
        child: Text("This is the content of the Second Page"),
      ),
    );
  }
}