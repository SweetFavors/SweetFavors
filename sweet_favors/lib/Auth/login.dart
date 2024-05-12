import 'package:flutter/material.dart';
import 'package:sweet_favors/components/my_button.dart';
import 'package:sweet_favors/components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text constrollers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              //app name0
              const Text(
                "Sign In",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 50),

              //email textfield
              MyTextField(
                hintText: 'Enter Email',
                obscureText: false,
                controller: emailController,
              ),

              const SizedBox(height: 20),

              //password textfield
              MyTextField(
                hintText: 'Enter Password',
                obscureText: true,
                controller: passwordController,
                iconData: Icons.remove_red_eye_outlined,
                onIconPressed: () {
                  // Callback function to be called when the icon is pressed
                },
              ),

              const SizedBox(height: 25),

              //forgot password
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Text(
              //       "Forgot Password",
              //       style: TextStyle(
              //         color: Theme.of(context).colorScheme.secondary,
              //       ),
              //     )
              //   ],
              // ),

              const SizedBox(height: 25),

              //sign in button
              MyButton(
                text: "Sign In",
                width: 400,
                height: 58,
                onTap: () {},
              ),

              const SizedBox(height: 40),

              //register here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Register Here",
                      style: TextStyle(
                        fontSize: 18,
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
