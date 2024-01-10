// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Provider/Auth_Provider.dart';
import 'package:my_app/Provider/user_provider.dart';
import 'package:my_app/Screens/HomeDashboard.dart';
import 'package:my_app/Utils.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/services/auth_services.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //TextEditingController nameController = TextEditingController();

  final AuthService authService = AuthService();
  bool _isChecked = false;

// Named function for login
  Future<void> handleLogin() async {
    Map<String, dynamic> response =
        await context.read<Auth_provider>().loginUser(
              emailController.text,
              passwordController.text,
            );
    print('this is response ${response['user']}');
    if (response['status']) {
      User user = response['user'];
      print('adil $user');
      Provider.of<UserProvider>(context, listen: false).setUser(user);

      // Navigate to HomeDashboard
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => HomeDashboard(),
        ),
        (route) => false,
      );
    } else {
      // Show Snack Bar with error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Authentication failed'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  final textFieldFocusNode = FocusNode();
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  handleOnCheck() {}
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Auth_provider>(context);

    // print('isLoading $isLoading');
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double yFactor = height * 0.1444;
    double xFactor = width * 0.0677;

    return Scaffold(
        backgroundColor: AppColors.mainBlueColor,
        // backgroundColor: const Color.fromARGB(255, 249, 0, 0),
        body: Row(
          children: [
            Expanded(
              child: Container(
                // color: AppColors.mainBlueColor, // Set your desired color
                width: width * 0.4635,
                height: double.infinity,
                // Other content for the left half
                child: Center(
                  child: Image.asset(
                    'assets/images/logoSignup.png', // Replace with the actual path to your image file
                    height: 140.0, // Adjust the height as needed
                    width: width * 0.3333, // Adjust the width as needed
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white, // Set your desired color
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        bottomLeft: Radius.circular(40))),
                height: double.infinity,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Back!",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff060C43),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 35.0),
                            child: Text(
                              'Amet minim mollit non desert.',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                color: Color(0xff626476),
                              ),
                            ),
                          ),
                          Container(
                            width: width * 0.25,
                            height: height * 0.0519,
                            child: TextFormField(
                              controller: emailController,
                              // onChanged: (String value) {
                              //   setState(() {
                              //     email = value;
                              //     print("email=${email}");
                              //   });
                              // },
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                color: Color(
                                    0xff060C43), // Set the text color for entered text
                                fontSize: 14.0, // Set the font size
                                height:
                                    1.2, // Line height as a multiplier (20% increase from the default)
                                letterSpacing:
                                    0.02, // Letter spacing as a percentage (2%)
                              ),
                              decoration: const InputDecoration(
                                hintText: "Enter Email",
                                labelText: "E-mail",
                                labelStyle: TextStyle(
                                  color: Color(0xff626476),
                                  fontSize: 12.0,
                                  height: 1.33, // Line height
                                  letterSpacing:
                                      0.02, // Letter spacing as a percentage
                                  fontFamily:
                                      'Inter', // Assuming 'Inter' is the font family
                                  fontWeight:
                                      FontWeight.normal, // Regular font weight
                                ),
                                hintStyle: TextStyle(color: Color(0xffBBBEE0)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xffBBBEE0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xffBBBEE0),
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14),
                            child: Container(
                              width: width * 0.25,
                              height: height * 0.0519,
                              child: TextFormField(
                                controller: passwordController,
                                // onChanged: (String value) {
                                //   setState(() {
                                //     password = value;
                                //     print("password=${password}");
                                //   });
                                // },
                                obscuringCharacter: '●',
                                obscureText: _obscured,
                                // textAlign: TextAlign.left,
                                textAlignVertical: TextAlignVertical.center,
                                style: GoogleFonts.inter(
                                  // fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  color: Color(
                                      0xff060C43), // Set the text color for entered text
                                  fontSize: 14.0, // Set the font size
                                  height:
                                      1.2, // Line height as a multiplier (20% increase from the default)
                                  letterSpacing:
                                      0.02, // Letter spacing as a percentage (2%)
                                ),
                                decoration: InputDecoration(
                                  //  suffixIconConstraints: BoxConstraints.tight(),

                                  contentPadding: EdgeInsets.only(
                                    top: 16,
                                    left: 8,
                                  ),
                                  // isDense: true,
                                  suffixIcon: InkWell(
                                    onTap: _toggleObscured,

                                    /// This is Magical Function
                                    child: Icon(
                                      _obscured
                                          ?

                                          /// CHeck Show & Hide.
                                          Icons.visibility_outlined
                                          : Icons.visibility_off,
                                      color: Color(0xff4C69FF),
                                    ),
                                  ),
                                  hintText: "Enter Password",
                                  labelText: "Password",

                                  labelStyle: TextStyle(
                                    color: Color(0xff626476),
                                    fontSize: 12.0,
                                    height: 1.2, // Line height
                                    letterSpacing:
                                        0.02, // Letter spacing as a percentage
                                    fontFamily:
                                        'Inter', // Assuming 'Inter' is the font family
                                    fontWeight: FontWeight
                                        .normal, // Regular font weight
                                  ),
                                  hintStyle:
                                      TextStyle(color: Color(0xffBBBEE0)),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xffBBBEE0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xffBBBEE0),
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: width * 0.25,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      activeColor: Color(0xff4C5AFE),
                                      value: _isChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isChecked = value ?? false;
                                        });
                                      },
                                    ),
                                    Text(
                                      "Remember Me",
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 12,
                                        height:
                                            1, // Equivalent to a line height of 20 (1.4286 * 14)
                                        letterSpacing:
                                            0.02, // 2% of the font size
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ],
                                ),
                                // SizedBox(
                                //   width: 185,
                                // ),
                                // SizedBox(width: 100),
                                TextButton(
                                  onPressed: () {
                                    // setState(() {
                                    //   register = !register;
                                    // });
                                  },
                                  child: Text(
                                    'Forgot Password',
                                    style: GoogleFonts.inter(
                                      decoration: TextDecoration.underline,

                                      fontSize: 12,
                                      height:
                                          1, // Equivalent to a line height of 20 (1.4286 * 14)
                                      letterSpacing:
                                          0.02, // 2% of the font size
                                      color: Color(0xff4C5AFE),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Container(
                            width: width * 0.25,
                            height: height * 0.0519,
                            decoration: BoxDecoration(
                                color: Color(0xff4C69FF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Center(
                                child: InkWell(onTap: () async {
                                  // signinUser(emailController.text,
                                  //     passwordController.text);
                                  // Call the signInUser function from AuthProvider
                                  await handleLogin();
                                }, child: Consumer<Auth_provider>(
                                  builder: ((context, authProvider, child) {
                                    return authProvider.loading
                                        ? CircularProgressIndicator()
                                        : Text(
                                            'Signin?',
                                            style: GoogleFonts.plusJakartaSans(
                                                fontSize: 16,
                                                color: Colors.white,
                                                height:
                                                    1.2, // Equivalent to a line height of 20 (1.4286 * 14)
                                                letterSpacing: 0.02,
                                                fontWeight: FontWeight.w600),
                                          );
                                  }),
                                )),
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
          ],
        ));
  }
}
