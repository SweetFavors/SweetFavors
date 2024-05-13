import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/color_use.dart';
import 'package:sweet_favors/pages/home.dart';
import 'package:sweet_favors/pages/Friends/add_friend.dart';
import 'package:sweet_favors/widgets/drop_down.dart';

class Friendpage extends StatelessWidget {
  const Friendpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "Friends",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(240, 255, 255, 255)),
            ),
            backgroundColor: colorUse.appBarColor,
            shadowColor: const Color.fromARGB(255, 171, 171, 171),
            centerTitle: true,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: SizedBox(
                  child: IconButton(
                    icon: const Icon(Icons.person_add),
                    color: Color.fromARGB(240, 255, 255, 255),
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
