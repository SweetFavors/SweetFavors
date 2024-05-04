import 'package:flutter/material.dart';
import 'package:sweet_favors/widgets/profile_bar.dart';
import 'package:sweet_favors/widgets/wish_grant_widget.dart';

class WishGrantPage extends StatelessWidget {
  const WishGrantPage({super.key});

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
            ProfileBar(
              images: 'assets/myGirl.png',
              name: "THE JUSTICE",
              email: "THEJUSTICE@MementoMori.com",
            ),

            SizedBox(height: 35.0),
            WishGrant(price: "133"),
          ],
        ),
      ),
    );
  }
}
