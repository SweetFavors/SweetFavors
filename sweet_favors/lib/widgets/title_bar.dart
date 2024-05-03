import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/text_use.dart'; // Import your text styling
  // Import your Home page

class CustomAppBarNavigation extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle; // Added parameter for title alignment
  final Widget? backDestination;

  const CustomAppBarNavigation({super.key, required this.title, this.centerTitle = false, this.backDestination});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle ? true: false,
      title: Heading(title),
      leading: IconButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => backDestination!),
        ),
        icon: const Icon(Icons.arrow_back, color: Colors.black),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Standard AppBar height
}


class CustomAppBarPop extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle; // Added parameter for title alignment

  const CustomAppBarPop({super.key, required this.title, this.centerTitle = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle ? true: false,
      title: 
           Heading(title),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back, color: Colors.black),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Standard AppBar height
}
