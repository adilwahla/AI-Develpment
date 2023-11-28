import 'package:flutter/material.dart';
import 'package:my_app/Widgets/Buttons/SocialMediaButton.dart';
import 'package:my_app/Widgets/Buttons/downloadButtons.dart';
import 'package:my_app/Widgets/FormContainer.dart';
import 'package:my_app/Widgets/FormHeader.dart';
import 'package:my_app/Widgets/Inputs/CustomRoundedInput.dart';
import 'package:my_app/Widgets/Text/FormLabel.dart';

class SocialMediaPage extends StatelessWidget {
  const SocialMediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FormContainer(
      addFormElements: Column(
        children: [
          FormHeader(
            headerText: 'Social Media ',
          ),
          // EmailFormBody(),
          Expanded(
            child: SocialMediaFormBody(),
          ),
        ],
      ),
    );
  }
}

class SocialMediaFormBody extends StatefulWidget {
  const SocialMediaFormBody({super.key});

  @override
  State<SocialMediaFormBody> createState() => _SocialMediaFormBodyState();
}

class _SocialMediaFormBodyState extends State<SocialMediaFormBody> {
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController();
  // TextEditingController textController = TextEditingController();

  String? timeframe;
  String? frequency;
  String? type;
  String? themes;
  // String dropdownValue2 = list2.first;
  // String dropdownValue3 = list3.first;
  // String dropdownValue4 = list4.first;
  // String dropdownValue5 = list5.first;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            // color: Colors.blueGrey,
            // height: double.infinity,
            width: width * 0.28, // Set the width as needed
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Set to center
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: height * 0.08,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20),
                      child: FormLabelText(
                        labelText: "Select Platform",
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 50,
                  // ),
                  Container(
                    height: height * 0.08,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30, left: 20),
                      child: FormLabelText(
                        labelText: "Content",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.08,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: FormLabelText(
                      labelText: "Content Calendar",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Container(
            width: 1.0, // Adjust the width of the divider as needed
            color: Color(0xffE2E4FB),
            height: height * 0.76, // Set the height of the divider
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            // color: Colors.lightGreen,
            height: double.infinity, // Set the height as needed
            width: 300, // Set the width as needed
            child: Column(
              children: [
                Container(
                  // color: Colors.purpleAccent,
                  height: 95, // Set the height as needed
                  width: double.infinity, // Set the width as needed
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Spacer(), // Add space
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomRoundedIconButton(
                            iconLink: 'assets/images/facebook.png',
                            buttonText: 'Facebook',
                            onPressed: () {
                              // Add your onPressed function for Facebook here
                            },
                          ),
                        ],
                      ),
                      // Spacer(), // Add space
                      SizedBox(
                        width: 5,
                      ),

                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomRoundedIconButton(
                            iconLink: 'assets/images/insta.png',
                            buttonText: 'Instagram',
                            onPressed: () {
                              // Add your onPressed function for Instagram here
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomRoundedIconButton(
                            iconLink: 'assets/images/twitter.png',
                            buttonText: 'X(Twitter)',
                            onPressed: () {
                              // Add your onPressed function for Twitter here
                            },
                          ),
                        ],
                      ),
                      // Spacer(), // Add space

                      // Spacer(), // Add space
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomRoundedIconButton(
                            iconLink: 'assets/images/linkedin.png',
                            buttonText: 'LinkedIn',
                            onPressed: () {
                              // Add your onPressed function for Instagram here
                            },
                          ),
                        ],
                      ),
                      // Spacer(), // Add space
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 1.0,
                    color: Color(0xffE2E4FB),
                    width: double.infinity,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    // color: Colors.yellowAccent,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity, // Set the width as needed

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          // Align widgets at the center horizontally
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Spacer(),
                            FormLabelText(
                              labelText: "Content Ideas",
                              // fontSize: 14,
                            ),

                            CustomTextInput(
                              hintText: 'king',
                              controller: textController1,
                            ),
                          ],
                        ),
                        // SizedBox(
                        //     height: 5.0), // Add vertical space between rows
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // SizedBox(width: 8.0),
                            FormLabelText(
                              labelText: "Captions and Text",
                              // fontSize: 12,
                            ),
                            CustomTextInput(
                              hintText: 'king',
                              controller: textController2,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FormLabelText(
                              labelText: "Response Generation",
                              // fontSize: 14,
                            ),
                            CustomTextInput(
                              hintText: 'king',
                              controller: textController3,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 1.0,
                    color: Color(0xffE2E4FB),
                    width: double.infinity,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    // color: Colors.cyan,
                    height: 300, // Set the height as needed
                    width: double.infinity, // Set the width as needed
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // color:
                          //     Colors.blue, // Color for the container at the top
                          height: 100, // Set the height as needed
                          width: double.infinity, // Set the width as needed
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FormLabelText(
                                      labelText: "Timeframe",
                                    ),
                                    Container(
                                      width: width * 0.14,
                                      height: height * 0.047,
                                      decoration: BoxDecoration(
                                        color: Color(0xffFFFFFF),
                                        border: Border.all(
                                          color: Color(
                                              0xffE2E4FB), // Set your desired border color
                                          width:
                                              1, // Customize the border width
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: DropdownButton<String>(
                                        underline: Container(),
                                        isExpanded: true,
                                        dropdownColor: Colors.white,
                                        value: timeframe,
                                        style: TextStyle(
                                          color: Color(0xff8598AD),
                                          fontSize: 12.0,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight
                                              .w200, // FontWeight.w200 represents the "extra-light" weight
                                          fontStyle: FontStyle.italic,
                                        ),
                                        items: <String>[
                                          'English',
                                          'German',
                                          'French',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0),
                                              child: Text(value),
                                            ),
                                          );
                                        }).toList(),
                                        hint: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Text(
                                            "Select Time",
                                            style: TextStyle(
                                              color: Color(0xff8598AD),
                                              fontSize: 12.0,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight
                                                  .w200, // FontWeight.w200 represents the "extra-light" weight
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ),
                                        onChanged: (String? value) {
                                          setState(() {
                                            timeframe = value;
                                            print("ttttt${timeframe}");
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                // SizedBox(width: 25),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FormLabelText(
                                      labelText: "Frequency",
                                    ),
                                    Container(
                                      width: width * 0.15,
                                      height: height * 0.047,
                                      decoration: BoxDecoration(
                                        color: Color(0xffFFFFFF),
                                        border: Border.all(
                                          color: Color(
                                              0xffE2E4FB), // Set your desired border color
                                          width:
                                              1, // Customize the border width
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: DropdownButton<String>(
                                        underline: Container(),
                                        isExpanded: true,
                                        dropdownColor: Colors.white,
                                        value: frequency,
                                        style: TextStyle(
                                          color: Color(0xff8598AD),
                                          fontSize: 12.0,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight
                                              .w200, // FontWeight.w200 represents the "extra-light" weight
                                          fontStyle: FontStyle.italic,
                                        ),
                                        items: <String>[
                                          'English',
                                          'German',
                                          'French',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0),
                                              child: Text(value),
                                            ),
                                          );
                                        }).toList(),
                                        hint: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Text(
                                            "Select Frequency",
                                            style: TextStyle(
                                              color: Color(0xff8598AD),
                                              fontSize: 12.0,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight
                                                  .w200, // FontWeight.w200 represents the "extra-light" weight
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ),
                                        onChanged: (String? value) {
                                          setState(() {
                                            frequency = value;
                                            print("ttttt${frequency}");
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                // SizedBox(width: 25),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FormLabelText(
                                      labelText: "Type",
                                    ),
                                    Container(
                                      width: width * 0.14,
                                      height: height * 0.047,
                                      decoration: BoxDecoration(
                                        color: Color(0xffFFFFFF),
                                        border: Border.all(
                                          color: Color(
                                              0xffE2E4FB), // Set your desired border color
                                          width:
                                              1, // Customize the border width
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: DropdownButton<String>(
                                        underline: Container(),
                                        isExpanded: true,
                                        dropdownColor: Colors.white,
                                        value: type,
                                        style: TextStyle(
                                          color: Color(0xff8598AD),
                                          fontSize: 12.0,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight
                                              .w200, // FontWeight.w200 represents the "extra-light" weight
                                          fontStyle: FontStyle.italic,
                                        ),
                                        items: <String>[
                                          'English',
                                          'German',
                                          'French',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0),
                                              child: Text(value),
                                            ),
                                          );
                                        }).toList(),
                                        hint: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Text(
                                            "Select Type",
                                            style: TextStyle(
                                              color: Color(0xff8598AD),
                                              fontSize: 12.0,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight
                                                  .w200, // FontWeight.w200 represents the "extra-light" weight
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ),
                                        onChanged: (String? value) {
                                          setState(() {
                                            type = value;
                                            print("ttttt${type}");
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                // SizedBox(width: 25),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FormLabelText(
                                      labelText: "Themes",
                                    ),
                                    Container(
                                      width: width * 0.14,
                                      height: height * 0.047,
                                      decoration: BoxDecoration(
                                        color: Color(0xffFFFFFF),
                                        border: Border.all(
                                          color: Color(
                                              0xffE2E4FB), // Set your desired border color
                                          width:
                                              1, // Customize the border width
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: DropdownButton<String>(
                                        underline: Container(),
                                        isExpanded: true,
                                        dropdownColor: Colors.white,
                                        value: themes,
                                        style: TextStyle(
                                          color: Color(0xff8598AD),
                                          fontSize: 12.0,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight
                                              .w200, // FontWeight.w200 represents the "extra-light" weight
                                          fontStyle: FontStyle.italic,
                                        ),
                                        items: <String>[
                                          'English',
                                          'German',
                                          'French',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0),
                                              child: Text(value),
                                            ),
                                          );
                                        }).toList(),
                                        hint: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Text(
                                            "Select Themes",
                                            style: TextStyle(
                                              color: Color(0xff8598AD),
                                              fontSize: 12.0,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight
                                                  .w200, // FontWeight.w200 represents the "extra-light" weight
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ),
                                        onChanged: (String? value) {
                                          setState(() {
                                            themes = value;
                                            print("ttttt${themes}");
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            // color: Colors.cyan,
                            height: 300, // Set the height as needed
                            width: double.infinity, // Set the width as needed
                          ),
                        ),
                        Container(
                          // color: Colors
                          //     .green, // Color for the container at the bottom
                          height: 50, // Set the height as needed
                          width: double.infinity, // Set the width as needed

                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Spacer(
                                  flex: 2,
                                ),
                                DownloadButtons(
                                  downloadIconName: 'pdf',
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                DownloadButtons(
                                  downloadIconName: 'word',
                                ),
                                Spacer(
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
