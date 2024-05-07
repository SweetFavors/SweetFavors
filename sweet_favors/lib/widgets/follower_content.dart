import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/color_use.dart';
import 'package:sweet_favors/pages/Friends/friend_wishlist.dart';
import 'package:sweet_favors/components/follower_model.dart';
import 'package:sweet_favors/services/follower_service.dart';

class FollowerContent extends StatefulWidget {
  const FollowerContent({super.key});

  @override
  State<FollowerContent> createState() => _FollowerContentState();
}

class _FollowerContentState extends State<FollowerContent> {
  late FollowerService _followerService;
  late List<Follower> _followers;

  @override
  void initState() {
    super.initState();
    _followerService = FollowerService(Dio());
    _fetchFollowers();
  }

  Future<void> _fetchFollowers() async {
    final followers = await _followerService.fetchFollowersOfCurrentUser(1);
    setState(() {
      _followers = followers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(bottom: 25),
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: _followers.map((follower) {
              return Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FriendWishlist(),
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
                      Container(
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
          ),
        ),
      ),
    );
  }
}
