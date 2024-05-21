import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweet_favors/pages/welcome.dart';
import 'package:sweet_favors/provider/token_provider.dart';
import 'Auth/login_or_register.dart';
import 'pages/Navbar/first_home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TokenProvider()),
        ChangeNotifierProvider(create: (context) => WelcomeProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class WelcomeProvider with ChangeNotifier {
  bool _isWelcomeShown = false;

  bool get isWelcomeShown => _isWelcomeShown;

  Future<void> checkWelcomeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isWelcomeShown = prefs.getBool('isWelcomeShown') ?? false;
    notifyListeners();
  }

  Future<void> setWelcomeShown() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isWelcomeShown', true);
    _isWelcomeShown = true;
    notifyListeners();
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    Provider.of<WelcomeProvider>(context, listen: false).checkWelcomeStatus();
  }

  @override
  Widget build(BuildContext context) {
    final tokenProvider = Provider.of<TokenProvider>(context);
    final welcomeProvider = Provider.of<WelcomeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Inter'),
      home: !welcomeProvider.isWelcomeShown
          ? Welcome(onFinished: () {
              welcomeProvider.setWelcomeShown();
            })
          : tokenProvider.token == null
              ? const LoginOrRegister()
              : const FirstHomePage(),
    );
  }
}
