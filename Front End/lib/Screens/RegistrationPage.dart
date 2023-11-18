import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Provider/Auth_Provider.dart';
import 'package:my_app/Utils.dart';
import 'package:my_app/Widgets/Responsive/Responsive_widget.dart';
import 'package:my_app/config.dart';
import 'package:my_app/main.dart';
import 'package:my_app/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool _isNotValidate = false;
  bool register = false;
  final AuthService authService = AuthService();
  bool _isChecked = false;
  void signinUser() {
    authService.signInUser(
      context: context,
      email: emailController.text,
      password: passwordController.text,
    );
  }

  void signupUser() {
    authService.signUpUser(
        context: context,
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text);
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
    // final authProvider = Provider.of<Auth_provider>(context);

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
                          Visibility(
                            //// username
                            visible: register == true,
                            child: Container(
                              width: width * 0.25,
                              height: height * 0.0519,
                              child: TextFormField(
                                controller: nameController,
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
                                  hintText: "Enter Name",
                                  labelText: "Name",
                                  labelStyle: TextStyle(
                                    color: Color(0xff626476),
                                    fontSize: 12.0,
                                    height: 1.33, // Line height
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
                          Visibility(
                            //// username
                            visible: register == true,
                            child: SizedBox(
                              height: 14,
                            ),
                          ),
                          Container(
                            width: width * 0.25,
                            height: height * 0.0519,
                            child: TextFormField(
                              controller: emailController,
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
                                    setState(() {
                                      register = !register;
                                    });
                                  },
                                  child: Text(
                                    register == true
                                        ? "Signup"
                                        : 'Forgot Password',
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
                                child: InkWell(
                                  onTap: () {
                                    register == true
                                        ? signupUser()
                                        : signinUser();
                                  },
                                  child: Text(
                                    register == true ? "Signup" : 'Signin?',
                                    style: GoogleFonts.plusJakartaSans(
                                        fontSize: 16,
                                        color: Colors.white,
                                        height:
                                            1.2, // Equivalent to a line height of 20 (1.4286 * 14)
                                        letterSpacing: 0.02,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Expanded(
                              //   child: Container(
                              //     margin: const EdgeInsets.only(
                              //         left: 10.0, right: 15.0),
                              //     child: Divider(
                              //       height: 10,
                              //       // width: 155,
                              //       color: Color(0xffBBBEE0),
                              //     ),
                              //   ),
                              // ),

                              Container(
                                margin: EdgeInsets.only(left: 5, right: 3),
                                width: width * 0.093,
                                height: 1,
                                color: Color(0xffBBBEE0),
                              ),
                              Text(
                                " or sign in with ",
                                style: GoogleFonts.inter(
                                    color: Color(0XFF626476),
                                    fontSize: 14,
                                    height: 1.1429,
                                    letterSpacing: 0.02,
                                    fontWeight: FontWeight.normal),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 3, right: 15),
                                width: width * 0.093 - 10,
                                height: 1,
                                color: Color(0xffBBBEE0),
                              ),

                              // Expanded(
                              //   child: Container(
                              //     margin: const EdgeInsets.only(
                              //         left: 15.0, right: 10.0),
                              //     child: Divider(
                              //       height: 10,
                              //       // width: 155,
                              //       color: Color(0xffBBBEE0),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Container(
                            width: width * 0.25,
                            height: height * 0.0519,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffBBBEE0)),
                              // color: Color(0xff4C69FF),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Container(
                                    height: 18,
                                    child:
                                        Image.asset('assets/images/google.png'),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Center(
                                  child: Text(
                                    'Sign in with google',
                                    style: GoogleFonts.plusJakartaSans(
                                        fontSize: 16,
                                        color: Color(0xff060C43),
                                        height:
                                            0.5, // Equivalent to a line height of 20 (1.4286 * 14)
                                        letterSpacing: 0.02,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
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

// SizedBox(
//         height: height,
//         width: width,
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             ResponsiveWidget.isSmallScreen(context)
//                 ? const SizedBox()
//                 : Expanded(
//                     child: Container(
//                       height: height,
//                       color: AppColors.mainBlueColor,
//                       child: Center(
//                         child: Image.asset(
//                           'assets/images/logoSignup.png', // Replace with the actual path to your image file
//                           height: 140.0, // Adjust the height as needed
//                           width: 620.0, // Adjust the width as needed
//                         ),
//                       ),
//                     ),
//                   ),
//             Expanded(
//               child: Container(
//                 height: height,
//                 margin: EdgeInsets.symmetric(
//                     horizontal: ResponsiveWidget.isSmallScreen(context)
//                         ? height * 0.032
//                         : height * 0.12),
//                 color: AppColors.backColor,
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.only(bottom: 40.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       SizedBox(height: height * 0.2),
//                       RichText(
//                         text: const TextSpan(
//                           children: [
//                             // TextSpan(
//                             //     text: 'Let’s',
//                             //     style: TextStyle(
//                             //       fontSize: 25.0,
//                             //       color: AppColors.blueDarkColor,
//                             //       fontWeight: FontWeight.normal,
//                             //     )),
//                             TextSpan(
//                               text: ' Welcome Back!',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w800,
//                                 color: AppColors.blueDarkColor,
//                                 fontSize: 25.0,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: height * 0.02),
//                       const Text(
//                         'Hey, Enter your details to get sign in',
//                         style: TextStyle(
//                           fontSize: 12.0,
//                           fontWeight: FontWeight.w400,
//                           color: AppColors.textColor,
//                         ),
//                       ),
//                       SizedBox(height: height * 0.064),
//                       Visibility(
//                         visible: register == true,
//                         child: const Padding(
//                           padding: EdgeInsets.only(left: 16.0),
//                           child: Text(
//                             'Name',
//                             style: TextStyle(
//                               fontSize: 12.0,
//                               color: AppColors.blueDarkColor,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Visibility(
//                         visible: register == true,
//                         child: Container(
//                           height: 50.0,
//                           width: width,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(16.0),
//                             color: AppColors.whiteColor,
//                           ),
//                           child: TextFormField(
//                             controller: nameController,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w400,
//                               color: AppColors.blueDarkColor,
//                               fontSize: 12.0,
//                             ),
//                             decoration: InputDecoration(
//                               border: InputBorder.none,
//                               contentPadding: const EdgeInsets.only(top: 16.0),
//                               hintText: '   Enter Name',
//                               hintStyle: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 color: AppColors.blueDarkColor.withOpacity(0.5),
//                                 fontSize: 12.0,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 6.0),
//                       const Padding(
//                         padding: EdgeInsets.only(left: 16.0),
//                         child: Text(
//                           'Email',
//                           style: TextStyle(
//                             fontSize: 12.0,
//                             color: AppColors.blueDarkColor,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 6.0),
//                       Container(
//                         height: 50.0,
//                         width: width,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(16.0),
//                           color: AppColors.whiteColor,
//                         ),
//                         child: TextFormField(
//                           controller: emailController,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w400,
//                             color: AppColors.blueDarkColor,
//                             fontSize: 12.0,
//                           ),
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             // prefixIcon: IconButton(
//                             //   onPressed: () {},
//                             //   icon: Image.asset('assets/EmailIcon.png'),
//                             // ),
//                             contentPadding: const EdgeInsets.only(top: 16.0),
//                             hintText: 'Enter Email',
//                             hintStyle: TextStyle(
//                               fontWeight: FontWeight.w400,
//                               color: AppColors.blueDarkColor.withOpacity(0.5),
//                               fontSize: 12.0,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: height * 0.014),
//                       const Padding(
//                         padding: EdgeInsets.only(left: 16.0),
//                         child: Text(
//                           'Password',
//                           style: TextStyle(
//                             fontSize: 12.0,
//                             color: AppColors.blueDarkColor,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 6.0),
//                       Container(
//                         height: 50.0,
//                         width: width,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(16.0),
//                           color: AppColors.whiteColor,
//                         ),
//                         child: TextFormField(
//                           controller: passwordController,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w400,
//                             color: AppColors.blueDarkColor,
//                             fontSize: 12.0,
//                           ),
//                           obscureText: true,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             // suffixIcon: IconButton(
//                             //   onPressed: () {},
//                             //   icon: Image.asset('assets/EyeIcon.png'),
//                             // ),
//                             // prefixIcon: IconButton(
//                             //   onPressed: () {},
//                             //   icon: Image.asset('assets/lockIcon.png'),
//                             // ),
//                             contentPadding: const EdgeInsets.only(top: 16.0),
//                             hintText: 'Enter Password',
//                             hintStyle: TextStyle(
//                               fontWeight: FontWeight.w400,
//                               color: AppColors.blueDarkColor.withOpacity(0.5),
//                               fontSize: 12.0,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: height * 0.03),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: TextButton(
//                           onPressed: () {
//                             setState(() {
//                               register = !register;
//                             });
//                           },
//                           child: Text(
//                             register == true ? "Signin" : 'Signup?',
//                             style: TextStyle(
//                               fontSize: 12.0,
//                               color: AppColors.mainBlueColor,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: height * 0.05),
//                       Material(
//                         color: Colors.transparent,
//                         child: InkWell(
//                           onTap: () {
//                             //login button function
//                             // apiClient.login(emailController.text.toString(),
//                             //     passwordController.text.toString());
//                             // signupUser();

//                             register == true ? signupUser() : signinUser();
//                           },
//                           borderRadius: BorderRadius.circular(16.0),
//                           child: Ink(
//                             width: width,
//                             height: 50.0,
//                             padding: const EdgeInsets.only(left: 16.0),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(16.0),
//                               color: AppColors.mainBlueColor,
//                             ),
//                             child: Center(
//                               child: Text(
//                                 register == true ? "Signup" : 'Sign In',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w700,
//                                   color: AppColors.whiteColor,
//                                   fontSize: 16.0,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
