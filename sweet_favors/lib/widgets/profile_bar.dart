import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/color_use.dart';
import 'package:sweet_favors/pages/Profile/profile.dart';
// import 'package:sweet_favors/pages/home.dart';

class ProfileBar extends StatelessWidget {
  final String images;
  final String name;
  final String email;

  const ProfileBar(
      {super.key,
      required this.images,
      required this.name,
      required this.email});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile Picture
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              );
            },
            child: CircleAvatar(
              radius: 40.0,
              backgroundImage: AssetImage(images),
            ),
          ),
        ),
        const SizedBox(width: 5.0), // Space between picture and text

        // Name and Email Column
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: colorUse.textColorPrimary,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: colorUse.textShadow,
                    offset: Offset(3, 3),
                  )
                ],
              ),
            ),
            Text(
              email,
              style: const TextStyle(
                fontSize: 13.0,
                color: colorUse.textColorSecondary,
                shadows: [
                  Shadow(
                    blurRadius: 15.0,
                    color: colorUse.textShadow,
                    offset: Offset(3, 3),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
