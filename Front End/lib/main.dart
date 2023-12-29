import 'package:flutter/material.dart';
import 'package:my_app/Provider/Auth_Provider.dart';
import 'package:my_app/Provider/EmailProcessProvider.dart';

import 'package:my_app/Provider/SnackBarProvider.dart';
import 'package:my_app/Provider/SocialMediaProvider.dart';
import 'package:my_app/Provider/TranslationProvider.dart';
import 'package:my_app/Provider/user_provider.dart';
import 'package:my_app/Screens/HomeDashboard.dart';
import 'package:my_app/Screens/RegistrationPage.dart';
import 'package:my_app/services/auth_services.dart';
import 'package:my_app/services/emailService.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

var isLoggedIn = false;
void main() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("x-auth-token") &&
      // ignore: unnecessary_null_comparison
      prefs.containsKey("x-auth-token") != null &&
      prefs.containsKey("x-auth-token").toString().isNotEmpty) {
    isLoggedIn = true;
  }
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => Auth_provider()),
    ChangeNotifierProvider(create: (_) => SnackBarProvider()),
    ChangeNotifierProvider(create: (_) => EmailProvider()),
    ChangeNotifierProvider(create: (_) => TranslationProvider()),
    ChangeNotifierProvider(create: (_) => SocialMediaProvider()),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserProvider userProvider = UserProvider();

  @override
  void initState() {
    super.initState();
    // userProvider.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: Scaffold(body: isLoggedIn ? HomeDashboard() : LoginScreen()),
    );
  }
}
