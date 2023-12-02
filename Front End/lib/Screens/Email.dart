// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Utils.dart';
import 'package:my_app/Widgets/FormContainer.dart';

import 'package:my_app/Widgets/FormHeader.dart';
import 'package:my_app/Widgets/Text/FormLabel.dart';

class Email extends StatelessWidget {
  const Email({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return FormContainer(
      addFormElements: Column(
        children: [
          FormHeader(
            headerText: 'Generate Email',
          ),
          // EmailFormBody(),
          BodyEmailForm(),
          SizedBox(
            height: 15,
          ),
          Divider(
            color: Color(0xffE2E4FB),
            thickness: 1.0, // Adjust the thickness as needed
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20, top: 10, bottom: 5),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: FormLabelText(
                labelText: "Generated Email",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Container(
              width: double.infinity,
              height: height * 0.0491,
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
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  // color: Color(0xffE2E4FB),
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  border: Border.all(
                    color: Color(0xffE2E4FB), // Set the border color to E2E4FB
                    width: 1, // Customize the border width
                  ),
                ),
                child: Container(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: double.infinity,
                    ),
                    child: TextField(
                      enabled: false,
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
          ),
        ],
      ),
    );
  }
}

class BodyEmailForm extends StatefulWidget {
  const BodyEmailForm({super.key});

  @override
  State<BodyEmailForm> createState() => _BodyEmailFormState();
}

class _BodyEmailFormState extends State<BodyEmailForm> {
  // String? object;
  String? selectType;
  String? length;
  TextEditingController emailTo = TextEditingController();
  TextEditingController emailFrom = TextEditingController();
  TextEditingController object = TextEditingController();

  // String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 4, left: 3),
            child: FormLabelText(
              labelText: "Object",
            ),
          ),
          Container(
            // width: width * 0.18,
            width: double.infinity,
            height: height * 0.047,
            decoration: BoxDecoration(
              color: Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(25),
            ),
            child: TextField(
              controller: object,
              style: TextStyle(
                // color: Color(0xff8598AD),
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
                  hintText: 'Enter Object',
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
          //   // padding: EdgeInsets.only(top: 6, left: 8),
          //   width: double.infinity,
          //   height: height * 0.04722,

          //   child: TextField(

          //     textAlignVertical: TextAlignVertical.center,
          //     controller: object,
          //     style: kEmailInputStyle,
          //     decoration:
          //         kEmailInputDecoration.copyWith(hintText: "Enter Object"),
          //     onChanged: (value) {
          //       // do something
          //     },
          //   ),
          // ),
          Row(
            //  crossAxisAlignment: CrossAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, bottom: 4, left: 3),
                      child: FormLabelText(
                        labelText: "Write an",
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: height * 0.04722,
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
                          value: selectType,
                          style: TextStyle(
                            color: Color(0xff8598AD),
                            fontSize: 12.0,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight
                                .w200, // FontWeight.w200 represents the "extra-light" weight
                            fontStyle: FontStyle.italic,
                          ),
                          items: <String>[
                            'Inside Email',
                            'Close Partner Email',
                            'Normal Partner Email',
                            'Unknown Partner Email',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
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
                              selectType = value;
                              print("ttttt${selectType}");
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 28),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, bottom: 4, left: 3),
                      child: FormLabelText(
                        labelText: "Email To",
                      ),
                    ),
                    Container(
                      // width: width * 0.18,
                      width: double.infinity,
                      height: height * 0.047,
                      decoration: BoxDecoration(
                        color: Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextField(
                        controller: emailTo,
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
                            hintText: 'Enter Email',
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
                  ],
                ),
              ),
              SizedBox(width: 28),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, bottom: 4, left: 3),
                      child: FormLabelText(
                        labelText: "From",
                      ),
                    ),
                    Container(
                      // width: width * 0.18,
                      width: double.infinity,
                      height: height * 0.047,
                      decoration: BoxDecoration(
                        color: Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextField(
                        controller: emailFrom,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight
                              .w200, // represents "extra-light" weight
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
                            hintText: 'Enter Email',
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
                  ],
                ),
              ),
              SizedBox(width: 28),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, bottom: 4, left: 3),
                      child: FormLabelText(
                        labelText: "In The Length of",
                      ),
                    ),
                    Container(
                      // padding: EdgeInsets.only(top: 6, left: 8),
                      width: double.infinity,
                      height: height * 0.04722,
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
                          value: length,
                          style: TextStyle(
                            color: Color(0xff8598AD),
                            fontSize: 12.0,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight
                                .w200, // FontWeight.w200 represents the "extra-light" weight
                            fontStyle: FontStyle.italic,
                          ),
                          items: <String>[
                            'short',
                            'medium',
                            'long',
                            'extra long',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              "Select word count",
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
                              length = value;
                              print("ttttt${length}");
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, bottom: 4, left: 3),
                    child: FormLabelText(
                      labelText: "About",
                    ),
                  ),
                  Container(
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
                    child: Container(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: height * 0.1389,
                        ),
                        child: TextField(
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
                            labelStyle: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Poppins',
                              // fontStyle: FontStyle.italic,
                              color: Color(0xff8598AD),
                            ),
                            contentPadding: EdgeInsets.all(16),
                            hintText: "Type here",
                            // prefixText: "I want this text to be added",
                            hintStyle: TextStyle(
                              color: Color(0xff8598AD),
                              fontSize: 12.0,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight
                                  .w200, // FontWeight.w200 represents the "extra-light" weight
                              fontStyle: FontStyle.italic,
                            ),
                            border: InputBorder.none, // Remove the underline
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(top: 12),
              child: Container(
                padding: EdgeInsets.all(5),
                width: width * 0.1125,
                height: height * 0.04722,
                decoration: BoxDecoration(
                    color: Color(0xffFF8203),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/autorenew.png',
                      color: Colors.white, // Icon color
                      width: 24, // Set the width as needed
                      height: 24, // Set the height as needed
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
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
