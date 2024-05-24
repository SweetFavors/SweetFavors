import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_favors/Utils/color_use.dart';
import 'package:sweet_favors/pages/Friends/friend_wishlist_followers.dart';
import 'package:sweet_favors/components/follower_model.dart';
import 'package:sweet_favors/provider/token_provider.dart';
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
    final token = Provider.of<TokenProvider>(context, listen: false).token;
    final userId = Provider.of<TokenProvider>(context, listen: false).userId;
    final followers =
        await _followerService.fetchFollowersOfCurrentUser(token!, userId!);
    return followers;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: FutureBuilder<List<Follower>>(
        future: _followersFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(8.0),
              childAspectRatio: 0.7,
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
                    child: Container(
                      width: 200,
                      height: 400,
                      padding: const EdgeInsets.all(8.0), // Add padding here
                      child: Stack(
                        children: [
                          // Outline for border ja
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(22.5),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: colorUse.activeIconCircle,
                                    width:
                                        15, //don't change this to anything less than 15
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Image layer
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                follower.followerUserPic,
                                width: 200,
                                height: 400,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Text layer
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
                                      follower.followerUsername,
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
    );
  }
}
