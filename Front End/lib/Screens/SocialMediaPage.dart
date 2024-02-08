import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/Provider/SocialMediaProvider.dart';
import 'package:my_app/Widgets/Buttons/SocialMediaButton.dart';
import 'package:my_app/Widgets/Buttons/downloadButtons.dart';
import 'package:my_app/Widgets/FormContainer.dart';
import 'package:my_app/Widgets/FormHeader.dart';
import 'package:my_app/Widgets/Inputs/CustomRoundedInput.dart';
import 'package:my_app/Widgets/Text/FormLabel.dart';
import 'package:my_app/services/TextFile.dart';
import 'package:my_app/services/pdfService.dart';
import 'package:provider/provider.dart';

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
  TextEditingController GeneratedText = TextEditingController();
  TextFileGeneration textFileGeneration = TextFileGeneration();
  String pdf_text = "";
  String result = "";
  String? timeframe;
  String? frequency;
  String? type;
  String? themes;
  bool facebook = false;
  String Platform = 'facebook';
  bool fb = false;
  bool insta = false;
  bool twitter = false;
  bool linkedin = false;
  List<bool> boolArray = [false, false, false, false];

  // Function to handle success scenario
  void _handleSuccess(String res) {
    print('Generated Text: $res');
    // Handle any UI updates or other logic on success
    setState(() {
      GeneratedText.text = res;
    });
    Provider.of<SocialMediaProvider>(context, listen: false).stopProcessing();
  }

  // Function to handle failure scenario
  void _handleFailure(String error) {
    print('Failed to generate content');
    // Handle any UI updates or other logic on failure
    Provider.of<SocialMediaProvider>(context, listen: false).stopProcessing();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final socialMediaProvider =
        Provider.of<SocialMediaProvider>(context, listen: false);
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
                            buttonColor:
                                (socialMediaProvider.buttonSelections[0])
                                    ? Color(0xFF4C5AFE)
                                    : Color(0xFF9296C3),
                            iconLink: 'assets/images/facebook.png',
                            buttonText: 'Facebook',
                            onPressed: () {
                              // Add your onPressed function for Facebook here
                              socialMediaProvider.setPlatform("Facebook");
                              socialMediaProvider.selectButton(0);
                              setState(() {
                                // Toggle the boolean variable
                                // facebook = !facebook;
                                // boolArray[0] = !boolArray[0];
                              });
                              print('fb$facebook');
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
                            buttonColor:
                                (socialMediaProvider.buttonSelections[1])
                                    ? Color(0xFF4C5AFE)
                                    : Color(0xFF9296C3),
                            iconLink: 'assets/images/insta.png',
                            buttonText: 'Instagram',
                            onPressed: () {
                              // Add your onPressed function for Instagram here
                              socialMediaProvider.setPlatform("Instagram");
                              socialMediaProvider.selectButton(1);
                              setState(() {
                                // insta = !insta;
                              });
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
                            buttonColor:
                                (socialMediaProvider.buttonSelections[2])
                                    ? Color(0xFF4C5AFE)
                                    : Color(0xFF9296C3),
                            iconLink: 'assets/images/twitter.png',
                            buttonText: 'X(Twitter)',
                            onPressed: () {
                              // Add your onPressed function for Twitter here
                              socialMediaProvider.setPlatform("Twitter");
                              socialMediaProvider.selectButton(2);
                              setState(() {
                                twitter = !twitter;
                              });
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
                            buttonColor:
                                (socialMediaProvider.buttonSelections[3])
                                    ? Color(0xFF4C5AFE)
                                    : Color(0xFF9296C3),
                            iconLink: 'assets/images/linkedin.png',
                            buttonText: 'LinkedIn',
                            onPressed: () {
                              // Add your onPressed function for Instagram here
                              socialMediaProvider.setPlatform("LinkedIn");
                              socialMediaProvider.selectButton(3);
                              setState(() {
                                linkedin = !linkedin;
                              });
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
                                          'January-march',
                                          'April-june',
                                          'july-sep',
                                          'oct-Dec',
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
                                          if (value != null) {
                                            setState(() {
                                              timeframe = value;
                                              print("ttttt${timeframe}");
                                            });
                                          }
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
                                          'daily',
                                          'weekly',
                                          'monthly',
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
                                          if (value != null) {
                                            setState(() {
                                              frequency = value;
                                              print("ttttt${frequency}");
                                            });
                                          }
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
                                          'blog articles',
                                          'videos',
                                          'infographics',
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
                                          if (value != null) {
                                            setState(() {
                                              type = value;
                                              print("ttttt${type}");
                                            });
                                          }
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
                                          'brand',
                                          'awareness',
                                          'lead generation',
                                          'sales',
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
                                          if (value != null) {
                                            setState(() {
                                              themes = value;
                                              print("ttttt${themes}");
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: InkWell(
                                onTap: () async {
                                  String selectedOne =
                                      socialMediaProvider.platform;
                                  try {
                                    socialMediaProvider.startProcessing();
                                    socialMediaProvider.service
                                        .generateSocialMediaText(
                                      selectedPlatform: selectedOne,
                                      contentIdeas: textController1.text,
                                      captionsText: textController2.text,
                                      responseGeneration: textController3.text,
                                      timeframe: timeframe,
                                      frequency: frequency,
                                      type: type,
                                      themes: themes,
                                      onSuccess: _handleSuccess,
                                      onFailure: _handleFailure,
                                    );
                                  } catch (e) {
                                    print('error $e');
                                  }
                                },
                                child: Consumer<SocialMediaProvider>(
                                  builder:
                                      (context, socialMediaProvider, child) {
                                    return Container(
                                      padding: EdgeInsets.all(5),
                                      width: width * 0.1125,
                                      height: height * 0.04722,
                                      decoration: BoxDecoration(
                                          color: Color(0xffFF8203),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20.0),
                                          )),
                                      child: socialMediaProvider.isProcessing
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CircularProgressIndicator()
                                              ],
                                            )
                                          : Row(children: [
                                              Image.asset(
                                                'assets/images/autorenew.png',
                                                color:
                                                    Colors.white, // Icon color
                                                width:
                                                    24, // Set the width as needed
                                                height:
                                                    24, // Set the height as needed
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Center(
                                                child: Text(
                                                  "Generate",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Fira Sans',
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ]),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            // color: Colors.cyan,
                            height: 300, // Set the height as needed
                            width: double.infinity, // Set the width as needed
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                height: 100,
                                width: double.infinity,
                                // color: Colors.blue,
                                child: TextField(
                                  controller: GeneratedText,
                                  enabled: true,
                                  maxLines: null,
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    fontFamily: 'Poppins',
                                    // fontStyle: FontStyle.italic,
                                    color: Color(0xff8598AD),
                                  ),
                                  decoration: InputDecoration(
                                    suffixIcon: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          // focusColor: Colors.amber,
                                          onPressed: () {
                                            Clipboard.setData(ClipboardData(
                                                text: GeneratedText.text));
                                            print("Text copied to clipboard");
                                            // setState(() {
                                            //   iconColor = Colors.blue;
                                            // });
                                            //  to reset the color after a short delay

                                            Fluttertoast.showToast(
                                              msg: 'Text copied',
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                            );
                                          },
                                          icon: Image.asset(
                                              'assets/images/copy.png'),
                                          // color: iconColor,
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

                                    border: InputBorder
                                        .none, // Remove the underline
                                  ),
                                ),
                              ),
                            ),
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
                                InkWell(
                                  onTap: () {
                                    print('i got clicked');
                                    pdf_text = GeneratedText.text;
                                    PdfService.saveAndLaunchFile(
                                        pdf_text, 'SocialMediaContent.pdf');
                                  },
                                  child: DownloadButtons(
                                    downloadIconName: 'pdf',
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                InkWell(
                                  onTap: () {
                                    pdf_text = GeneratedText.text;
                                    textFileGeneration
                                        .generateAndDownloadFile(pdf_text);
                                  },
                                  child: DownloadButtons(
                                    downloadIconName: 'word',
                                  ),
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
