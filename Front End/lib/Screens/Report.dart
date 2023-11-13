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
            headerText: 'Report & Summary',
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormLabelText(
              labelText: "Generate Report",
              fontSize: 12,
            ),
            FormButton(
              buttonText: "   Paste Document",
              buttonColor: Color(0xff4C5AFE),
              buttonIconName: 'paste.png',
              buttonHeight: 30,
              buttonWidth: width * 1 / 3,
              // iconHeight: 27,
              // iconWidth: 22,
            ),

            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormLabelText(
                      labelText: "Length",
                      fontSize: 12,
                    ),
                    // DropdownWithArrow(),
                    CustomDropdownButton(
                        width: width * 1 / 6,
                        itemList: length,
                        onChanged: (String? value) {
                          setState(() {
                            dropdownLength = value!;
                          });
                        },
                        dropdownValue: dropdownLength),
                  ],
                ),
                //second column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormLabelText(
                      labelText: "Language",
                      fontSize: 12,
                    ),
                    // DropdownWithArrow(),
                    CustomDropdownButton(
                        width: width * 1 / 6,
                        itemList: language,
                        onChanged: (String? value) {
                          setState(() {
                            dropdownLanguage = value!;
                          });
                        },
                        dropdownValue: dropdownLanguage),
                  ],
                ),
              ],
            ),
            // FormLabelText(
            //   labelText: "Type here",
            //   fontSize: 12,
            // ),
            // MlutiLineTextArea(
            //   width: width * 1 / 3,
            //   iconName: 'Clipboard.png',
            // ),
            SizedBox(
              height: height / 3,
            ),
            Container(
              width: width * 1 / 3,
              height: 20,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                color: Color(0xffE2E4FB),
                thickness: 2.0, // Adjust the thickness as needed
                height: 8.0,
              ),
            ),
            FormButton(
              buttonText: "   Generate",
              buttonColor: Color(0xffFF8203),
              buttonIconName: 'autorenew.png',
              buttonHeight: 30,
              buttonWidth: width * 1 / 3,
              // iconHeight: 27,
              // iconWidth: 22,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 3,
            height: MediaQuery.of(context).size.height * 1 / 2,
            color: Color(0xffE2E4FB),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormLabelText(
              labelText: "Generated Report",
              fontSize: 12,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 3,
              height: 30,
              decoration: BoxDecoration(
                  color: Color(0xff39D1B8),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/published_with_changes.png',
                    color: Colors.white, // Icon color
                    width: 24, // Set the width as needed
                    height: 24, // Set the height as needed
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
            MlutiLineTextArea(
              iconName: 'copy.png',
              width: MediaQuery.of(context).size.width / 3,
              lines: 10,
            ),
            Container(
              width: width * 1 / 3,
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Divider(
                color: Color(0xffE2E4FB),
                thickness: 2.0, // Adjust the thickness as needed
                height: 8.0,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DownloadButtons(
                  DownloadIconName: 'pdf',
                ),
                SizedBox(
                  width: 60,
                ),
                DownloadButtons(
                  DownloadIconName: 'word',
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
