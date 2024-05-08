import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/color_use.dart';
import 'package:sweet_favors/widgets/profile_bar.dart';
import 'package:sweet_favors/widgets/wish_grant_widget.dart';
import 'package:sweet_favors/widgets/button_at_bottom.dart';
import 'package:sweet_favors/pages/Wish/wish_details.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class WishGrantPage extends StatefulWidget {
  const WishGrantPage({super.key});

  @override
  State<WishGrantPage> createState() => _WishGrantPageState();
}

class _WishGrantPageState extends State<WishGrantPage> {
  String? username;
  String? email;
  String? img;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    Dio dio = Dio();
    final response =
        await dio.get('http://10.0.2.2:1432/GetProfileOfCurrentUser/3');

    if (response.statusCode == 200) {
      final parsedJson = response.data; // Directly get the parsed data
      print(response.data);

      setState(() {
        // Update the username and email variables with the parsed user data
        username = parsedJson['username'];
        email = parsedJson['email'];
        img = parsedJson['user_pic'];

        print(username);
        print(email);
      });
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          // Main column
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            // Profile Row
            SizedBox(
              height: 55,
              width: 400,
              child: ProfileBar(
                images: img ?? '',
                name: username ?? '',
                email: email ?? '',
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.2,
              child: Swiper(
                layout: SwiperLayout.STACK,
                itemCount: 3,
                itemHeight: 300,
                itemWidth: 800,
                scrollDirection: Axis.horizontal,
                viewportFraction: 0.1,
                itemBuilder: (context, index) {
                  return index == 0
                      ? const WishGrant(
                          price: "\$150") // Change the price accordingly
                      : const SizedBox
                          .shrink(); // Hide the WishGrant widget for other items
                },
              ),
            ),
            // Expanded(
            //   // height: MediaQuery.of(context).size.height /
            //   //     2, // Set the desired height
            //   child: Swiper(
            //     itemBuilder: (context, index) {
            //       return const WishGrant(price: "\$150");
            //     },
            //     itemCount: 3,
            //     itemHeight: 600,
            //     itemWidth: 600,
            //     layout: SwiperLayout.STACK,
            //   ),
            // ),
            const SizedBox(
              height: 50,
            ),
            ButtonAtBottom(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const WishDetails(),
                  //     // builder: (context) => WishDetails(product: product, grantBy: grantBy),
                  //   ),
                  // );
                },
                text: 'View wish detail'),
          ],
        ),
      ),
    );
  }
}
