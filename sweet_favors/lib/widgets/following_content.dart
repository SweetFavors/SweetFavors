import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/color_use.dart';
import 'package:sweet_favors/pages/Friends/friend_wishlist_following.dart';
import 'package:sweet_favors/components/following_model.dart';
import 'package:sweet_favors/services/following_service.dart';

class FollowingContent extends StatefulWidget {
  const FollowingContent({Key? key});

  @override
  State<FollowingContent> createState() => _FollowingContentState();
}

class _FollowingContentState extends State<FollowingContent> {
  late FollowingService _followingService;
  late Future<List<Following>> _followingsFuture;

  @override
  void initState() {
    super.initState();
    _followingService = FollowingService(Dio());
    _followingsFuture = _fetchFollowings();
  }

  Future<List<Following>> _fetchFollowings() async {
    final followings = await _followingService.fetchFollowingOfCurrentUser(1);
    return followings;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(bottom: 25),
          child: FutureBuilder<List<Following>>(
            future: _followingsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  childAspectRatio: 0.7, // Adjust this aspect ratio as needed
                  padding:
                      const EdgeInsets.all(8.0), // Add padding around each item
                  children: snapshot.data!.map((following) {
                    return Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FriendWishlistFollowing(
                                following: following,
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.network(
                                  following.followingUserPic,
                                  width: 200,
                                  height: 400,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              height: 400,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        following.followingUsername,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
