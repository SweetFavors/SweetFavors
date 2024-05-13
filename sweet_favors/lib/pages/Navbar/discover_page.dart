import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sweet_favors/Utils/color_use.dart';
import 'package:sweet_favors/components/integrate_model.dart';
import 'package:sweet_favors/widgets/profile_bar.dart';
import 'package:sweet_favors/widgets/wish_grant_widget.dart';
import 'package:sweet_favors/widgets/button_at_bottom.dart';
import 'package:sweet_favors/pages/Wish/wish_details.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class discover_page extends StatefulWidget {
  const discover_page({super.key});

  @override
  State<discover_page> createState() => _discover_pageState();
}

class _discover_pageState extends State<discover_page> {
  List<WishItem> _wishItems = [];
  int _currentIndex = 0; // State to track the current Swiper index

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<List<dynamic>> _fetchData() async {
    Dio dio = Dio();
    final response = await dio.get(
        'http://10.0.2.2:1432/GetFriendsWishlists/3'); // Adjust the endpoint
    if (response.statusCode == 200) {
      final List<dynamic> wishData = response.data;
      _wishItems = wishData.map((json) => WishItem.fromJson(json)).toList();
      print(_wishItems);
      return _wishItems;
    } else {
      throw Exception('Failed to load wishlists');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Discover",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(240, 255, 255, 255),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 188, 143, 223),
        elevation: 5,
        shadowColor: const Color.fromARGB(255, 171, 171, 171),
        centerTitle: true,
      ),
      body: Expanded(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(
            child: GridView.builder(
              itemCount: _wishItems.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1, // Adjust aspect ratio as needed
              ),
              itemBuilder: (context, index) {
                return WishGrant(
                  price: "\$${_wishItems[index].price}",
                  pic: _wishItems[index].itemPic,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
    //Peem's swiping animation
    // return Scaffold(
    //   body: Padding(
    //     padding: const EdgeInsets.all(20.0),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         const SizedBox(height: 40),

    //         // Profile Row - Using the current WishItem
    //         Flexible(
    //           flex: 1,
    //           fit: FlexFit.tight,
    //           // height: 55,
    //           // width: 400,
    //           child: _wishItems.isNotEmpty
    //               ? Container(
    //                   child: ProfileBar(
    //                     images: _wishItems[_currentIndex].picOfWishlistUser ??
    //                         '', // Placeholder image
    //                     name:
    //                         _wishItems[_currentIndex].usernameOfWishlist ?? '',
    //                     email: '', // Assuming you have email data in WishItem
    //                   ),
    //                 )
    //               : const Center(child: CircularProgressIndicator()),
    //         ),

    //         // const SizedBox(height: 60),

    //         Flexible(
    //           flex: 7,
    //           fit: FlexFit.tight,
    //           child: Swiper(
    //             layout: SwiperLayout.CUSTOM,
    //             customLayoutOption:
    //                 CustomLayoutOption(startIndex: -1, stateCount: 3)
    //                   ..addRotate([-45.0 / 180, 0.0, 45.0 / 180])
    //                   ..addTranslate([
    //                     const Offset(-370.0, -40.0),
    //                     const Offset(0.0, 0.0),
    //                     const Offset(370.0, -40.0)
    //                   ]),
    //             itemCount: _wishItems.length,
    //             itemHeight: 300,
    //             itemWidth: 800,
    //             scrollDirection: Axis.horizontal,
    //             viewportFraction: 0.8,
    //             onIndexChanged: (index) {
    //               setState(() {
    //                 _currentIndex = index;
    //               });
    //             },
    //             itemBuilder: (context, index) {
    //               return WishGrant(
    //                 price: "\$${_wishItems[index].price}",
    //                 pic: _wishItems[index].itemPic,
    //               );
    //             },
    //           ),
    //         ),

    //         Flexible(
    //           flex: 3,
    //           fit: FlexFit.tight,
    //           child: _wishItems.isNotEmpty?
    //           ButtonAtBottom(
    //               onPressed: () {
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (context) => WishDetails(
    //                       wishlist_id:
    //                            _wishItems[_currentIndex].wishlistId,
    //                       username:
    //                            _wishItems[_currentIndex].usernameOfWishlist//put here choey choey to show the nav tmrw -nes
    //                     ),
    //                     // builder: (context) => WishDetails(product: product, grantBy: grantBy),
    //                   ),
    //                 );
    //               },
    //               text: 'VIEW WISH DETAILS') : const Center(child: CircularProgressIndicator()),
    //         ),
    //         // SizedBox(height: 100,),
    //       ],
    //     ),
    //   ),
    // );

