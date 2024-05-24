import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sweet_favors/Auth/login.dart';
import 'package:sweet_favors/components/my_button.dart';
import 'package:sweet_favors/components/my_textfield.dart';
import 'package:sweet_favors/widgets/add_image.dart';

class SignUpPage extends StatefulWidget {
  final void Function()? onTap;

  const SignUpPage({super.key, required this.onTap});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  File? _selectedImage;
  //text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();

  Future<void> signUp() async {
    // Validate the form fields
    if (fnameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPwController.text.isEmpty ||
        usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    if (passwordController.text != confirmPwController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    // Send the POST request to the registration endpoint
    final dio = Dio();
    var payload = FormData.fromMap({
      "username": usernameController.text,
      "password": passwordController.text,
      "email": emailController.text,
      "firstname": fnameController.text,
      "lastname": lnameController.text,
      "phonenum": phoneNumController.text,
      'file': await MultipartFile.fromFile(
        _selectedImage!.path,
        filename: _selectedImage!.path.split('/').last,
      ),
    });

    try {
      final response = await dio.post(
        'http://10.0.2.2:1432/Register',
        data: payload,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 201) {
        // Registration successful
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful')),
        );
        // Clear the form fields
        usernameController.clear();
        fnameController.clear();
        lnameController.clear();
        phoneNumController.clear();
        emailController.clear();
        passwordController.clear();
        confirmPwController.clear();

        //navigate to LoginPage()
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        // Registration failed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusCode}')),
        );
      }
    } catch (e) {
      // Network error or other exception
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: Failed to connect to server')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //app name0
                const Text(
                  "Register",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 50),

                //username textfield
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "username",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(height: 5),
                    MyTextField(
                      hintText: 'Input your username',
                      obscureText: false,
                      controller: usernameController,
                      border: true,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "first name",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(height: 5),
                    MyTextField(
                      hintText: 'Input your first name',
                      obscureText: false,
                      controller: fnameController,
                      border: true,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "last name",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(height: 5),
                    MyTextField(
                      hintText: 'Input your last name',
                      obscureText: false,
                      controller: lnameController,
                      border: true,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                //email textfield
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "email",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(height: 5),
                    MyTextField(
                      hintText: 'Input email address',
                      obscureText: false,
                      controller: emailController,
                      border: true,
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "phone number",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(height: 5),
                    MyTextField(
                      hintText: 'Input Your phone number',
                      obscureText: false,
                      controller: phoneNumController,
                      border: true,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                //password textfield
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "password",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(height: 5),
                    MyTextField(
                      hintText: 'Enter Password',
                      obscureText: true,
                      controller: passwordController,
                      iconData: Icons.remove_red_eye_outlined,
                      border: true,
                      onIconPressed: () {
                        // Callback function to be called when the icon is pressed
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "confirm password",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(height: 5),
                    MyTextField(
                      hintText: 'Confirm Password',
                      obscureText: true,
                      controller: confirmPwController,
                      iconData: Icons.remove_red_eye_outlined,
                      border: true,
                      onIconPressed: () {
                        // Callback function to be called when the icon is pressed
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: AddImage(
                      onImageSelected: (image) {
                        if (image != null) {
                          setState(() {
                            _selectedImage = image;
                          });
                        }
                      },
                      textfill: 'Please add profile picture'),
                ),

                //sign in button
                MyButton(
                  text: "Sign Up",
                  width: 400,
                  height: 50,
                  onTap: signUp,
                ),

                const SizedBox(height: 30),

                //horizontal line
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey.shade400,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 205, 204, 204),
                          Color.fromARGB(255, 205, 204, 204)
                        ],
                        stops: [0.5, 0.5],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),
                //register here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Sign in",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4461F2),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
