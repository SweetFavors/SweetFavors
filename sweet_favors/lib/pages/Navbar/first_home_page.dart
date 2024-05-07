import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sweet_favors/widgets/card_widget.dart';
import 'package:sweet_favors/widgets/profile_bar.dart';

class Wishlist {
  int wishlistId;
  int userId;
  String itemname;
  int quantity;
  int price;
  String linkurl;
  String itemPic;
  bool? alreadyBought; // Make it nullable to handle potential null values

  Wishlist({
    required this.wishlistId,
    required this.userId,
    required this.itemname,
    required this.quantity,
    required this.price,
    required this.linkurl,
    required this.itemPic,
    this.alreadyBought,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) {
    return Wishlist(
      wishlistId: json['wishlist_id'],
      userId: json['user_id'],
      itemname: json['itemname'],
      quantity: json['quantity'],
      price: json['price'],
      linkurl: json['linkurl'],
      itemPic: json['item_pic'],
      alreadyBought: json['already_bought'],
    );
  }
}

// class FirstHomePage extends StatelessWidget {
//   final dio = Dio();
//   FirstHomePage({super.key});

//   void fetchFirstPageInfo() async {
//     var result = dio.get('');
//   }

//   initState() {
//     fetchFirstPageInfo();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Padding(
//         padding: EdgeInsets.all(20.0),
//         child: Column(
//           // Main column
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 40.0,
//             ),
//             // Profile Row
//             SizedBox(
//               height: 55,
//               width: 400,
//               child: ProfileBar(
//                 images: 'assets/myGirl.png',
//                 name: "THE JUSTICE",
//                 email: "Thejustice@gmail.com",
//               ),
//             ),

//             SizedBox(height: 35.0), // Spacing between profile and card

//             // Card positioned below profile
//             CardWidget(product: 'Waifu', grantBy: 'XD123'),
//             CardWidget(product: 'My Product Wish', grantBy: 'XD12345'),
//           ],
//         ),
//       ),
//     );
//   }
// }

class FirstHomePage extends StatefulWidget {
  const FirstHomePage({super.key});

  @override
  State<FirstHomePage> createState() => _FirstHomePageState();
}

class _FirstHomePageState extends State<FirstHomePage> {
  final Dio _dio = Dio();
  // final url = Endpoints.baseUrl;
  List<Wishlist> wishlists = [];
  String? username;
  String? email;
  String? img;

  @override
  void initState() {
    super.initState();
    fetchWishlists();
    fetchUserData();
  }

  Future<List<Wishlist>> fetchWishlists() async {
    Dio dio = Dio(); // Create a Dio instance
    final response =
        await dio.get('http://10.0.2.2:1432/getWishlistsOfCurrentUser/3');

    if (response.statusCode == 200) {
      final parsedJson = response.data as List; // Directly get the parsed data
      print(response.data);
      // parsedJson.map((json) => Wishlist.fromJson(json)).toList();
      wishlists = parsedJson.map((json) => Wishlist.fromJson(json)).toList();
      return wishlists;
    } else {
      throw Exception('Failed to load wishlists');
    }
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

  Widget build(BuildContext context) {
    return Scaffold(
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
                images: img ?? 'assets/myGirl.png',
                name: username ?? '',
                email: email ?? '',
              ),
            ),

            SizedBox(height: 35.0), // Spacing between profile and card

            Expanded(
              child: ListView.builder(
                itemCount: wishlists.length,
                itemBuilder: (context, index) {
                  final wishlist = wishlists[index];
                  return CardWidget(
                    product: wishlist.itemname,
                    grantBy: wishlist.price.toString(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
