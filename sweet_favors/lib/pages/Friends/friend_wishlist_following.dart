import 'package:flutter/material.dart';
import 'package:sweet_favors/components/following_model.dart';
import 'package:sweet_favors/widgets/card_widget.dart';
import 'package:sweet_favors/widgets/friend_profile_bar.dart';
import 'package:sweet_favors/widgets/bottomBar.dart';

class FriendWishlistFollowing extends StatefulWidget {
  final Following following;
  const FriendWishlistFollowing({
    super.key,
    required this.following,
  });

  @override
  State<FriendWishlistFollowing> createState() =>
      _FriendWishlistFollowingState();
}

class _FriendWishlistFollowingState extends State<FriendWishlistFollowing> {
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
              images: widget.following
                  .followingUserPic, // Use the passed follower's image
              name: widget.following.followingUsername,
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
