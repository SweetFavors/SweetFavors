import 'package:flutter/material.dart';
import 'package:sweet_favors/Auth/login.dart';
import 'package:sweet_favors/Auth/sign_up.dart';
import 'package:sweet_favors/Utils/color_use.dart';

class Welcome extends StatelessWidget {
  final VoidCallback onFinished;

  const Welcome({Key? key, required this.onFinished}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              "assets/Logo.png",
              width: 400,
              height: 400,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Welcome to Sweet Favors!',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: colorUse.textFriend)),
            const SizedBox(
              height: 35,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(
                      onTap: () {},
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 50),
                elevation: 5,
              ),
              child: const Text(
                "Login",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpPage(
                      onTap: () {},
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 50),
                elevation: 5,
                backgroundColor: colorUse.activeButton,
              ),
              child: const Text(
                "Register",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
