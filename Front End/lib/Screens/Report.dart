import 'package:flutter/material.dart';
import 'package:my_app/Widgets/Buttons/CustomDropdownButton.dart';
import 'package:my_app/Widgets/Buttons/DropDownButton.dart';
import 'package:my_app/Widgets/Buttons/FormButton.dart';
import 'package:my_app/Widgets/Buttons/downloadButtons.dart';
import 'package:my_app/Widgets/FormContainer.dart';
import 'package:my_app/Widgets/FormHeader.dart';
import 'package:my_app/Widgets/Text/FormLabel.dart';
import 'package:my_app/Widgets/Text/TextArea.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FormContainer(
      addFormElements: Column(
        children: [
          FormHeader(
            headerText: 'Report and Summary',
          ),
          // EmailFormBody(),
          ReportFormBody(),
        ],
      ),
    );
  }
}

class ReportFormBody extends StatefulWidget {
  const ReportFormBody({super.key});

  @override
  State<ReportFormBody> createState() => _ReportFormBodyState();
}

class _ReportFormBodyState extends State<ReportFormBody> {
  static const List<String> length = <String>['One', 'Two', 'Three', 'Four'];
  static const List<String> language = <String>['One', 'Two', 'Three', 'Four'];
  String dropdownLength = length.first;
  String dropdownLanguage = language.first;

  TextEditingController textarea = TextEditingController();
  String? object;
  String? selectLanguage;
  String? selectLength;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 7),
                    child: FormLabelText(
                      labelText: "Generate Report",
                      fontSize: 12,
                    ),
                  ),
                  FormButton(
                    buttonText: "   Generate Report",
                    buttonColor: Color(0xff4C5AFE),
                    buttonIconName: 'paste.png',
                    buttonHeight: height * 0.047,
                    buttonWidth: width * 0.366,
                    // iconHeight: 27,
                    // iconWidth: 22,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormLabelText(
                              labelText: "Length",
                              fontSize: 12,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              width: width * 0.178,
                              height: height * 0.047,
                              decoration: BoxDecoration(
                                color: Color(0xffFFFFFF),
                                border: Border.all(
                                  color: Color(
                                      0xffE2E4FB), // Set your desired border color
                                  width: 1, // Customize the border width
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: DropdownButton<String>(
                                  underline: Container(),
                                  isExpanded: true,
                                  dropdownColor: Colors.white,
                                  value: selectLanguage,
                                  style: TextStyle(
                                    color: Color(0xff8598AD),
                                    fontSize: 12.0,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight
                                        .w200, // FontWeight.w200 represents the "extra-light" weight
                                    fontStyle: FontStyle.italic,
                                  ),
                                  items: <String>[
                                    'Short',
                                    'Medium',
                                    'Long',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16.0),
                                        child: Text(value),
                                      ),
                                    );
                                  }).toList(),
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Text(
                                      "Select Length",
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
                                      selectLanguage = value;
                                      print("ttttt${selectLanguage}");
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormLabelText(
                              labelText: "Language",
                              fontSize: 12,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              width: width * 0.178,
                              height: height * 0.047,
                              decoration: BoxDecoration(
                                color: Color(0xffFFFFFF),
                                border: Border.all(
                                  color: Color(
                                      0xffE2E4FB), // Set your desired border color
                                  width: 1, // Customize the border width
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: DropdownButton<String>(
                                  underline: Container(),
                                  isExpanded: true,
                                  dropdownColor: Colors.white,
                                  value: selectLength,
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
                                        padding:
                                            const EdgeInsets.only(left: 16.0),
                                        child: Text(value),
                                      ),
                                    );
                                  }).toList(),
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Text(
                                      "Select Language",
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
                                      selectLength = value;
                                      print("ttttt${selectLength}");
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: width * 0.366,
                    height: height * 0.39,
                  ),
                  Container(
                    width: width * 0.366,
                    height: 2,
                    // padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Divider(
                      color: Color(0xffE2E4FB),
                      thickness: 2.0, // Adjust the thickness as needed
                      // height: 8.0,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FormButton(
                    buttonText: "   Generate",
                    buttonColor: Color(0xffFF8203),
                    buttonIconName: 'autorenew.png',
                    buttonHeight: height * 0.047,
                    buttonWidth: width * 0.366,
                    // iconHeight: 27,
                    // iconWidth: 22,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  width: 2,
                  height: MediaQuery.of(context).size.height * 0.74,
                  color: Color(0xffE2E4FB),
                ),
              ),
              Flex(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                direction: Axis.vertical,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 7),
                    child: FormLabelText(
                      labelText: "Generated Report",
                      fontSize: 12,
                    ),
                  ),
                  Container(
                    width: width * 0.366,
                    height: height * 0.047,
                    decoration: BoxDecoration(
                        color: Color(0xff39D1B8),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/published_with_changes.png',
                          color: Colors.white, // Icon color
                          width: 15, // Set the width as needed
                          height: 15, // Set the height as needed
                        ),
                        Text(
                          "  Ready",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Fira Sans',
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // alignment: Alignment.center,
                    decoration: BoxDecoration(
                      // color: Color(0xffE2E4FB),
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color:
                            Color(0xffE2E4FB), // Set the border color to E2E4FB
                        width: 1, // Customize the border width
                      ),
                    ),
                    width: width * 0.366,
                    height: height * 0.52,
                    child: Container(
                      decoration: BoxDecoration(
                        // color: Color(0xffE2E4FB),
                        color: Color(0xffFFFFFF),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        border: Border.all(
                          color: Color(
                              0xffE2E4FB), // Set the border color to E2E4FB
                          width: 1, // Customize the border width
                        ),
                      ),
                      child: new ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: double.infinity,
                        ),
                        child: TextField(
                          enabled: true,
                          maxLines: null,
                          style: TextStyle(
                            fontSize: 10.0,
                            fontFamily: 'Poppins',
                            // fontStyle: FontStyle.italic,
                            color: Color(0xff8598AD),
                          ),
                          decoration: InputDecoration(
                            suffixIcon: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    print("copy text");
                                  },
                                  icon: Image.asset('assets/images/copy.png'),
                                ),
                              ],
                            ),
                            labelStyle: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Poppins',
                              // fontStyle: FontStyle.italic,
                              color: Color(0xff8598AD),
                            ),
                            contentPadding: EdgeInsets.all(16),

                            border: InputBorder.none, // Remove the underline
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: width * 0.366,
                    height: 2,
                    // padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Divider(
                      color: Color(0xffE2E4FB),
                      thickness: 2.0, // Adjust the thickness as needed
                      // height: 8.0,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DownloadButtons(
                        DownloadIconName: 'pdf',
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      DownloadButtons(
                        DownloadIconName: 'word',
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
