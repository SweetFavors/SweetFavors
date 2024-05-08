import 'package:flutter/material.dart';
import 'package:sweet_favors/pages/Navbar/friend_page.dart';
import 'package:sweet_favors/pages/home.dart';
import 'package:sweet_favors/widgets/friend_form.dart';
import 'package:sweet_favors/widgets/bottomBar.dart';

class AddFriend extends StatelessWidget {
  const AddFriend({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Friend",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Friendpage())),
            icon: const Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.25,
              width: 400,
              child: const Column(children: [
                FriendForm(label: 'Search friend'),
              ]),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: bottomBar(),
    );
  }
}
