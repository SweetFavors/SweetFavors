import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/color_use.dart';
import 'package:sweet_favors/pages/Friends/friend_wishlist.dart';

class FollowingContent extends StatelessWidget {
  const FollowingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
        child: Container(
            margin: const EdgeInsets.only(bottom: 25),
            child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true, // Add shrinkWrap property
                physics: BouncingScrollPhysics(),
                children: List.generate(8, (index) {
                  return Center(
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FriendWishlist(),
                                // this is not completed, it needs to check if the friend is mutual follow or not
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/myGirl.png',
                                    width: 290,
                                    height: 360,
                                    fit: BoxFit.cover,
                                  )),
                              Container(
                                width: 290,
                                height: 360,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Hubert Blaine Wolfe­schlegel­stein­hausen­berger­dorff Sr.',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )));
                }))),
      ),
    );
  }
}
