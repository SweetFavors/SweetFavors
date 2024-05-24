import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/text_use.dart';

class PopUp extends StatefulWidget {
  final String? title;
  final List<Widget> buttons;

  const PopUp({super.key, required this.title, this.buttons = const []});

  @override
  State<PopUp> createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Center(
            child: Row(
          children: [
            RegularTextBold(widget.title ?? ''),
          ],
        )),
        actions: [
          Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: widget.buttons),
          )
        ]);
  }
}
