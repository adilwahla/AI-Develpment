import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Utils.dart';

import 'package:my_app/Widgets/Buttons/FormButton.dart';
import 'package:my_app/Widgets/Buttons/downloadButtons.dart';
import 'package:my_app/Widgets/FormContainer.dart';
import 'package:my_app/Widgets/FormHeader.dart';
import 'package:my_app/Widgets/Text/FormLabel.dart';
import 'package:my_app/services/auth_services.dart';

class TranslatePage extends StatelessWidget {
  const TranslatePage({super.key});

  @override
  Widget build(BuildContext context) {
    //colors
    //4C5AFE  //FFFFFF
    // button border colors E2E4FB
    //8B8FB5  //FF8203

    return FormContainer(
      addFormElements: Column(
        children: [
          FormHeader(
            headerText: 'Translate',
          ),
          // EmailFormBody(),
          TranslateFormBody()
        ],
      ),
    );
  }
}

class TranslateFormBody extends StatefulWidget {
  const TranslateFormBody({super.key});

  @override
  State<TranslateFormBody> createState() => _TranslateFormBodyState();
}

class _TranslateFormBodyState extends State<TranslateFormBody> {
  final AuthService authService = AuthService();
  TextEditingController textarea = TextEditingController();
  String? object;
  // String? selectLanguage;
  TextEditingController selectLanguage = TextEditingController();
  void translate1() {
    authService.translate(
      context: context,
      input: textarea.text,
      language: object.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
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
                  labelText: "Paste Document",
                  fontSize: 12,
                ),
              ),
              FormButton(
                buttonText: "   Paste Document",
                buttonColor: Color(0xff4C5AFE),
                buttonIconName: 'paste.png',
                buttonHeight: height * 0.047,
                buttonWidth: width * 0.366,
                // iconHeight: 27,
                // iconWidth: 22,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 7),
                child: FormLabelText(
                  labelText: "Language",
                  fontSize: 12,
                ),
              ),

              Container(
                // width: width * 0.18,
                width: width * 0.366,
                height: height * 0.047,
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  controller: selectLanguage,
                  style: TextStyle(
                    color: Colors.black,
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
                      hintText: 'Enter Language',
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
                  onChanged: (value) {
                    // do something
                  },
                ),
              ),
              // Container(
              //   width: width * 0.366,
              //   height: height * 0.047,
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //     child: TextField(
              //       controller: selectLanguage,
              //       style: kEmailInputStyle,
              //       decoration: kEmailInputDecoration.copyWith(
              //           hintText: "Enter Language"),
              //       onChanged: (value) {
              //         // do something
              //       },
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 7),
                child: FormLabelText(
                  labelText: "Type here",
                  fontSize: 12,
                ),
              ),
              // MlutiLineTextArea(

              //   width: width * 1 / 3,
              //   iconName: 'Clipboard.png',
              // ),
              Container(
                // alignment: Alignment.center,
                decoration: BoxDecoration(
                  // color: Color(0xffE2E4FB),
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0xffE2E4FB), // Set the border color to E2E4FB
                    width: 1, // Customize the border width
                  ),
                ),
                width: width * 0.366,
                height: height * 0.39,
                child: Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Color(0xffE2E4FB),
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      border: Border.all(
                        color:
                            Color(0xffE2E4FB), // Set the border color to E2E4FB
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
                          color: Colors.black,
                          fontSize: 16.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight
                              .w200, // FontWeight.w200 represents the "extra-light" weight
                          fontStyle: FontStyle.italic,
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
                                icon:
                                    Image.asset('assets/images/Clipboard.png'),
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
              FormButton(
                buttonText: "   Translate",
                buttonColor: Color(0xffFF8203),
                buttonIconName: 'translate.png',
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
            direction: Axis.vertical, // or Axis.horizontal based on your layout
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: FormLabelText(
                  labelText: "Translated Document",
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
                    // Image.asset(
                    //   'assets/images/published_with_changes.png',
                    //   color: Colors.white, // Icon color
                    //   width: 24, // Set the width as needed
                    //   height: 24, // Set the height as needed
                    // ),
                    Text(
                      "Waiting",
                      style: GoogleFonts.firaSans(
                          color: Colors.white,
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
                    color: Color(0xffE2E4FB), // Set the border color to E2E4FB
                    width: 1, // Customize the border width
                  ),
                ),
                width: width * 0.366,
                height: height * 0.52,
                child: Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Color(0xffE2E4FB),
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      border: Border.all(
                        color:
                            Color(0xffE2E4FB), // Set the border color to E2E4FB
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
                    downloadIconName: 'pdf',
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  DownloadButtons(
                    downloadIconName: 'word',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
