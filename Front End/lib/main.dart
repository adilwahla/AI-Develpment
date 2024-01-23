import 'package:flutter/material.dart';
import 'package:my_app/Provider/Auth_Provider.dart';
import 'package:my_app/Provider/EmailProcessProvider.dart';
import 'package:my_app/Provider/ImageProvider.dart';
import 'package:my_app/Provider/ProcessProvider.dart';
import 'package:my_app/Provider/ProfileUpdateProvider.dart';
import 'package:my_app/Provider/ReportProvider.dart';
import 'package:my_app/Provider/SelectedScreen.dart';

import 'package:my_app/Provider/SnackBarProvider.dart';
import 'package:my_app/Provider/SocialMediaProvider.dart';
import 'package:my_app/Provider/TranslationProvider.dart';
import 'package:my_app/Provider/user_provider.dart';
import 'package:my_app/Screens/HomeDashboard.dart';
import 'package:my_app/Screens/RegistrationPage.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/services/updatedUser.dart';

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
    ChangeNotifierProvider(create: (_) => ProcessProvider()),
    ChangeNotifierProvider(create: (_) => ReportProvider()),
    ChangeNotifierProvider(create: (_) => ImageUrlProvider()),
    ChangeNotifierProvider(create: (_) => ProfileUpdateProvider()),
    ChangeNotifierProvider(create: (_) => SelectedScreenProvider()),
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
    // Initialize user data from shared preferences
    initializeUserData();
  }

  // Initialize user data from shared preferences
  void initializeUserData() async {
    // Get the UserProvider instance
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    // Initialize user data from shared preferences
    await userProvider.initializeUser();

    // After initializing user data, you can perform other actions if needed
    // For example, navigate to another screen, show a message, etc.
    final UpdatedUser updatedUser = UpdatedUser();

    // Fetch updated user data after successful email generation

    User? fetchedUser = await updatedUser.fetchUpdatedUserData();
    // print('this is fetched user $fetchedUser');
    if (fetchedUser != null) {
      // Update the user in your UserProvider

      Provider.of<UserProvider>(context, listen: false).updateUser(fetchedUser);
    }
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
