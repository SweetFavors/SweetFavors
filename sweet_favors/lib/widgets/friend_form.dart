import 'package:flutter/material.dart';

class FriendForm extends StatefulWidget {
  final String label;
  final void Function(String?)? onSaved;
  final VoidCallback? onSubmitted;

  const FriendForm({
    super.key,
    required this.label,
    this.onSaved,
    this.onSubmitted,
  });

  @override
  State<FriendForm> createState() => _FriendFormState();
}

class _FriendFormState extends State<FriendForm> {
  final _formKey = GlobalKey<FormState>();
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
            controller: myConroter,
            onSaved: widget.onSaved,
            onFieldSubmitted: (value) => widget.onSubmitted?.call(),
          ),
        ),
      ),
    );
  }
}
