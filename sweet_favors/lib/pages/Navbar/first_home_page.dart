import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_favors/provider/token_provider.dart';
import 'package:sweet_favors/widgets/card_widget.dart';
import 'package:sweet_favors/widgets/profile_bar.dart';
import 'package:sweet_favors/components/integrate_model.dart' as components;

class FirstHomePage extends StatefulWidget {
  const FirstHomePage({super.key});

  @override
  State<FirstHomePage> createState() => _FirstHomePageState();
}

class _FirstHomePageState extends State<FirstHomePage> {
  // final url = Endpoints.baseUrl;
  List<components.Wishlist> wishlists = [];
  String? username;
  String? email;
  String? img;
  String? firstname;
  String? lastname;
  String? fullname;

  @override
  void initState() {
    super.initState();
    fetchWishlists();
    fetchUserData();
  }

  Future<List<components.Wishlist>> fetchWishlists() async {
    final token = Provider.of<TokenProvider>(context, listen: false).token;
    Dio dio = Dio(); // Create a Dio instance
    final response = await dio.get(
      'http://10.0.2.2:1432/getWishlistsOfCurrentUser',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Adjust content type as needed
        },
      ),
    );

    if (response.statusCode == 200) {
      final parsedJson = response.data as List; // Directly get the parsed data
      print(response.data);
      // parsedJson.map((json) => Wishlist.fromJson(json)).toList();
      wishlists =
          parsedJson.map((json) => components.Wishlist.fromJson(json)).toList();
      return wishlists;
    } else {
      throw Exception('Failed to load wishlists');
    }
  }

  Future<void> fetchUserData() async {
    final token = Provider.of<TokenProvider>(context, listen: false).token;
    final userId = Provider.of<TokenProvider>(context, listen: false).userId;
    Dio dio = Dio();
    final response = await dio.get(
      'http://10.0.2.2:1432/GetProfileOfCurrentUser/$userId',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Adjust content type as needed
        },
      ),
    );

    if (response.statusCode == 200) {
      final parsedJson = response.data; // Directly get the parsed data
      setState(() {
        // Update the username and email variables with the parsed user data
        username = parsedJson['username'];
        email = parsedJson['email'];
        img = parsedJson['user_pic'];
        firstname = parsedJson['firstname'];
        lastname = parsedJson['lastname'];
        fullname = '$firstname $lastname';

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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          // Main column
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40.0,
            ),
            // Profile Row
            SizedBox(
              height: 55,
              width: 400,
              child: ProfileBar(
                images: img ?? '',
                name: username ?? '',
                email: email ?? '',
                fullname: fullname ?? '',
              ),
            ),

            const SizedBox(height: 35.0), // Spacing between profile and card

            Expanded(
              child: ListView.builder(
                itemCount: wishlists.length,
                itemBuilder: (context, index) {
                  final wishlist = wishlists[index];
                  return CardWidget(
                    product: wishlist.itemname,
                    grantBy: wishlist.userNameOfGranter,
                    wishlistId: wishlist.wishlistId,
                    username: username,
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
