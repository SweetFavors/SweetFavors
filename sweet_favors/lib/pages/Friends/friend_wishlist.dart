import 'package:flutter/material.dart';
import 'package:sweet_favors/widgets/card_widget.dart';
import 'package:sweet_favors/widgets/friend_profile_bar.dart';
import 'package:sweet_favors/widgets/bottomBar.dart';

class FriendWishlist extends StatelessWidget {
  const FriendWishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          // Main column
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Row
            FriendProfileBar(
              images: 'assets/myGirl.png',
              name: "THE JUSTICE",
              email: "Thejustice@gmail.com",
            ),

            SizedBox(height: 35.0), // Spacing between profile and card

            // Card positioned below profile
            CardWidget(product: 'XD', grantBy: 'XD123'),
            CardWidget(product: 'momoXD', grantBy: 'XD12345'),
          ],
        ),
      ),
      // bottomNavigationBar: bottomBar(),
    );
  }
}
