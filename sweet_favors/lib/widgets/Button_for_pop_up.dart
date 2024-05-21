import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/color_use.dart';
import 'package:sweet_favors/Utils/text_use.dart'; // Import for RegularTextButton

class ButtonForPopUp extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const ButtonForPopUp(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: colorUse.activeButton,
        fixedSize: const Size(400, 40), // Set a fixed size to the button
      ),
      child: RegularTextButton(text),
    );
  }
}
