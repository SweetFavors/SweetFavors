import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_favors/provider/token_provider.dart';
import 'package:sweet_favors/widgets/button_at_bottom.dart';
import 'package:sweet_favors/widgets/text_form.dart';
import 'package:sweet_favors/widgets/title_bar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? username;
  String? email;
  String? fname;
  String? lname;
  String? phoneNum;

  final _formKey = GlobalKey<FormState>();
  final _textControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
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
      final parsedJson = response.data; // Directly get the parsed data
      setState(() {
        // Update the username and email variables with the parsed user data
        username = parsedJson['username'];
        email = parsedJson['email'];
        fname = parsedJson['firstname'];
        lname = parsedJson['lastname'];
        phoneNum = parsedJson['phone_num'];

        // Initialize the text controllers with the fetched data
        _textControllers[0].text = fname ?? '';
        _textControllers[1].text = lname ?? '';
        _textControllers[2].text = username ?? '';
        _textControllers[3].text = phoneNum ?? '';
        _textControllers[4].text = email ?? '';
      });
    } else {
      throw Exception('Failed to load user data');
    }
  }

  Future<void> updateUserProfile() async {
    Dio dio = Dio();
    final token = Provider.of<TokenProvider>(context, listen: false).token;
    final userId = Provider.of<TokenProvider>(context, listen: false).userId;
    final data = {
      "username": _textControllers[2].text,
      "email": _textControllers[4].text,
      "firstname": _textControllers[0].text,
      "lastname": _textControllers[1].text,
      "phone_num": _textControllers[3].text,
    };

    final response = await dio.patch(
      'http://10.0.2.2:1432/UpdateEditUserProfile/$userId',
      data: json.encode(data),
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Adjust content type as needed
        },
      ),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile')),
      );
    }
  }

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
            children: [
              ..._textControllers.asMap().entries.map((entry) {
                final index = entry.key;
                final controller = entry.value;
                return TextForm(
                  label: [
                    'First name',
                    'Last name',
                    'Username',
                    'Phone number',
                    'Email'
                  ][index],
                  controller: controller,
                );
              }).toList(),
              const SizedBox(height: 20),
              ButtonAtBottom(
                onPressed: updateUserProfile,
                text: 'SAVE PROFILE',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
