import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_favors/Utils/color_use.dart';
import 'package:sweet_favors/provider/token_provider.dart';

class FriendProfileBar extends StatefulWidget {
  final String images;
  final String name;
  final String email;
  final int? userId;
  final int? otherUserId;

  const FriendProfileBar({
    super.key,
    required this.images,
    required this.name,
    required this.email,
    this.userId,
    this.otherUserId,
  });

  @override
  State<FriendProfileBar> createState() => _FriendProfileBarState();
}

class _FriendProfileBarState extends State<FriendProfileBar> {
  bool _isFollowing = false;
  bool _isFollowed = false;

  @override
  void initState() {
    super.initState();
    fetchFriendCheck();
    fetchFollowerCheck();
  }

  Future<void> fetchFriendCheck() async {
    final token = Provider.of<TokenProvider>(context, listen: false).token;
    Dio dio = Dio(); // Create a Dio instance

    // Check if the current user (widget.userId) is following the other user (widget.otherUserId)
    final response1 = await dio.get(
      'http://10.0.2.2:1432/GetCheckFollowingYet/${widget.userId}/${widget.otherUserId}',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Adjust content type as needed
        },
      ),
    );

    if (response1.statusCode == 200 &&
        response1.data['user_id'] != null &&
        response1.data['following_id'] != null) {
      setState(() {
        _isFollowing = true;
      });
    }
  }

  Future<void> fetchFollowerCheck() async {
    final token = Provider.of<TokenProvider>(context, listen: false).token;
    Dio dio = Dio();

    // Check if the current user (widget.userId) is following the other user (widget.otherUserId)
    final response1 = await dio.get(
      'http://10.0.2.2:1432/GetCheckFollowingYet/${widget.otherUserId}/${widget.userId}',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Adjust content type as needed
        },
      ),
    );

    if (response1.statusCode == 200 &&
        response1.data['user_id'] != null &&
        response1.data['following_id'] != null) {
      setState(() {
        _isFollowed = true;
      });
    }
  }

  Future<void> handleUnfriend() async {
    final token = Provider.of<TokenProvider>(context, listen: false).token;
    try {
      final dio = Dio();

      // Delete the follow relationship
      final response = await dio.delete(
        'http://10.0.2.2:1432/DeleteUnFollowing/${widget.userId}/${widget.otherUserId}',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json', // Adjust content type as needed
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete follow relationship');
      }

      setState(() {
        _isFollowing = false;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> handleFollow() async {
    final token = Provider.of<TokenProvider>(context, listen: false).token;
    try {
      final dio = Dio();

      final response = await dio.post(
        'http://10.0.2.2:1432/PostAddToFollowing/${widget.userId}/${widget.otherUserId}',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json', // Adjust content type as needed
          },
        ),
      );

      if (response.statusCode == 201) {
        setState(() {
          _isFollowing = true;
        });
      } else {
        throw Exception('Failed to post follow relationship');
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // IconButton(
        //     onPressed: () => Navigator.pop(context),
        //     icon: const Icon(Icons.arrow_back, color: Colors.black)),
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(200, 124, 124, 124),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: CachedNetworkImageProvider(widget.images),
                ),
              ),
              const SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: colorUse.textColorPrimary,
                      shadows: [
                        Shadow(
                          blurRadius: 8.0,
                          color: Color.fromARGB(200, 124, 124, 124),
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    widget.email,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: colorUse.textColorSecondary,
                      shadows: [
                        Shadow(
                          blurRadius: 8.0,
                          color: Color.fromARGB(200, 124, 124, 124),
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              //If they're not mutuals, there will be an option to add them
              //If they're mutuals, the icon will change to another one
              const SizedBox(
                width: 45,
              ),
              if (_isFollowing)
                ElevatedButton(
                  onPressed: handleUnfriend,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 255, 0, 0)),
                    foregroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 255, 255, 255)),
                  ),
                  child: const Text(
                    "Unfriend",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                )
              else
                ElevatedButton(
                  onPressed: handleFollow,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(229, 253, 247, 255)),
                    foregroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(185, 109, 42, 128)),
                  ),
                  child: const Text(
                    "Add Friend",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
