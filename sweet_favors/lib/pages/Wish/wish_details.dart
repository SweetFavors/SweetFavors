import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sweet_favors/Utils/text_use.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sweet_favors/provider/token_provider.dart';
import 'package:sweet_favors/pages/home.dart';
import 'package:sweet_favors/widgets/Button_for_pop_up.dart';
import 'package:sweet_favors/widgets/button_at_bottom.dart';
import 'package:sweet_favors/widgets/pop_up.dart';
import 'package:sweet_favors/widgets/title_bar.dart';

class WishDetails extends StatefulWidget {
  final int wishlist_id;
  final String username;
  final VoidCallback? onUpdateBuy;
  // final int? userIdOfUser;
  const WishDetails({
    super.key,
    required this.wishlist_id,
    required this.username,
    this.onUpdateBuy,
  });

  @override
  State<WishDetails> createState() => _WishDetailsState();
}

class _WishDetailsState extends State<WishDetails> {
  int? userIdFromToken;
  @override
  void initState() {
    super.initState();
    fetchWishlists();
  }

  Future<Map<String, dynamic>> fetchWishlists() async {
    final token = Provider.of<TokenProvider>(context, listen: false).token;
    final userId = Provider.of<TokenProvider>(context, listen: false).userId;
    Dio dio = Dio(); // Create a Dio instance
    final response = await dio.get(
      'http://10.0.2.2:1432/GetWishlistDetails/${widget.wishlist_id}',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Adjust content type as needed
        },
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        userIdFromToken = userId;
      });
      return response.data;
    } else {
      throw Exception('Failed to load wishlists');
    }
  }

  Future<Map<String, dynamic>> _postGranter() async {
    final token = Provider.of<TokenProvider>(context, listen: false).token;
    final userId = Provider.of<TokenProvider>(context, listen: false).userId;
    Dio dio = Dio(); // Create a Dio instance
    final response = await dio.put(
      'http://10.0.2.2:1432/UpdateGrantForFriend/${widget.wishlist_id}/${userId}',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Adjust content type as needed
        },
      ),
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to put _PostGranter');
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
      // throw Exception('Could not launch $uri');
    } else {
      await Future.delayed(const Duration(seconds: 1));

      showDialog(
        context: context,
        builder: (context) => PopUp(
          title: 'Have you bought the wish?',
          buttons: [
            ButtonForPopUp(
                onPressed: () async {
                  await _postGranter();
                  Navigator.of(context).pop();
                  if (widget.onUpdateBuy != null) { // Check if callback is provided
                    widget.onUpdateBuy!();
                    print(widget.onUpdateBuy);
                  }
                  Navigator.of(context).pop();
                },
                text: 'Yes'),
            ButtonForPopUp(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  if (widget.onUpdateBuy != null) { // Check if callback is provided
                    widget.onUpdateBuy!(); // Call the callback
                  }
                },
                text: 'No'),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchWishlists(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.hasData) {
          final wishdata = snapshot.data;
          final itemName = wishdata?['itemname'] ?? 'Unknown Item';
          // final quantity =
          // (wishdata?['quantity'] as num)!.toString() ?? 'Unknown quantity';
          final linkurl = wishdata?['link_url'] ?? 'Unknown link';
          final pics = wishdata?['item_pic'] ?? 'Unknown pics';
          final userId = (wishdata?['user_id']) ?? 0;
          final username = widget.username;
          final alreadyBought = (wishdata?['already_bought']);
          final grantBy = (wishdata?['granted_by_user_id']);
          return Scaffold(
            appBar: CustomAppBarNavigation(
              title: itemName,
              backDestination: const Home(),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Image.network(
                      pics ??
                          'https://via.placeholder.com/350/FFFFFF/000000?text=Image+Not+Found', // Placeholder URL
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.4,
                      errorBuilder: (context, error, stackTrace) {
                        // Optional: Handle image loading errors gracefully
                        return Image.network(
                          'https://via.placeholder.com/350/FFFFFF/000000?text=Image+Not+Found', // Fallback image
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.4,
                        );
                      },
                    ),
                    const SizedBox(height: 25),
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RegularTextBold(
                            wishdata?.containsKey('price') == true
                                ? '\$' +
                                        (wishdata?['price'] as num)!
                                            .toString() ??
                                    '\$0'
                                : '',
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(3),
                          //   child: RegularText('Quantity : $quantity'),
                          // ),
                          const SizedBox(height: 10),
                          const Divider(color: Colors.grey),
                          const SizedBox(height: 20),
                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: RegularTextBold('Request by'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: RegularText(
                                username), // Replace with actual data
                          ),
                          const SizedBox(height: 24),
                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: RegularTextBold('Link URL'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: RegularText(
                                linkurl), // Replace with actual data
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (userId != userIdFromToken || grantBy != null)
                      ButtonAtBottom(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return PopUp(
                                  title: 'Do you want to grant the wish?',
                                  buttons: [
                                    ButtonForPopUp(
                                        onPressed: () async {
                                          Navigator.of(dialogContext).pop();
                                          await _launchUrl(linkurl);
                                        },
                                        text: 'Yes'),
                                    ButtonForPopUp(
                                        onPressed: () {
                                          Navigator.of(dialogContext).pop();
                                        },
                                        text: 'No'),
                                  ],
                                );
                              });
                        },
                        text: 'GRANT WISH',
                      ),
                  ],
                ),
              ),
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
