import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Widgets/Buttons/FormButton.dart';
import 'package:my_app/Widgets/Buttons/downloadButtons.dart';
import 'package:my_app/Widgets/FormContainer.dart';
import 'package:my_app/Widgets/FormHeader.dart';
import 'package:my_app/Widgets/Text/FormLabel.dart';
import 'package:my_app/services/pdfService.dart';
import 'package:my_app/services/reportService.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

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
  ReportService _reportService = ReportService();
  PdfService _pdfService = PdfService();
  TextEditingController? textarea = TextEditingController();
  // TextEditingController EnterLanguage = TextEditingController();
  String? object;
  String ExtractedText = '';
  String? selectLength;
  String? selectedLanguage;
  String GeneratedReport = "";

  void _initiateReportGeneration() {
    // setState(() {
    //   textarea.text = inputText;
    // });
    // print('this is document input $inputText');
    _reportService.GenerateReport(
      documentText: ExtractedText,
      length: selectLength,
      language: selectedLanguage,
      onSuccess: _handleReportSuccess,
      onError: _handleReportError,
    );
  }

  _handleReportSuccess(String result) {
    print("_handleReportSuccess $result");
    setState(() {
      print('set state is called');
      GeneratedReport = result;
      textarea?.text = GeneratedReport;
    });
  }

  _handleReportError(String error) {
    Fluttertoast.showToast(
      msg: "You Exceed the token limit try shorter document",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _extractTextFromSelectedFile() async {
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
        final PdfDocument document = PdfDocument(inputBytes: fileBytes);

        //Create PDF text extractor to extract text
        PdfTextExtractor extractor = PdfTextExtractor(document);

        // ${String.fromCharCodes(fileBytes!)}
        ExtractedText = extractor.extractText();
        print('here goes pdf @text ${ExtractedText} ');
      } else if (file.extension == 'docx') {
        // Future<String> docxText = _readFile(file);
        // String text = await docxText;
        // print("this is word file text: $text");
      } else if (file.extension == 'txt') {
        Uint8List uint8List = result.files.first.bytes!;
        // Convert bytes to string
        ExtractedText = utf8.decode(uint8List);
        print('this is Text file: $ExtractedText');
      } else {
        print("unsupported file format ${file.extension}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      textarea?.text = GeneratedReport;
    });
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
                  InkWell(
                    onTap: () {
                      _extractTextFromSelectedFile();
                    },
                    child: FormButton(
                      buttonText: "   Generate Report",
                      buttonColor: Color(0xff4C5AFE),
                      buttonIconName: 'paste.png',
                      buttonHeight: height * 0.047,
                      buttonWidth: width * 0.366,
                      // iconHeight: 27,
                      // iconWidth: 22,
                    ),
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
                                  value: selectLength,
                                  style: TextStyle(
                                    // color: Color(0xff8598AD),
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight
                                        .w200, // FontWeight.w200 represents the "extra-light" weight
                                    fontStyle: FontStyle.italic,
                                  ),
                                  items: <String>[
                                    '200 words',
                                    'Half page',
                                    'One page',
                                    'Two page',
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
                                        //  color: Colors.black,
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
                                      print("Length=${selectLength}");
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
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextField(
                                // controller: EnterLanguage,
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
                                      borderSide:
                                          BorderSide(color: Color(0xff4C5AFE)),
                                    )),
                                onChanged: (String value) {
                                  setState(() {
                                    selectedLanguage = value;
                                    print(
                                        "selectedLanguage=${selectedLanguage}");
                                  });
                                },
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
                  InkWell(
                    onTap: () {
                      _initiateReportGeneration();
                      print('Generate Button pressed');
                    },
                    child: FormButton(
                      buttonText: "   Generate",
                      buttonColor: Color(0xffFF8203),
                      buttonIconName: 'autorenew.png',
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
                        // Image.asset(
                        //   'assets/images/published_with_changes.png',
                        //   color: Colors.white, // Icon color
                        //   width: 15, // Set the width as needed
                        //   height: 15, // Set the height as needed
                        // ),
                        Text(
                          "Waiting",
                          style: GoogleFonts.firaSans(
                              color: Colors.white,
                              // fontFamily: 'Fira Sans',
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
                          controller: textarea,
                          enabled: true,
                          maxLines: null,
                          style: TextStyle(
                            fontSize: 14.0,
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
                                    Clipboard.setData(
                                        ClipboardData(text: textarea!.text));
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
                          print('download pdf');
                          GeneratedReport = textarea!.text;
                          PdfService.saveAndLaunchFile(
                              GeneratedReport, 'Report.pdf');
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
        ),
      ],
    );
  }
}
