import 'package:flutter/material.dart';
import 'package:sweet_favors/pages/home.dart';

class NewWishAdd extends StatelessWidget {
  const NewWishAdd({super.key});

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Third Page"),
        leading: IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()))  ,
                                icon: const Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: const Center(
        child: Text("This is the content of the Third Page"),
      ),
    );
  }
}