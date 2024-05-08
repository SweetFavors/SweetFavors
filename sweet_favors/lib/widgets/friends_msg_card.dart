import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/text_use.dart';
import 'package:sweet_favors/Utils/color_use.dart';

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
            color: const Color.fromARGB(197, 206, 120, 246),
            elevation: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
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
