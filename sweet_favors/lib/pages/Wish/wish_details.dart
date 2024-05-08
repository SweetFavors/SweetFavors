import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/text_use.dart';
import 'package:sweet_favors/components/integrate_model.dart' as components;
import 'package:sweet_favors/pages/Payment/payment.dart';
import 'package:sweet_favors/pages/home.dart';
import 'package:sweet_favors/widgets/button_at_bottom.dart';
import 'package:sweet_favors/widgets/title_bar.dart';

class WishDetails extends StatefulWidget {
  final int wishlist_id;
  const WishDetails({super.key, required this.wishlist_id});

  @override
  State<WishDetails> createState() => _WishDetailsState();
}

class _WishDetailsState extends State<WishDetails> {
  @override
  void initState() {
    super.initState();
    fetchWishlists();
  }

  Future<Map<String, dynamic>> fetchWishlists() async {
    Dio dio = Dio(); // Create a Dio instance
    final response = await dio
        .get('http://10.0.2.2:1432/GetWishlistDetails/${widget.wishlist_id}');

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load wishlists');
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
          final quantity =
              (wishdata?['quantity'] as num)!.toString() ?? 'Unknown quantity';
          final linkurl = wishdata?['link_url'] ?? 'Unknown link';
          final pics = wishdata?['item_pic'] ?? 'Unknown pics';
          final userId = (wishdata?['user_Id']) ?? 'Unknown userId';

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
                      pics,
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.4,
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
                          Padding(
                            padding: const EdgeInsets.all(3),
                            child: RegularText('Quantity : $quantity'),
                          ),
                          const SizedBox(height: 10),
                          const Divider(color: Colors.grey),
                          const SizedBox(height: 20),
                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: RegularTextBold('Request by'),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child:
                                RegularText('test'), // Replace with actual data
                          ),
                          const SizedBox(height: 24),
                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: RegularTextBold('Link URL'),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: RegularText(
                                linkurl), // Replace with actual data
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    ButtonAtBottom(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Payment(
                                    userId: userId,
                                  )),
                        );
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
