import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Provider/Auth_Provider.dart';
import 'package:my_app/Provider/user_provider.dart';
import 'package:my_app/Screens/HomeDashboard.dart';
import 'package:my_app/Screens/RegistrationPage.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

var isLoggedIn = false;
void main() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("x-auth-token") &&
      prefs.containsKey("x-auth-token") != null &&
      prefs.containsKey("x-auth-token").toString().isNotEmpty) {
    isLoggedIn = true;
  }
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => Auth_provider()),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: isLoggedIn ? HomeDashboard() : LoginScreen()),
    );
  }
}
