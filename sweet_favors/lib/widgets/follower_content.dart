import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/color_use.dart';
import 'package:sweet_favors/pages/Friends/friend_wishlist_followers.dart';
import 'package:sweet_favors/pages/Friends/friend_wishlist_following.dart';
import 'package:sweet_favors/components/follower_model.dart';
import 'package:sweet_favors/services/follower_service.dart';

class FollowerContent extends StatefulWidget {
  const FollowerContent({super.key});

  @override
  State<FollowerContent> createState() => _FollowerContentState();
}

class _FollowerContentState extends State<FollowerContent> {
  late FollowerService _followerService;
  late Future<List<Follower>> _followersFuture;

  @override
  void initState() {
    super.initState();
    _followerService = FollowerService(Dio());
    _followersFuture = _fetchFollowers();
  }

  Future<List<Follower>> _fetchFollowers() async {
    final followers = await _followerService.fetchFollowersOfCurrentUser(1);
    return followers;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(bottom: 25),
          child: FutureBuilder<List<Follower>>(
            future: _followersFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: snapshot.data!.map((follower) {
                    return Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FriendWishlistFollowers(
                                follower: follower,
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                follower.followerUserPic,
                                width: 290,
                                height: 360,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 290,
                              height: 360,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      follower.followerUsername,
                                      style: TextStyle(
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
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
