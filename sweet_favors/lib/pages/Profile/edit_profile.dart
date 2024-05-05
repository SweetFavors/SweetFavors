import 'package:flutter/material.dart';
import 'package:sweet_favors/widgets/button_at_bottom.dart';
import 'package:sweet_favors/widgets/text_form.dart';
import 'package:sweet_favors/widgets/title_bar.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarPop(title: 'Edit profile', centerTitle: true,),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextForm(label: 'First name'),
            TextForm(label: 'Last name'),
            TextForm(label: 'Username'),
            TextForm(label: 'Phone number'),
            SizedBox(height: 20,),
            ButtonAtBottom(onPressed: () {}, text: 'SAVE PROFILE'),
          ],
        ),
      ),
    );
  }
}