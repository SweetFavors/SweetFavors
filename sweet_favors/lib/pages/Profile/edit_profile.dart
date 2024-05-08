import 'package:flutter/material.dart';
import 'package:sweet_favors/widgets/button_at_bottom.dart';
import 'package:sweet_favors/widgets/text_form.dart';
import 'package:sweet_favors/widgets/title_bar.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarPop(
        title: 'Edit profile',
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TextForm(label: 'First name'),
              const TextForm(label: 'Last name'),
              const TextForm(label: 'Username'),
              const TextForm(label: 'Phone number'),
              const SizedBox(
                height: 20,
              ),
              ButtonAtBottom(onPressed: () {}, text: 'SAVE PROFILE'),
            ],
          ),
        ),
      ),
    );
  }
}
