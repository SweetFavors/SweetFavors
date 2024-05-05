import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/color_use.dart';
import 'package:sweet_favors/Utils/text_use.dart';
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

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: const CustomAppBarPopNoTitle(),
      body: Column(
              children: [
              buildtop(),
              buildContent(),
              const Spacer(),
              logout(),
              
              ]

    )
    ,bottomNavigationBar: bottomBar(),);
  }

Widget logout () {

  return ButtonAtBottom(onPressed: () {



  }, text: 'Logout');
}

Widget buildContent () {

  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      child: Column(
        children: [
          RegularText('THE JUSTICE'),
          SizedBox(height: 20,),
          RegularText('Email | phone num'),
          SizedBox(height: 40,),
          ProfileCard(product: 'Edit profile information',icon: Icons.edit_square,),
          ProfileCard(product: 'Privacy policy', icon: Icons.policy,),
        ],
      ),
    ),
  );
}

Widget buildtop () {
   final top = coverHeight - profileHeight/2;
   final bottom = profileHeight/2;

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

Widget backgroundColorSquare () => Container(
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          height: coverHeight,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: colorUse.primaryColor,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(220,60),
                                                            bottomRight: Radius.elliptical(220, 60) ),
                          ),
                        ),
                      ),
                      
                    ],
                  ));

Widget pictureOverlay () => CircleAvatar(
  radius: profileHeight/2,
  backgroundImage: AssetImage('assets/myGirl.png'),
);
}
