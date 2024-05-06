import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Center(
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
      ),
    );
  }
}
