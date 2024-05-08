import 'package:flutter/material.dart';
import 'package:sweet_favors/components/following_model.dart';
import 'package:sweet_favors/widgets/card_widget.dart';
import 'package:sweet_favors/widgets/friend_profile_bar.dart';
import 'package:sweet_favors/widgets/bottomBar.dart';
import 'package:sweet_favors/widgets/friends_msg_card.dart';

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
        padding: const EdgeInsets.all(20.0),
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

              const SizedBox(height: 35.0), // Spacing between profile and card
              FriendsMsgCard(
                  message:
                      "You can view each other's wishlist once you both start following each other."),

              // const CardWidget(
              //   wishlistId: 1,
              //   product: 'Labubu',
              //   grantBy: 'Nong Ne',
              // ),
              // const CardWidget(
              //   wishlistId: 2,
              //   product: 'Valorant Skin',
              //   grantBy: 'Nong Putu',
              // ),
            ]),
      ),
      //bottomNavigationBar: const bottomBar(),
    );
  }
}
