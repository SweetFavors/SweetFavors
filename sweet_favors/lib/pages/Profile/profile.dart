import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/color_use.dart';
import 'package:sweet_favors/Utils/text_use.dart';
import 'package:sweet_favors/pages/Profile/edit_profile.dart';
import 'package:sweet_favors/pages/Profile/eula.dart';
import 'package:sweet_favors/widgets/bottomBar.dart';
import 'package:sweet_favors/widgets/button_at_bottom.dart';
import 'package:sweet_favors/widgets/card_widget.dart';
import 'package:sweet_favors/widgets/title_bar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final double coverHeight = 250;
  final double profileHeight = 150;
  String? username;
  String? email;
  String? phoneNum;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    Dio dio = Dio();
    final response =
        await dio.get('http://10.0.2.2:1432/GetProfileOfCurrentUser/3');

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBarPopNoTitle(),
        body: Column(children: [
          buildtop(),
          buildContent(),
          const Spacer(),
          logout(),
        ])
        // ,bottomNavigationBar: bottomBar(),
        );
  }

  Widget logout() {
    return ButtonAtBottom(onPressed: () {}, text: 'Logout');
  }

  Widget buildContent() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        child: Column(
          children: [
            FutureBuilder<Map<String, dynamic>>(
              future: fetchUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Display a loading indicator while data is being fetched
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final userData = snapshot.data;
                  return Column(
                    children: [
                      RegularText(userData?['username'] ?? ''),
                      SizedBox(
                        height: 20,
                      ),
                      RegularText(
                          '${userData?['email'] ?? "Thejustice@gmail.com"} | ${userData?['phone_num'] ?? "123-456-7890"}'),
                      SizedBox(
                        height: 40,
                      ),
                      ProfileCard(
                        product: 'Edit profile information',
                        icon: Icons.edit_square,
                        destination: EditProfile(),
                      ),
                      ProfileCard(
                        product: 'Privacy policy',
                        icon: Icons.policy,
                        destination: Eula(),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildtop() {
    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
            margin: EdgeInsets.only(bottom: bottom),
            child: backgroundColorSquare()),
        Positioned(
          top: top,
          child: pictureOverlay(),
        )
      ],
    );
  }

  Widget backgroundColorSquare() => Container(
          child: Column(
        children: [
          Center(
            child: Container(
              height: coverHeight,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: colorUse.primaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(220, 60),
                    bottomRight: Radius.elliptical(220, 60)),
              ),
            ),
          ),
        ],
      ));

  Widget pictureOverlay() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundImage: AssetImage('assets/myGirl.png'),
      );
}
