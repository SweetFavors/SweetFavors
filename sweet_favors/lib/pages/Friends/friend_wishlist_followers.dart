import 'package:flutter/material.dart';
import 'package:sweet_favors/components/follower_model.dart';
import 'package:sweet_favors/components/following_model.dart';
import 'package:sweet_favors/widgets/card_widget.dart';
import 'package:sweet_favors/widgets/friend_profile_bar.dart';
import 'package:sweet_favors/widgets/bottomBar.dart';

class FriendWishlistFollowers extends StatefulWidget {
  final Follower follower;

  const FriendWishlistFollowers({
    super.key,
    required this.follower,
  });

  @override
  State<FriendWishlistFollowers> createState() =>
      _FriendWishlistFollowersState();
}

class _FriendWishlistFollowersState extends State<FriendWishlistFollowers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          // Main column
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Row
            FriendProfileBar(
              images: widget
                  .follower.followerUserPic, // Use the passed follower's image
              name: widget.follower.followerUsername,
              email: "test",
            ),

            SizedBox(height: 35.0), // Spacing between profile and card

            // Card positioned below profile
            // CardWidget(product: 'XD', grantBy: 'XD123'),
            // CardWidget(product: 'momoXD', grantBy: 'XD12345'),
          ],
        ),
      ),
      // bottomNavigationBar: bottomBar(),
    );
  }
}