import 'package:flutter/material.dart';

class TextForm extends StatefulWidget {
  final String? label;
  final TextEditingController? controller;

  const TextForm({
    super.key,
    this.label,
    this.controller,
  });

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: TextFormField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: widget.label,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: widget.controller,
          ),
        ),
      ),
    );
  }
}
