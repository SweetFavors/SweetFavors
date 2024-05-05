import 'package:flutter/material.dart';
import 'package:sweet_favors/components/my_button.dart';
import 'package:sweet_favors/components/my_textfield.dart';

class SignUpPage extends StatefulWidget {
  final void Function()? onTap;

  const SignUpPage({super.key, required this.onTap});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                    hintText: 'Input your first name',
                    obscureText: false,
                    controller: usernameController,
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
                    hintText: 'Input email adress',
                    obscureText: false,
                    controller: emailController,
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

              //sign in button
              MyButton(
                text: "Sign Up",
                width: 400,
                height: 50,
                onTap: () {},
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
    );
  }
}
