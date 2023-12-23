import 'dart:convert';
import 'dart:typed_data';
import 'package:docx_to_text/docx_to_text.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:my_app/Widgets/Buttons/FormButton.dart';
import 'package:my_app/Widgets/Buttons/downloadButtons.dart';
import 'package:my_app/Widgets/FormContainer.dart';
import 'package:my_app/Widgets/FormHeader.dart';
import 'package:my_app/Widgets/Text/FormLabel.dart';
import 'package:my_app/config_dev.dart';

import 'package:my_app/services/auth_services.dart';
import 'package:my_app/services/pdfService.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class TranslatePage extends StatelessWidget {
  const TranslatePage({super.key});

  @override
  Widget build(BuildContext context) {
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
  PdfService pdfService = PdfService();
  TextEditingController textarea = TextEditingController();
  String? language;
  // String? selectLanguage;
  String inputText = '';
  late String Text_pdf;

  TextEditingController _documentTextController = TextEditingController();
  TextEditingController _typedTextController = TextEditingController();
  TextEditingController _translatedTextController = TextEditingController();
  TextEditingController _selectLanguageController = TextEditingController();

  bool isTranslationSuccessful = false;
  void _initiateTranslation() {
    setState(() {
      _documentTextController.text = inputText;
    });
    print('this is document input $inputText');
    authService.translate(
      documentText: inputText,
      input: _typedTextController.text,
      language: _selectLanguageController.text,
      onTranslation: _handleTranslationSuccess,
      onError: _handleTranslationError,
    );
  }

  void _handleTranslationSuccess(String result) {
    // Handle success, e.g.,
    // Update the state with the translated text
    setState(() {
      isTranslationSuccessful = true;
      _translatedTextController.text = result;
    });
  }

  void _handleTranslationError(String error) {
    setState(() {
      isTranslationSuccessful = false;
    });
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
      print("i am called =$content");
      return content;
    } catch (e) {
      print('Error reading file: $e');
      return '';
    }
  }

  // Future<String> extractTextFromWord(PlatformFile file) async {
  //   try {
  //     final StringBuffer buffer = StringBuffer();

  //     return buffer.toString();
  //   } catch (e) {
  //     print('Error extracting text from Word document: $e');
  //     return '';
  //   }
  // }
// Future<String> extractTextFromWord() async {
//   try {
//     // Create a file input element and trigger its click programmatically
//     final input = uhtml.InputElement()..type = 'file';
//     input.click();

//     // Wait for the user to select a file
//     await input.onChange.first;

//     // Access the selected file
//     final file = input.files!.first;

//     if (file.type != "application/vnd.openxmlformats-officedocument.wordprocessingml.document") {
//       throw Exception('Selected file is not a Word document.');
//     }

//     // Create a FileReader
//     final reader = html.FileReader();

//     // Set an onload event to get the text content once it's loaded
//     reader.onLoad.first.then((e) {
//       // Use the reader.result to get the content of the Word document
//       final content = reader.result as String;

//       // Here you can further process the content if needed
//       print(content);
//       return content;
//     });

//     // Read the content of the selected file as text
//     reader.readAsText(file);

//     // Return a placeholder for now
//     return 'Processing...';
//   } catch (e) {
//     print('Error extracting text from Word document: $e');
//     return '';
//   }
// }

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
                    } else if (file.extension == 'docx') {
                      Future<String> docxText = _readFile(file);
                      String text = await docxText;
                      print("this is word file text: $text");
                    } else if (file.extension == 'txt') {
                      Uint8List uint8List = result.files.first.bytes!;
                      // Convert bytes to string
                      inputText = utf8.decode(uint8List);
                      print('this is Text file: $inputText');
                    } else {
                      print("unsupported file format ${file.extension}");
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
              InkWell(
                onTap: () {
                  _initiateTranslation();
                  print('tranlste button got pressed');
                },
                child: FormButton(
                  buttonText: "   Translate",
                  buttonColor: Color(0xffFF8203),
                  buttonIconName: 'translate.png',
                  buttonHeight: height * 0.047,
                  buttonWidth: width * 0.366,
                  // iconHeight: 27,
                  // iconWidth: 22,
                ),
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
                child: isTranslationSuccessful
                    ? Row(
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
                      )
                    : Center(
                        child: Text(
                          "Waiting",
                          style: GoogleFonts.firaSans(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
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
                      PdfService.saveAndLaunchFile(Text_pdf, 'Translated.pdf');
                    },
                    child: DownloadButtons(
                      downloadIconName: 'pdf',
                    ),
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
