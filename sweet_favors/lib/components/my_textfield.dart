import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final IconData? iconData;
  final VoidCallback? onIconPressed;
  final bool? border;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    this.iconData,
    this.onIconPressed,
    this.border,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late bool obscureText;
  late IconData iconData;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
    iconData =
        obscureText ? Icons.remove_red_eye_outlined : Icons.remove_red_eye;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.iconData != null
            ? IconButton(
                icon: Icon(iconData),
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                    iconData = obscureText
                        ? Icons.remove_red_eye_outlined
                        : Icons.remove_red_eye;
                  });
                  if (widget.onIconPressed != null) {
                    widget.onIconPressed!();
                  }
                },
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: widget.border ?? false
                ? const Color.fromARGB(255, 0, 0, 0)
                : Colors.transparent,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 1.5),
        ),
      ),
      obscureText: obscureText,
    );
  }
}
