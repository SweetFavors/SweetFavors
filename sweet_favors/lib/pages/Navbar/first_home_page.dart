import 'package:flutter/material.dart';
import 'package:sweet_favors/widgets/card_widget.dart';
import 'package:sweet_favors/widgets/profile_bar.dart';

class FirstHomePage extends StatelessWidget {
  const FirstHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          // Main column
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40.0,
            ),
            // Profile Row
            SizedBox(
              height: 55,
              width: 400,
              child: ProfileBar(
                images: 'assets/myGirl.png',
                name: "THE JUSTICE",
                email: "THEJUSTICE@MementoMori.com",
              ),
            ),

            SizedBox(height: 35.0), // Spacing between profile and card

            // Card positioned below profile
            CardWidget(product: 'XD', grantBy: 'XD123'),
            CardWidget(product: 'momoXD', grantBy: 'XD12345'),
          ],
        ),
      ),
    );
  }
}
