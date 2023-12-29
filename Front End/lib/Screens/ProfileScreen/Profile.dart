import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Provider/user_provider.dart';
import 'package:my_app/Widgets/FormContainer.dart';
import 'package:my_app/Widgets/FormHeader.dart';
import 'package:my_app/Widgets/Text/FormLabel.dart';
import 'package:my_app/models/user.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _obscured = true;
  String? _Name;
  String? _CompanyName;
  String? _email;
  String? _tagLine;
  String? _newPassword;
  String? _wordLimit;
  String? _currentWordCount;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  _updateUserProfile() {}
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;
    print('user.name${user.name}');
    print('user.email${user.email}');

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double Hpad = 20.0;
    double Vpad = 10.0;
    return FormContainer(
      //
      addFormElements: Column(children: [
        FormHeader(
          headerText: 'Personal Account',
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Hpad, vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormLabelText(
                labelText: "Profile",
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Hpad, vertical: Vpad),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Color(0xffFFFFFF),
                radius: 55,
                child: CircleAvatar(
                  backgroundImage: NetworkImage('assets/images/avatar.jpg'),
                  radius: 50,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text:
                          "${user.name.isEmpty ? 'David king' : user.name}, Google Ltd.",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 28,
                          color: Color(0xff000000)),
                    ),
                    TextSpan(
                      text: "\nSenior Product Development Manager",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          letterSpacing: 0.0,
                          color: Color(0xff707070)),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Color(0xffE2E4FB),
          thickness: 1.0, // Adjust the thickness as needed
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Hpad, vertical: Vpad),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormLabelText(
                    labelText: "Full Name",
                  ),
                  Container(
                    width: width * 0.18,
                    height: height * 0.047,
                    decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      style: TextStyle(
                        color: Color(0xff8598AD),
                        fontSize: 16.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight
                            .w200, // FontWeight.w200 represents the "extra-light" weight
                        fontStyle: FontStyle.italic,
                      ),
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                            color: Color(0xff8598AD),
                            fontSize: 12.0,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight
                                .w200, // FontWeight.w200 represents the "extra-light" weight
                            fontStyle: FontStyle.italic,
                          ),
                          hintText:
                              '${user.name.isEmpty ? 'Enter Name' : user.name}',
                          contentPadding: const EdgeInsets.all(15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xffE2E4FB), //E2E4FB
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Color(0xff4C5AFE)),
                          )),
                      onChanged: (String value) {
                        // do something
                        setState(() {
                          _Name = value;
                          print("_Name=${_Name}");
                        });
                      },
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormLabelText(
                    labelText: "Company Name",
                  ),
                  Container(
                    width: width * 0.18,
                    height: height * 0.047,
                    decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      style: TextStyle(
                        color: Color(0xff8598AD),
                        fontSize: 16.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight
                            .w200, // FontWeight.w200 represents the "extra-light" weight
                        fontStyle: FontStyle.italic,
                      ),
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                            color: Color(0xff8598AD),
                            fontSize: 12.0,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight
                                .w200, // FontWeight.w200 represents the "extra-light" weight
                            fontStyle: FontStyle.italic,
                          ),
                          hintText: 'company',
                          contentPadding: const EdgeInsets.all(15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xffE2E4FB),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Color(0xff4C5AFE)),
                          )),
                      onChanged: (String value) {
                        // do something
                        setState(() {
                          _CompanyName = value;
                          print("_CompanyName=${_CompanyName}");
                        });
                      },
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormLabelText(
                    labelText: "Email",
                  ),
                  Container(
                    width: width * 0.18,
                    height: height * 0.047,
                    decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      style: TextStyle(
                        color: Color(0xff8598AD),
                        fontSize: 16.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight
                            .w200, // FontWeight.w200 represents the "extra-light" weight
                        fontStyle: FontStyle.italic,
                      ),
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                            color: Color(0xff8598AD),
                            fontSize: 12.0,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight
                                .w200, // FontWeight.w200 represents the "extra-light" weight
                            fontStyle: FontStyle.italic,
                          ),
                          hintText:
                              '${user.email.isEmpty ? 'Enter Name' : user.email}',
                          contentPadding: const EdgeInsets.all(15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xffE2E4FB), //E2E4FB
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Color(0xff4C5AFE)),
                          )),
                      onChanged: (String value) {
                        // do something
                        setState(() {
                          _email = value;
                          print("_firstName=${_email}");
                        });
                      },
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormLabelText(
                    labelText: "Last Name",
                  ),
                  Container(
                    width: width * 0.18,
                    height: height * 0.047,
                    decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      style: TextStyle(
                        color: Color(0xff8598AD),
                        fontSize: 16.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight
                            .w200, // FontWeight.w200 represents the "extra-light" weight
                        fontStyle: FontStyle.italic,
                      ),
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                            color: Color(0xff8598AD),
                            fontSize: 12.0,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight
                                .w200, // FontWeight.w200 represents the "extra-light" weight
                            fontStyle: FontStyle.italic,
                          ),
                          hintText: 'king',
                          contentPadding: const EdgeInsets.all(15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xffE2E4FB), //E2E4FB
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Color(0xff4C5AFE)),
                          )),
                      onChanged: (String value) {
                        // do something
                        setState(() {
                          _tagLine = value;
                        });
                        print("tag_line:$_tagLine");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          color: Color(0xffE2E4FB),
          thickness: 1.0, // Adjust the thickness as needed
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Hpad, vertical: Vpad),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormLabelText(
                    labelText: "Password",
                  ),
                  Container(
                    width: width * 0.18,
                    height: height * 0.047,
                    decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      //  obscuringCharacter: '●',
                      obscureText: _obscured,
                      style: TextStyle(
                        color: Color(0xff8598AD),
                        fontSize: 16.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight
                            .w200, // FontWeight.w200 represents the "extra-light" weight
                        fontStyle: FontStyle.italic,
                      ),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Color(0xff8598AD),
                          fontSize: 12.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight
                              .w200, // FontWeight.w200 represents the "extra-light" weight
                          fontStyle: FontStyle.italic,
                        ),
                        hintText: 'Enter Password',
                        contentPadding: const EdgeInsets.all(15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xffE2E4FB), //E2E4FB
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Color(0xff4C5AFE)),
                        ),
                        suffixIcon: InkWell(
                          onTap: _toggleObscured,

                          /// This is Magical Function
                          child: Icon(
                            _obscured
                                ?

                                /// CHeck Show & Hide.
                                Icons.visibility_outlined
                                : Icons.visibility_off,
                            color: Color(0xff9296C3),
                          ),
                        ),
                      ),
                      onChanged: (String value) {
                        // do something
                        setState(() {
                          _newPassword = value;
                          print("_newPassword=${_newPassword}");
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  Container(
                    width: width * 0.13,
                    height: height * 0.047,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Color(0xffE2E4FB),
                      ),
                      color: Color(0xff9296C3),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/save_as.png',
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Change Password',
                          style: GoogleFonts.firaSans(
                              fontSize: 14, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          color: Color(0xffE2E4FB),
          thickness: 1.0, // Adjust the thickness as needed
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Hpad, vertical: Vpad),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormLabelText(
                    labelText: "Word Limit",
                  ),
                  Container(
                    width: width * 0.18,
                    height: height * 0.047,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Color(0xffE2E4FB),
                      ),
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      enabled: false,
                      style: TextStyle(
                        color: Color(0xff8598AD),
                        fontSize: 16.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight
                            .w200, // FontWeight.w200 represents the "extra-light" weight
                        fontStyle: FontStyle.italic,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Color(0xff8598AD),
                          fontSize: 12.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight
                              .w200, // FontWeight.w200 represents the "extra-light" weight
                          fontStyle: FontStyle.italic,
                        ),
                        hintText: '6000',
                        contentPadding: const EdgeInsets.all(15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xffE2E4FB), //E2E4FB
                          ),
                        ),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          _wordLimit = value;
                          print("_wordLimit=${_wordLimit}");
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormLabelText(
                    labelText: "Current Word Count",
                  ),
                  Container(
                    width: width * 0.18,
                    height: height * 0.047,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Color(0xffE2E4FB),
                      ),
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      enabled: false,
                      style: TextStyle(
                        color: Color(0xff8598AD),
                        fontSize: 16.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight
                            .w200, // FontWeight.w200 represents the "extra-light" weight
                        fontStyle: FontStyle.italic,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Color(0xff8598AD),
                          fontSize: 12.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight
                              .w200, // FontWeight.w200 represents the "extra-light" weight
                          fontStyle: FontStyle.italic,
                        ),
                        hintText: '1500',
                        contentPadding: const EdgeInsets.all(15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          _currentWordCount = value;
                          print("_currentWordCount=${_currentWordCount}");
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: Hpad, left: Hpad, top: 15, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  _updateUserProfile();
                },
                child: Container(
                  width: width * 0.13,
                  height: height * 0.047,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Color(0xffE2E4FB),
                    ),
                    color: Color(0xffFF8203),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/save_as.png',
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        'Save',
                        style: GoogleFonts.firaSans(
                            fontSize: 14, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
