import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sweet_favors/components/my_button.dart';
import 'package:sweet_favors/components/my_textfield.dart';
import 'package:sweet_favors/pages/home.dart';
import 'package:sweet_favors/provider/token_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text constrollers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Dio dio = Dio();

  void _login() async {
    final data = {
      "username": emailController.text,
      "password": passwordController.text,
    };

    try {
      final response = await _makeLoginRequest(data);

      if (response.statusCode == 200) {
        final token = response.data['token'];
        final userId = response.data['user_id'];
        Provider.of<TokenProvider>(context, listen: false)
            .setToken(token, userId);
        _navigateToFirstHomePage(token);
      } else {
        _showErrorMessage(
            'Login failed. Response status code: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorMessage('Login Failed');
    }
  }

  Future<Response> _makeLoginRequest(Map<String, dynamic> data) async {
    return dio.post(
      'http://10.0.2.2:1432/Login', // Use HTTPS
      data: data,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'secret': 'SweetSecret',
        },
      ),
    );
  }

  void _navigateToFirstHomePage(String token) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 90),
        child: Center(
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
                  hintText: 'Enter Username',
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
                  onTap: _login,
                ),

                const SizedBox(height: 40),

                //register here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
      ),
    );
  }
}
