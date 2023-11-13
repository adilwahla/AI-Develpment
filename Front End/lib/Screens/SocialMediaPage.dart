import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_app/Widgets/Buttons/CustomDropdownButton.dart';
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

  static const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  static const List<String> list2 = <String>['One', 'Two', 'Three', 'Four'];
  static const List<String> list3 = <String>['One', 'Two', 'Three', 'Four'];
  static const List<String> list4 = <String>['One', 'Two', 'Three', 'Four'];
  static const List<String> list5 = <String>['One', 'Two', 'Three', 'Four'];

  String dropdownValue = list.first;
  String dropdownValue2 = list2.first;
  String dropdownValue3 = list3.first;
  String dropdownValue4 = list4.first;
  String dropdownValue5 = list5.first;
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
            height: double.infinity,
            width: 300, // Set the width as needed
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Set to center
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FormLabelText(
                    labelText: "Select Platform",
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  FormLabelText(
                    labelText: "Content",
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  FormLabelText(
                    labelText: "Content Calendar",
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: 2.0, // Adjust the width of the divider as needed
          color: Color(0xffE2E4FB),
          height: height * 2 / 3, // Set the height of the divider
        ),
        Expanded(
          flex: 4,
          child: Container(
            // color: Colors.lightGreen,
            height: double.infinity, // Set the height as needed
            width: 300, // Set the width as needed
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    // color: Colors.purpleAccent,
                    height: 300, // Set the height as needed
                    width: double.infinity, // Set the width as needed
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Spacer(), // Add space
                        CustomRoundedIconButton(
                          iconData: FontAwesomeIcons.facebook,
                          buttonText: 'Facebook',
                          onPressed: () {
                            // Add your onPressed function for Facebook here
                          },
                        ),
                        Spacer(), // Add space
                        CustomRoundedIconButton(
                          iconData: FontAwesomeIcons.twitter,
                          buttonText: 'XTwitter',
                          onPressed: () {
                            // Add your onPressed function for Twitter here
                          },
                        ),
                        Spacer(), // Add space
                        CustomRoundedIconButton(
                          iconData: FontAwesomeIcons.instagram,
                          buttonText: 'Instagram',
                          onPressed: () {
                            // Add your onPressed function for Instagram here
                          },
                        ),
                        Spacer(), // Add space
                        CustomRoundedIconButton(
                          iconData: FontAwesomeIcons.linkedin,
                          buttonText: 'LinkedIn',
                          onPressed: () {
                            // Add your onPressed function for Instagram here
                          },
                        ),
                        Spacer(), // Add space
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 2.0,
                  color: Color(0xffE2E4FB),
                  width: double.infinity,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    // color: Colors.yellowAccent,
                    width: double.infinity, // Set the width as needed

                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Align widgets at the center horizontally
                          children: [
                            Spacer(),
                            FormLabelText(
                              labelText: "Content Ideas",
                              fontSize: 14,
                            ),
                            Spacer(),
                            FormLabelText(
                              labelText: "Captions and Text",
                              fontSize: 14,
                            ),
                            Spacer(),
                            FormLabelText(
                              labelText: "Response Generation",
                              fontSize: 14,
                            ),
                            Spacer(),
                          ],
                        ),
                        SizedBox(
                            height: 16.0), // Add vertical space between rows
                        Row(
                          children: [
                            SizedBox(width: 8.0),
                            CustomTextInput(
                              hintText: 'king',
                              controller: textController1,
                            ),
                            SizedBox(
                                width:
                                    8.0), // Add horizontal space between text input widgets
                            CustomTextInput(
                              hintText: 'king',
                              controller: textController2,
                            ),
                            SizedBox(
                                width:
                                    8.0), // Add horizontal space between text input widgets
                            CustomTextInput(
                              hintText: 'king',
                              controller: textController3,
                            ),
                            SizedBox(width: 8.0),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 2.0,
                  color: Color(0xffE2E4FB),
                  width: double.infinity,
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    // color: Colors.cyan,
                    height: 300, // Set the height as needed
                    width: double.infinity, // Set the width as needed
                    child: Column(
                      children: [
                        Container(
                          // color:
                          //     Colors.blue, // Color for the container at the top
                          height: 100, // Set the height as needed
                          width: double.infinity, // Set the width as needed
                          child: Row(
                            //  crossAxisAlignment: CrossAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FormLabelText(
                                    labelText: "Timeframe",
                                  ),
                                  CustomDropdownButton(
                                      width: width * 1 / 8,
                                      itemList: list2,
                                      onChanged: (String? value) {
                                        setState(() {
                                          dropdownValue2 = value!;
                                        });
                                      },
                                      dropdownValue: dropdownValue2),
                                ],
                              ),
                              SizedBox(width: 25),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FormLabelText(
                                    labelText: "Frequency",
                                  ),
                                  CustomDropdownButton(
                                      width: width * 1 / 8,
                                      itemList: list3,
                                      onChanged: (String? value) {
                                        setState(() {
                                          dropdownValue3 = value!;
                                        });
                                      },
                                      dropdownValue: dropdownValue3),
                                ],
                              ),
                              SizedBox(width: 25),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FormLabelText(
                                    labelText: "Type",
                                  ),
                                  CustomDropdownButton(
                                      width: width * 1 / 8,
                                      itemList: list4,
                                      onChanged: (String? value) {
                                        setState(() {
                                          dropdownValue4 = value!;
                                        });
                                      },
                                      dropdownValue: dropdownValue4),
                                ],
                              ),
                              SizedBox(width: 25),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FormLabelText(
                                    labelText: "Themes",
                                  ),
                                  CustomDropdownButton(
                                      width: width * 1 / 8,
                                      itemList: list5,
                                      onChanged: (String? value) {
                                        setState(() {
                                          dropdownValue5 = value!;
                                        });
                                      },
                                      dropdownValue: dropdownValue5),
                                ],
                              ),
                            ],
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

                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Spacer(
                                flex: 2,
                              ),
                              DownloadButtons(
                                DownloadIconName: 'pdf',
                              ),
                              SizedBox(
                                width: 60,
                              ),
                              DownloadButtons(
                                DownloadIconName: 'word',
                              ),
                              Spacer(
                                flex: 1,
                              ),
                            ],
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
