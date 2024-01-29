import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http_parser/http_parser.dart';
import 'package:my_app/Provider/ImageProvider.dart';
import 'package:my_app/Provider/ProcessProvider.dart';
import 'package:my_app/Provider/ProfileUpdateProvider.dart';
import 'package:my_app/Provider/user_provider.dart';
import 'package:my_app/Widgets/FormContainer.dart';
import 'package:my_app/Widgets/FormHeader.dart';
import 'package:my_app/Widgets/Text/FormLabel.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/services/updatedUser.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    // Load the initial image URL from shared preferences

    super.initState();
    getStoredImageUrl();
  }

  bool _obscured = true;
  String? _Name;
  String? _CompanyName;
  String? _email;
  String? _tagLine;
  String? _newPassword;
  String? _wordLimit;
  String? _currentWordCount;
  String? _imgURL;
  String bg =
      "http://res.cloudinary.com/duxr6edeo/image/upload/v1705603007/profile/fe3p6x9jpztwzctvivcc.jpg";
  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  Future<void> getStoredImageUrl() async {
    final prefs = await SharedPreferences.getInstance();
    final imageUrl = prefs.getString('profilePicture');

    if (imageUrl != null) {
      setState(() {
        _imgURL = imageUrl;
      });
    }
  }

  _updateUserProfile() async {
    final profileProvider =
        Provider.of<ProfileUpdateProvider>(context, listen: false);
    try {
      profileProvider.startProcessing();
      bool isSuccess = await profileProvider.updateProfile.updateProfile(
          fullName: _Name,
          newEmail: _email,
          companyName: _CompanyName,
          tagLine: _tagLine,
          profilePicture: null);

      if (isSuccess) {
        final UpdatedUser updatedUser = UpdatedUser();

        // Fetch updated user data after successful email generation

        User? fetchedUser = await updatedUser.fetchUpdatedUserData();
        // print('this is fetched user $fetchedUser');
        if (fetchedUser != null) {
          // Update the user in your UserProvider

          Provider.of<UserProvider>(context, listen: false)
              .updateUser(fetchedUser);
        }
        Fluttertoast.showToast(
          msg: "Profile Successfully Updated",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Error Updating Profile!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } finally {
      profileProvider.stopProcessing();
    }
  }

  _updatePassword() async {
    final passwordProvider =
        Provider.of<ProcessProvider>(context, listen: false);
    try {
      passwordProvider.startProcessing();
      bool isSuccess = await passwordProvider.updateProfile
          .updatePassword(newPassword: _newPassword);
      passwordProvider.stopProcessing();
      if (isSuccess) {
        Fluttertoast.showToast(
          msg: "Password Successfully Updated",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Password should be greater than 5!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } finally {
      passwordProvider.stopProcessing();
    }
  }

  Future<void> _uploadImage() async {
    print('yes got pressed');
    //api secret= N9Df7GeluzNr4kfzagqYeDw7Gkk
    // api key =741618948228439
    //duxr6edeo  cloud name
    //preset giy3fgh7
    final url = Uri.parse('https://api.cloudinary.com/v1_1/duxr6edeo/upload');

    // Pick a file using file_picker
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );

    if (result != null && result.files.isNotEmpty) {
      // Get file information
      final file = result.files.first;

      // Create the multipart request
      final request = http.MultipartRequest('POST', url);

      // Add fields to the request
      request.fields['upload_preset'] =
          'giy3fgh7'; // Replace with your actual upload preset name

      // Create a multipart file from bytes
      final multipartFile = http.MultipartFile.fromBytes(
        'file',
        file.bytes!,
        filename: file.name,
        contentType:
            MediaType('image', file.extension!), // Assuming it's an image file
      );

      // Add the file to the request
      request.files.add(multipartFile);

      // Send the request and handle the response
      try {
        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          print('File uploaded successfully');
          // Handle your response if needed

          Map<String, dynamic> jsonResponseMap = json.decode(response.body);
          // Accessing the URL field
          String imageUrl = jsonResponseMap['url'];
          setState(() {
            _imgURL = imageUrl;
          });

          print('Image URL: $imageUrl');
          final profileProvider =
              Provider.of<ProcessProvider>(context, listen: false);
          try {
            bool isSuccess = await profileProvider.updateProfile.updateProfile(
                fullName: null,
                newEmail: null,
                companyName: null,
                tagLine: null,
                profilePicture: imageUrl);

            if (isSuccess) {
              // saveImageUrl(imageUrl);
              final UpdatedUser updatedUser = UpdatedUser();

              // Fetch updated user data after successful email generation

              User? fetchedUser = await updatedUser.fetchUpdatedUserData();
              // print('this is fetched user $fetchedUser');
              if (fetchedUser != null) {
                // Update the user in your UserProvider

                Provider.of<UserProvider>(context, listen: false)
                    .updateUser(fetchedUser);
              }
              Fluttertoast.showToast(
                msg: 'Profile pic updated ',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
              );
            }
          } catch (e) {
            Fluttertoast.showToast(
              msg: 'error $e',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
          }
        } else {
          print('Failed to upload file. Status code: ${response.statusCode}');
          // Handle error
          Fluttertoast.showToast(
            msg: 'Error uploading picture ',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        }
      } catch (e) {
        print('Error uploading file: $e');
        // Handle error
      }
    } else {
      // User canceled file picking
      print('File picking canceled');
    }
  }

  Future<void> saveImageUrl(String imageUrl) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('profileImageUrl', imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;
    final imageUrlProvider = Provider.of<ImageUrlProvider>(context);

//'assets/images/avatar.jpg'
    Provider.of<ProcessProvider>(context, listen: false);
    print('user.name${user.name}');
    print('user.email${user.company}');
    print('user.email${user.profilePicture}');
    print('user.email${user.bio}');

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double Hpad = width * 0.01041;
    double Vpad = height * 0.00925;
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
              InkWell(
                onTap: () {
                  print('update profile picture');
                  _uploadImage();
                },
                child: CircleAvatar(
                  backgroundColor: Color(0xffFFFFFF),
                  radius: 55,
                  child: CircleAvatar(
                    backgroundImage: (_imgURL == null)
                        ? NetworkImage(bg)
                        : NetworkImage(
                            user.profilePicture), //'assets/images/avatar.jpg'
                    radius: 50,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text:
                          "${user.name.isEmpty ? 'David king' : user.name}, ${user.company.isEmpty ? 'Google Ltd.' : user.company}",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 28,
                          color: Color(0xff000000)),
                    ),
                    TextSpan(
                      text:
                          "${user.bio.isEmpty ? '\nSenior Product Development Manager' : '\n' + user.bio} ",
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
                          hintText:
                              '${user.company.isEmpty ? 'Company' : user.company}',
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
                    labelText: "Bio",
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
                            fontSize: 10.0,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight
                                .w200, // FontWeight.w200 represents the "extra-light" weight
                            fontStyle: FontStyle.italic,
                          ),
                          hintText:
                              '${user.bio.isEmpty ? 'enter bio' : user.bio}',
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
                        hintText: 'Enter New Password',
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
                  InkWell(
                    onTap: () async {
                      // change password here
                      print('change pwd here ');

                      _updatePassword();
                    },
                    child: Consumer<ProcessProvider>(
                      builder: (context, processProvider, child) {
                        return Container(
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
                              processProvider.isUpdating
                                  ? CircularProgressIndicator()
                                  : Image.asset(
                                      'assets/images/save_as.png',
                                      width: 20,
                                      height: 20,
                                    ),
                              SizedBox(
                                width: 8,
                              ),
                              Flexible(
                                child: Text(
                                  'Change Password',
                                  style: GoogleFonts.firaSans(
                                      fontSize: 14, color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        );
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
          padding: EdgeInsets.only(right: Hpad, left: Hpad, top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () async {
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
                  child: Consumer<ProfileUpdateProvider>(
                    builder: (context, profileUpdateProvider, child) {
                      return Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          profileUpdateProvider.isProcessing
                              ? CircularProgressIndicator()
                              : Image.asset(
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
                      );
                    },
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
