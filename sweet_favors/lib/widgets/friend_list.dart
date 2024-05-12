import 'package:flutter/material.dart';

class FriendList extends StatelessWidget {
  final List<dynamic> friends;
  const FriendList({super.key, required this.friends});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: friends.length,
      itemBuilder: (context, index) {
        final friend = friends[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(friend['user_pic']),
          ),
          title: Text(friend['username']),
        );
      },
    );
  }
}
