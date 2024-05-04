import 'package:flutter/material.dart';
import 'package:sweet_favors/widgets/profile_bar.dart';
import 'package:sweet_favors/widgets/wish_grant_widget.dart';
import 'package:sweet_favors/widgets/button_at_bottom.dart';
import 'package:sweet_favors/pages/Wish/wish_details.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class WishGrantPage extends StatelessWidget {
  const WishGrantPage({super.key});

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
            ProfileBar(
              images: 'assets/myGirl.png',
              name: "THE JUSTICE",
              email: "THEJUSTICE@MementoMori.com",
            ),

            SizedBox(height: 35.0),
            SizedBox(
              height: MediaQuery.of(context).size.height /
                  1.5, // Set the desired height
              child: Swiper(
                itemBuilder: (context, index) {
                  return WishGrant(price: "133");
                },
                itemCount: 3,
                itemHeight: 600,
                itemWidth: 600,
                layout: SwiperLayout.STACK,
              ),
            ),
            ButtonAtBottom(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WishDetails(),
                      // builder: (context) => WishDetails(product: product, grantBy: grantBy),
                    ),
                  );
                },
                text: 'View wish detail'),
          ],
        ),
      ),
    );
  }
}
