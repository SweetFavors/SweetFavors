import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/color_use.dart';
import 'package:sweet_favors/pages/Wish/wish_details.dart';

class TextForm extends StatefulWidget {
  final String label;
  const TextForm({super.key, required this.label});

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  final myConroter = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: widget.label,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please input the ${widget.label.toLowerCase()}';
              }
              return null;
            },
            controller: myConroter,
          ),
        ),
      ),
    );
  }
}
