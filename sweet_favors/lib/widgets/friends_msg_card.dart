import 'package:flutter/material.dart';

class FriendsMsgCard extends StatelessWidget {
  final String message;

  const FriendsMsgCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 150,
          width: 400,
          child: Card(
            color: const Color.fromARGB(163, 223, 143, 210),
            elevation: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 245, 232, 251),
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
