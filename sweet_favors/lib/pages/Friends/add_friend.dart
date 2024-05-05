import 'package:flutter/material.dart';
import 'package:sweet_favors/pages/home.dart';
import 'package:sweet_favors/widgets/friend_form.dart';
import 'package:sweet_favors/widgets/bottomBar.dart';

class AddFriend extends StatelessWidget {
  const AddFriend({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Friend"),
        leading: IconButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Home())),
            icon: const Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.25,
            width: 600,
            child: Column(children: [
              FriendForm(label: 'Search friend'),
            ]),
          ),
        ],
      ),
      // bottomNavigationBar: bottomBar(),
    );
  }
}
