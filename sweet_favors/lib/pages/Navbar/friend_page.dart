import 'package:flutter/material.dart';
import 'package:sweet_favors/pages/home.dart';
import 'package:sweet_favors/pages/Friends/add_friend.dart';
import 'package:sweet_favors/widgets/drop_down.dart';

class Friendpage extends StatelessWidget {
  const Friendpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Friends"),
            leading: IconButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Home())),
                icon: const Icon(Icons.arrow_back, color: Colors.black)),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: SizedBox(
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    tooltip: 'Add friend',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddFriend(),
                          // this is not completed, it needs to check if the friend is mutual follow or not
                        ),
                      );
                    },
                  ),
                ),
              ),
            ]),
        body: SingleChildScrollView(child: DropDown()));
  }
}
