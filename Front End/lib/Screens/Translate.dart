import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Provider/TranslationProvider.dart';
import 'package:my_app/Provider/user_provider.dart';

import 'package:my_app/Widgets/Buttons/FormButton.dart';
import 'package:my_app/Widgets/Buttons/downloadButtons.dart';
import 'package:my_app/Widgets/FormContainer.dart';
import 'package:my_app/Widgets/FormHeader.dart';
import 'package:my_app/Widgets/Text/FormLabel.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/services/TextFile.dart';

import 'package:my_app/services/pdfService.dart';
import 'package:my_app/services/updatedUser.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class TranslatePage extends StatelessWidget {
  const TranslatePage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<TranslationProvider>(context, listen: false);
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
  // final AuthService authService = AuthService();
  //final TranslationProvider translationProvider = TranslationProvider();
  PdfService pdfService = PdfService();
  TextFileGeneration textFileGeneration = TextFileGeneration();
  TextEditingController textarea = TextEditingController();
  String? language;
  // String? selectLanguage;
  String inputText = '';
  late String Text_pdf;
  late String Text_content;

  TextEditingController _documentTextController = TextEditingController();
  TextEditingController _typedTextController = TextEditingController();
  TextEditingController _translatedTextController = TextEditingController();
  TextEditingController _selectLanguageController = TextEditingController();

  bool isTranslationSuccessful = false;
  void _initiateTranslation() {
    setState(() {
      _documentTextController.text = inputText;
    });

    Provider.of<TranslationProvider>(context, listen: false).startProcessing();
    Provider.of<TranslationProvider>(context, listen: false)
        .translationService
        .translate(
          documentText: inputText,
          input: _typedTextController.text,
          language: _selectLanguageController.text,
          onTranslation: _handleTranslationSuccess,
          onError: _handleTranslationError,
        );
  }

  void _handleTranslationSuccess(String result) async {
    // Handle success, e.g.,
    // Update the state with the translated text
    setState(() {
      isTranslationSuccessful = true;
      _translatedTextController.text = result;
    });
    final UpdatedUser updatedUser = UpdatedUser();

    // Fetch updated user data after successful email generation

    User? fetchedUser = await updatedUser.fetchUpdatedUserData();
    // print('this is fetched user $fetchedUser');
    if (fetchedUser != null) {
      // Update the user in your UserProvider

      Provider.of<UserProvider>(context, listen: false).updateUser(fetchedUser);
    }
    Provider.of<TranslationProvider>(context, listen: false).stopProcessing();
  }

  void _handleTranslationError(String error) {
    setState(() {
      isTranslationSuccessful = false;
    });
    Provider.of<TranslationProvider>(context, listen: false).stopProcessing();
    // Handle error, e.g., show a snackbar with the error message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Translation error: $error'),
    ));
  }

  Future<String> _readFile(PlatformFile file) async {
    try {
      Uint8List bytes = file.bytes!; // Use bytes property on the web
      print('Bytes: $bytes');
      String content = utf8.decode(bytes);
      // print("i am called =$content");
      return content;
    } catch (e) {
      print('Error reading file: $e');
      return '';
    }
  }

  void _pasteTextFromClipboard() async {
    ClipboardData? clipboardData =
        await Clipboard.getData(Clipboard.kTextPlain);
    if (clipboardData != null) {
      setState(() {
        _typedTextController.text = clipboardData.text ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // final TranslationProvider translationProvider = TranslationProvider();
    // ignore: unused_local_variable
    final translationProvider =
        Provider.of<TranslationProvider>(context, listen: false);
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
              InkWell(
                onTap: () async {
                  FilePickerResult? result = await FilePicker.platform
                      .pickFiles(type: FileType.any, allowMultiple: false);

                  if (result != null && result.files.isNotEmpty) {
                    // Extract text from the selected file
                    PlatformFile file = result.files.first;
                    // Access file information
                    List<int>? fileBytes = result.files.first.bytes;
                    // Log the file info

                    print('file name=${file.name}');
                    print('file size=${file.size}');
                    print('file extension=${file.extension}');
                    // print('file path=${file.path}');
                    if (file.extension == 'pdf') {
                      final PdfDocument document =
                          PdfDocument(inputBytes: fileBytes);

                      //Create PDF text extractor to extract text
                      PdfTextExtractor extractor = PdfTextExtractor(document);

                      // ${String.fromCharCodes(fileBytes!)}
                      inputText = extractor.extractText();
                      print('here goes pdf @text ${inputText} ');
                      Fluttertoast.showToast(
                        msg: 'File Selected',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                      );
                      //Dispose the document
                      document.dispose();
                    } else if (file.extension == 'docx') {
                      Future<String> docxText = _readFile(file);
                      String text = await docxText;
                      print("this is word file text: $text");
                    } else if (file.extension == 'txt') {
                      Uint8List uint8List = result.files.first.bytes!;
                      // Convert bytes to string
                      inputText = utf8.decode(uint8List);
                      // print('this is Text file: $inputText');
                      Fluttertoast.showToast(
                        msg: 'File Selected',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                      );
                    } else {
                      print("unsupported file format ${file.extension}");
                      Fluttertoast.showToast(
                        msg: 'File Not Selected',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                      );
                    }
                  }
                },
                child: FormButton(
                  buttonText: "   Paste Document",
                  buttonColor: Color(0xff4C5AFE),
                  buttonIconName: 'paste.png',
                  buttonHeight: height * 0.047,
                  buttonWidth: width * 0.366,
                  // iconHeight: 27,
                  // iconWidth: 22,
                ),
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
                  controller: _selectLanguageController,
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
                  // onChanged: (value) {
                  //   // do something
                  //   setState(() {
                  //     language = value;
                  //   });
                  // },
                ),
              ),

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
              Column(
                children: [
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
                    height: height * 0.39,
                    child: Container(
                      decoration: BoxDecoration(
                        // color: Color(0xffE2E4FB),
                        color: Color(0xffFFFFFF),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
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
                          controller: _typedTextController,
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
                                    _pasteTextFromClipboard();
                                  },
                                  icon: Image.asset(
                                      'assets/images/Clipboard.png'),
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
                ],
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
              InkWell(
                onTap: () {
                  _translatedTextController.clear();
                  _initiateTranslation();
                  print('tranlste button got pressed');
                },
                child: Consumer<TranslationProvider>(
                  builder: (context, translationProvider, child) {
                    return translationProvider.isProcessing
                        // ? CircularProgressIndicator()
                        ? new LinearPercentIndicator(
                            width: width * 0.366,
                            animation: true,
                            lineHeight: height * 0.047,
                            animationDuration: 7000,
                            percent: 0.95,
                            center: Text("Generating..."),
                            barRadius: Radius.circular(20.0),
                            progressColor: Color(0xff39D1B8),
                          )
                        : Container(
                            width: width * 0.366,
                            height: height * 0.047,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              // Make it circular
                              color:
                                  Color(0xffFF8203), // Button background color
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/translate.png',
                                  color: Colors.white, // Icon color
                                  width: 15, // Set the width as needed
                                  height: 15, // Set the height as needed
                                ),
                                Text(
                                  'Translate', // Replace with your desired text
                                  style: TextStyle(
                                    color: Colors.white, // Text color
                                  ),
                                ),
                              ],
                            ),
                          );
                  },
                ),
                // FormButton(
                //   buttonText: "   Translate",
                //   buttonColor: Color(0xffFF8203),
                //   buttonIconName: 'translate.png',
                //   buttonHeight: height * 0.047,
                //   buttonWidth: width * 0.366,
                //   // iconHeight: 27,
                //   // iconWidth: 22,
                // ),
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
          Column(
            children: [
              Flex(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                direction:
                    Axis.vertical, // or Axis.horizontal based on your layout
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
                      child: translationProvider.isProcessing
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Waiting",
                                  style: GoogleFonts.firaSans(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/published_with_changes.png',
                                  color: Colors.white, // Icon color
                                  width: 24, // Set the width as needed
                                  height: 24, // Set the height as needed
                                ),
                                Text(
                                  "Ready",
                                  style: GoogleFonts.firaSans(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            )),
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
                          controller: _translatedTextController,
                          enabled: true, // Disable editing
                          maxLines: null,
                          style: TextStyle(
                            fontSize: 16.0,
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
                                    Clipboard.setData(ClipboardData(
                                        text: _translatedTextController.text));
                                    Fluttertoast.showToast(
                                      msg: 'Text copied',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                    );
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
                      InkWell(
                        onTap: () {
                          Text_pdf = _translatedTextController.text;
                          PdfService.saveAndLaunchFile(
                              Text_pdf, 'Translated.pdf');
                        },
                        child: DownloadButtons(
                          downloadIconName: 'pdf',
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Text_content = _translatedTextController.text;
                          textFileGeneration
                              .generateAndDownloadFile(Text_content);
                        },
                        child: DownloadButtons(
                          downloadIconName: 'word',
                        ),
                      ),
                    ],
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
