import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/color_use.dart';
import 'package:sweet_favors/pages/Friends/friend_wishlist_following.dart';
import 'package:sweet_favors/components/following_model.dart';
import 'package:sweet_favors/services/following_service.dart';

class FollowingContent extends StatefulWidget {
  const FollowingContent({super.key});

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
                  physics: BouncingScrollPhysics(),
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
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                following.followingUserPic,
                                width: 290,
                                height: 360,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              width: 290,
                              height: 360,
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
