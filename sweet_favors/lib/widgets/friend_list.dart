import 'package:flutter/material.dart';
import 'package:sweet_favors/pages/Friends/search_friend_wishlist.dart'; // Import FriendProfile page

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
          child: InkWell(
            // Wrap ListTile in InkWell for clickable functionality
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchFriend(friend: friend),
                ),
              );
            },
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
          ),
        );
      },
    );
  }
}
