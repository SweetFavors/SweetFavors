import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/color_use.dart';
import 'package:sweet_favors/pages/home.dart';

class FriendProfileBar extends StatelessWidget {
  final String images;
  final String name;
  final String email;

  const FriendProfileBar(
      {super.key,
      required this.images,
      required this.name,
      required this.email});

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
                  backgroundImage: CachedNetworkImageProvider(images),
                ),
              ),
              const SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
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
                    email,
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
            ],
          ),
        ),
      ],
    );
  }
}
