import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_favors/Auth/login_or_register.dart';
import 'package:sweet_favors/Utils/color_use.dart';
import 'package:sweet_favors/Utils/text_use.dart';
import 'package:sweet_favors/pages/Profile/edit_profile.dart';
import 'package:sweet_favors/pages/Profile/eula.dart';
import 'package:sweet_favors/provider/token_provider.dart';
import 'package:sweet_favors/widgets/button_at_bottom.dart';
import 'package:sweet_favors/widgets/card_widget.dart';
import 'package:sweet_favors/widgets/title_bar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final double coverHeight = 250;
  final double profileHeight = 150;
  String? username;
  String? email;
  String? phoneNum;

  Future<Map<String, dynamic>>? _userData;

  @override
  void initState() {
    super.initState();
    _userData = fetchUserData();
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    final token = Provider.of<TokenProvider>(context, listen: false).token;
    final userId = Provider.of<TokenProvider>(context, listen: false).userId;

    Dio dio = Dio();
    final response = await dio.get(
      'http://10.0.2.2:1432/GetProfileOfCurrentUser/$userId',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Adjust content type as needed
        },
      ),
    );

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<Map<String, dynamic>>(
              future: _userData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Display a loading indicator while data is being fetched
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final userData = snapshot.data;
                  return Column(
                    children: [
                      buildtop(userData),
                      const SizedBox(
                        height: 20,
                      ),
                      RegularTextBold(userData?['username'] ?? ''),
                      const SizedBox(
                        height: 15,
                      ),
                      RegularText(
                          '${userData?['email'] ?? "Thejustice@gmail.com"} | ${userData?['phone_num'] ?? "123-456-7890"}'),
                      const SizedBox(
                        height: 40,
                      ),
                      const ProfileCard(
                        product: 'Edit profile information',
                        icon: Icons.edit_square,
                        destination: EditProfile(),
                      ),
                      const ProfileCard(
                        product: 'Privacy policy',
                        icon: Icons.policy,
                        destination: Eula(),
                      ),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 50), // Add some spacing at the bottom
            logout(),
          ],
        ),
      ),
    );
  }

  Widget logout() {
    void logoutFunction() {
      // Notify the TokenProvider that the token has been cleared
      Provider.of<TokenProvider>(context, listen: false).setToken("", 0);

      // Navigate to the login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginOrRegister()),
      );
    }

    return ButtonAtBottom(onPressed: logoutFunction, text: 'Logout');
  }

  Widget buildtop(Map<String, dynamic>? userData) {
    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: backgroundColorSquare(),
        ),
        Positioned(
          top: top,
          child: pictureOverlay(userData),
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
                    bottomRight: Radius.elliptical(220, 60),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget pictureOverlay(Map<String, dynamic>? userData) {
    final profilePic = userData?['user_pic'] ?? '';
    return CircleAvatar(
      radius: profileHeight / 2,
      backgroundImage: CachedNetworkImageProvider(profilePic),
    );
  }
}
