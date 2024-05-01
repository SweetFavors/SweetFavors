import 'package:flutter/material.dart';
import 'package:sweet_favors/widgets/bottomBar.dart';



class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: bottomBar(), 
    );

    
  }
}