import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_favors/components/following_model.dart';
import 'package:sweet_favors/provider/token_provider.dart';
import 'package:sweet_favors/widgets/card_widget.dart';
import 'package:sweet_favors/widgets/friend_profile_bar.dart';
import 'package:sweet_favors/widgets/friends_msg_card.dart';
import 'package:sweet_favors/components/integrate_model.dart' as components;

class FriendWishlistFollowing extends StatefulWidget {
  final Following following;
  const FriendWishlistFollowing({
    super.key,
    required this.following,
  });

  @override
  State<FriendWishlistFollowing> createState() =>
      _FriendWishlistFollowingState();
}

class _FriendWishlistFollowingState extends State<FriendWishlistFollowing> {
  List<components.Wishlist> wishlists = [];

  @override
  void initState() {
    super.initState();
    fetchWishlists();
    fetchFriendCheck();
  }

  Future<void> fetchWishlists() async {
    final token = Provider.of<TokenProvider>(context, listen: false).token;
    Dio dio = Dio(); // Create a Dio instance
    final response = await dio.get(
      'http://10.0.2.2:1432/GetProfileFriendWishlists/${widget.following.userId}/${widget.following.followingId}',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Adjust content type as needed
        },
      ),
    );

    if (response.statusCode == 200) {
      final parsedJson = response.data as List; // Directly get the parsed data
      setState(() {
        wishlists = parsedJson
            .map((json) => components.Wishlist.fromJson(json))
            .toList();
      });
    } else {
      throw Exception('Failed to load wishlists');
    }
  }

  Future<bool> fetchFriendCheck() async {
    final token = Provider.of<TokenProvider>(context, listen: false).token;
    Dio dio = Dio(); // Create a Dio instance

    // Check if user 1 is following user 2
    final response1 = await dio.get(
      'http://10.0.2.2:1432/GetCheckFollowingYet/${widget.following.userId}/${widget.following.followingId}',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Adjust content type as needed
        },
      ),
    );

    if (response1.statusCode != 200 ||
        response1.data['user_id'] == null ||
        response1.data['following_id'] == null) {
      return false;
    }

    // Check if user 2 is following user 1
    final response2 = await dio.get(
      'http://10.0.2.2:1432/GetCheckFollowingYet/${widget.following.followingId}/${widget.following.userId}',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Adjust content type as needed
        },
      ),
    );

    if (response2.statusCode != 200 ||
        response2.data['user_id'] == null ||
        response2.data['following_id'] == null) {
      return false;
    }

    return true;
  }
  
  void refreshWishlists() {
    setState(() {
      // Trigger rebuild by updating state
      fetchWishlists(); // Re-fetch wishlists
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FriendProfileBar(
              images: widget.following.followingUserPic,
              name: widget.following.followingUsername,
              email: "",
              userId: widget.following.userId,
              otherUserId: widget.following.followingId,
            ),
            const SizedBox(height: 35.0),
            FutureBuilder(
              future: fetchFriendCheck(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final isFollowing = snapshot.data as bool;
                  if (isFollowing) {
                    return Expanded(
                      child: wishlists.isEmpty
                          ? const FriendsMsgCard(
                              message: "The list is empty",
                            )
                          : ListView.builder(
                              itemCount: wishlists.length,
                              itemBuilder: (context, index) {
                                final wishlist = wishlists[index];
                                return CardWidget(
                                  product: wishlist.itemname,
                                  grantBy: wishlist.userNameOfGranter,
                                  wishlistId: wishlist.wishlistId,
                                  username: wishlist.userNameOfWishlist,
                                  userid: wishlist.userId,
                                  alreadyBought: wishlist.alreadyBought,
                                  onUpdate: refreshWishlists,
                                  onUpdateBuy: refreshWishlists,
                                );
                              },
                            ),
                    );
                  } else {
                    return const FriendsMsgCard(
                      message:
                          "You can view each other's wishlist once you both start following each other \u{1F929}",
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
