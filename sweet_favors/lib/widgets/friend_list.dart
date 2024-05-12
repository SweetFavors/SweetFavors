import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/color_use.dart';

class FriendList extends StatelessWidget {
  final List<dynamic> friends;
  const FriendList({super.key, required this.friends});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: friends.length,
      itemBuilder: (context, index) {
        final friend = friends[index];
        return Card(
          color: const Color.fromARGB(240, 247, 226, 249),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 22.5,
                backgroundImage: NetworkImage(friend['user_pic']),
              ),
              title: Text(
                friend['username'],
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color.fromARGB(185, 109, 42, 128)),
              ),
            ),
          ),
        );
      },
    );
  }
}
