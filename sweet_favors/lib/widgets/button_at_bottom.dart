import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/color_use.dart';
import 'package:sweet_favors/Utils/text_use.dart'; // Import for RegularTextButton

class ButtonAtBottom extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const ButtonAtBottom(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(constraints.maxWidth * 0.8, 50),
                  backgroundColor: colorUse.activeButton,
                ),
                child: RegularTextButton(text),
              );
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

