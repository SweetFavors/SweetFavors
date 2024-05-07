import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/color_use.dart';
import 'package:sweet_favors/pages/Friends/friend_wishlist.dart';
import 'package:sweet_favors/components/following_model.dart';
import 'package:sweet_favors/services/following_service.dart';

class FollowingContent extends StatefulWidget {
  const FollowingContent({super.key});

  @override
  State<FollowingContent> createState() => _FollowingContentState();
}

class _FollowingContentState extends State<FollowingContent> {
  late FollowingService _followingService;
  late List<Following> _followings;

  @override
  void initState() {
    super.initState();
    _followingService = FollowingService(Dio());
    _fetchFollowings();
  }

  Future<void> _fetchFollowings() async {
    final followings = await _followingService.fetchFollowingOfCurrentUser(1);
    setState(() {
      _followings = followings;
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
            children: _followings.map((following) {
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
