import 'package:flutter/material.dart';
import 'package:my_app/Utils.dart';
import 'package:my_app/Widgets/Buttons/CustomDropdownButton.dart';
import 'package:my_app/Widgets/Buttons/DropDownButton.dart';
import 'package:my_app/Widgets/FormContainer.dart';

import 'package:my_app/Widgets/FormHeader.dart';
import 'package:my_app/Widgets/Text/FormLabel.dart';
import 'package:my_app/Widgets/Text/TextArea.dart';

class Email extends StatelessWidget {
  const Email({super.key});

  @override
  Widget build(BuildContext context) {
    return FormContainer(
      addFormElements: Column(
        children: [
          FormHeader(
            headerText: 'Generate Email',
          ),
          // EmailFormBody(),
          BodyEmailForm()
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
  static const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  static const List<String> list2 = <String>['One', 'Two', 'Three', 'Four'];
  static const List<String> list3 = <String>['One', 'Two', 'Three', 'Four'];
  static const List<String> list4 = <String>['One', 'Two', 'Three', 'Four'];
  static const List<String> list5 = <String>['One', 'Two', 'Three', 'Four'];

  String? object;
  String? selectType;
  String? length;
  TextEditingController emailTo = TextEditingController();

  // String dropdownValue = list.first;
  String dropdownValue2 = list2.first;
  String dropdownValue3 = list3.first;
  String dropdownValue4 = list4.first;
  String dropdownValue5 = list5.first;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: FormLabelText(
              labelText: "Object",
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 6, left: 8),
            width: width * 0.79,
            height: 33,
            decoration: BoxDecoration(
              color: Color(0xffFFFFFF),
              border: Border.all(
                color: Color(0xffE2E4FB), // Set your desired border color
                width: 1, // Customize the border width
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: DropdownButton<String>(
                isExpanded: true,
                underline: Container(),
                dropdownColor: Colors.white,
                value: object,
                style: TextStyle(color: Colors.black),
                items: <String>[
                  'English',
                  'History',
                  'Maths',
                  'Political Science',
                  'Hindi',
                  'Biology',
                  'Chemistry',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: Text(
                  "Please choose a subject",
                  style: TextStyle(
                    color: Color(0xff8598AD),
                    fontSize: 10.0,
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    object = value;
                    print("ttttt${object}");
                  });
                },
              ),
            ),
          ),
          Row(
            //  crossAxisAlignment: CrossAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormLabelText(
                    labelText: "Write an",
                  ),
                  // CustomDropdownButton(
                  //     width: width * 1 / 6,
                  //     itemList: list2,
                  //     onChanged: (String? value) {
                  //       setState(() {
                  //         dropdownValue2 = value!;
                  //       });
                  //     },
                  //     dropdownValue: dropdownValue2),
                  Container(
                    padding: EdgeInsets.only(top: 6, left: 8),
                    width: width * 0.18,
                    height: 33,
                    decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      border: Border.all(
                        color:
                            Color(0xffE2E4FB), // Set your desired border color
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
                        style: TextStyle(color: Colors.black),
                        items: <String>[
                          'Inside Email',
                          'Close Partner Email',
                          'Normal Partner Email',
                          'Unknown Partner Email',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        hint: Text(
                          "Select Type",
                          style: TextStyle(
                            color: Color(0xff8598AD),
                            fontSize: 10.0,
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
              SizedBox(width: 28),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormLabelText(
                    labelText: "Email To",
                  ),
                  Container(
                    width: width * 0.18,
                    height: 33,
                    decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      border: Border.all(
                        color:
                            Color(0xffE2E4FB), // Set your desired border color
                        width: 1, // Customize the border width
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        textAlign: TextAlign.left,
                        textAlignVertical: TextAlignVertical.center,
                        controller: emailTo,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                          border: InputBorder.none,
                          hintText: "Enter Email",
                          hintStyle: TextStyle(
                            color: Color(0xff8598AD),
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // CustomDropdownButton(
                  //     width: width * 1 / 6,
                  //     itemList: list3,
                  //     onChanged: (String? value) {
                  //       setState(() {
                  //         dropdownValue3 = value!;
                  //       });
                  //     },
                  //     dropdownValue: dropdownValue3),
                  // TextField(
                  //   decoration: InputDecoration(
                  //       hintText: 'Enter Email',
                  //       // contentPadding: const EdgeInsets.all(15),
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(30))),
                  //   onChanged: (value) {
                  //     // do something
                  //   },
                  // ),
                  // Container(
                  //   height: 30,
                  //   padding: EdgeInsets.symmetric(horizontal: 16.0),
                  //   decoration: BoxDecoration(
                  //     border: Border.all(
                  //       color: Color(0xffE2E4FB),
                  //       width: 1.5,
                  //     ),
                  //     borderRadius: BorderRadius.circular(30),
                  //   ),
                ],
              ),
              SizedBox(width: 28),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormLabelText(
                    labelText: "From",
                  ),
                  Container(
                    width: width * 0.18,
                    height: 33,
                    decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      border: Border.all(
                        color:
                            Color(0xffE2E4FB), // Set your desired border color
                        width: 1, // Customize the border width
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      textAlign: TextAlign.left,
                      textAlignVertical: TextAlignVertical.center,
                      controller: emailTo,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 16.0, horizontal: 5),
                        border: InputBorder.none,
                        hintText: "Enter Email",
                        hintStyle: TextStyle(
                          color: Color(0xff8598AD),
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),

                  // CustomDropdownButton(
                  //     width: width * 1 / 6,
                  //     itemList: list3,
                  //     onChanged: (String? value) {
                  //       setState(() {
                  //         dropdownValue3 = value!;
                  //       });
                  //     },
                  //     dropdownValue: dropdownValue3),
                  // TextField(
                  //   decoration: InputDecoration(
                  //       hintText: 'Enter Email',
                  //       // contentPadding: const EdgeInsets.all(15),
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(30))),
                  //   onChanged: (value) {
                  //     // do something
                  //   },
                  // ),
                  // Container(
                  //   height: 30,
                  //   padding: EdgeInsets.symmetric(horizontal: 16.0),
                  //   decoration: BoxDecoration(
                  //     border: Border.all(
                  //       color: Color(0xffE2E4FB),
                  //       width: 1.5,
                  //     ),
                  //     borderRadius: BorderRadius.circular(30),
                  //   ),
                ],
              ),
              SizedBox(width: 28),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormLabelText(
                    labelText: "In The Length of",
                  ),
                  // CustomDropdownButton(
                  //     width: width * 1 / 6,
                  //     itemList: list2,
                  //     onChanged: (String? value) {
                  //       setState(() {
                  //         dropdownValue2 = value!;
                  //       });
                  //     },
                  //     dropdownValue: dropdownValue2),
                  Container(
                    padding: EdgeInsets.only(top: 6, left: 8),
                    width: width * 0.18,
                    height: 33,
                    decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      border: Border.all(
                        color:
                            Color(0xffE2E4FB), // Set your desired border color
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
                        style: TextStyle(color: Colors.black),
                        items: <String>[
                          'Inside Email',
                          'Close Partner Email',
                          'Normal Partner Email',
                          'Unknown Partner Email',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        hint: Text(
                          "Select word count",
                          style: TextStyle(
                            color: Color(0xff8598AD),
                            fontSize: 10.0,
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
            ],
          ),
          FormLabelText(
            labelText: "About",
          ),
          MlutiLineTextArea(
            lines: 5,
            width: width * 0.79,
            iconName: "0",
            hintText: "type here",
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(right: 15, top: 12),
              child: Container(
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                    color: Color(0xffFF8203),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/autorenew.png',
                      color: Colors.white, // Icon color
                      width: 24, // Set the width as needed
                      height: 24, // Set the height as needed
                    ),
                    Text(
                      "Generate",
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
          ),
          Positioned(
            left: 0,
            child: Container(
              width: width * 0.8,
              height: 10,
              child: Divider(
                color: Color(0xffE2E4FB),
                thickness: 1.0, // Adjust the thickness as needed
                height: 8.0,
              ),
            ),
          ),
          FormLabelText(
            labelText: "Generated Email",
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.79,
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
            width: MediaQuery.of(context).size.width * 0.79,
            lines: 7,
          ),
        ],
      ),
    );
  }
}

class EmailFormBody extends StatefulWidget {
  @override
  _EmailFormBodyState createState() => _EmailFormBodyState();
}

class _EmailFormBodyState extends State<EmailFormBody> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          // TextFormField(
          //         style: const TextStyle(
          //                   fontWeight: FontWeight.w400,
          //                   // color: AppColors.blueDarkColor,
          //                   fontSize: 12.0,
          //                 ),
          //   decoration:
          //       InputDecoration(labelText: "Object", hintText: "Enter Object"),

          // )
          // Align(
          //   child: Text("Label"),
          //   alignment: Alignment.centerLeft,
          // ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              //   color: Color(0xffffffff),
              decoration: BoxDecoration(
                // color: Color(0xFFE2E4FB), // Background color
                color: Color(0xffffffff),
                borderRadius: BorderRadius.circular(70), // Border radius
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFE2E4FB), // Shadow color
                    blurRadius: 5, // Blur amount
                    spreadRadius:
                        5, // Spread amount (increase for a larger shadow)
                    offset: Offset(0, 0), // Shadow offset (adjust as needed)
                  ),
                ],
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  // Separate label
                  label: Text('Object'),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                        Icons.arrow_drop_down), // Use the arrow_drop_down icon
                  ),
                  filled: true,
                  fillColor: Color(0xffffffff), // NOT WORKING
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Color(0xFFE2E4FB), // Border color
                    ),
                    // Border radius
                  ),

                  hintText: 'Enter Object',
                  hintStyle: kFormHintStyle,
                ),
              ),
            ),
          ),
          // TextFormField(
          //   decoration: InputDecoration(
          //     // Separate label
          //     label: Text('Object'),
          //     suffixIcon: IconButton(
          //       onPressed: () {},
          //       icon:
          //           Icon(Icons.arrow_drop_down), // Use the arrow_drop_down icon
          //     ),
          //     filled: true,
          //     fillColor: Color(0xffffffff), // NOT WORKING
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(20),
          //       borderSide: BorderSide(
          //         color: Color(0xFFE2E4FB), // Border color
          //       ),
          //       // Border radius
          //     ),

          //     // hintText: 'Enter Object',
          //     hintStyle: kFormHintStyle,
          //   ),
          // ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      // Separate label
                      label: Text('write an'),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_drop_down),
                      ),
                      filled: true,
                      fillColor: Color(0xffffffff),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Color(0xFFE2E4FB),
                        ),
                      ),
                      hintStyle: kFormHintStyle,
                    ),
                  ),
                ),
                SizedBox(
                    width: 16), // Add spacing between TextFormField widgets
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: Text('Email To'),
                      hintText: "Enter Email",
                      filled: true,
                      fillColor: Color(0xffffffff),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Color(0xFFE2E4FB),
                        ),
                      ),
                      hintStyle: kFormHintStyle,
                    ),
                  ),
                ),
                SizedBox(
                    width: 16), // Add spacing between TextFormField widgets
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: Text('Enter Email'),
                      filled: true,
                      fillColor: Color(0xffffffff),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Color(0xFFE2E4FB),
                        ),
                      ),
                      hintStyle: kFormHintStyle,
                    ),
                  ),
                ),
                SizedBox(
                    width: 16), // Add spacing between TextFormField widgets
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: Text('select word count'),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_drop_down),
                      ),
                      filled: true,
                      fillColor: Color(0xffffffff),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Color(0xFFE2E4FB),
                        ),
                      ),
                      hintStyle: kFormHintStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "       About",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 100, // Set the height of the Container
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black), // Set border color
                borderRadius: BorderRadius.circular(10), // Set border radius
              ),
              child: TextField(
                maxLines: 5, // Set to null or any desired number of lines
                decoration: InputDecoration(
                  // labelText: 'About',
                  hintText: 'Type here',
                  border: InputBorder.none, // Hide the default TextField border
                  contentPadding: EdgeInsets.all(
                      10), // Optional: Add padding inside the TextField
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 130,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // Make it circular
                  color: Color(0xffFF8203), // Button background color
                ),
                child: InkWell(
                  onTap: () {
                    // Handle button tap here
                  },
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/autorenew.png',
                          color: Colors.white, // Icon color
                          width: 24, // Set the width as needed
                          height: 24, // Set the height as needed
                        ),
                        Text(
                          "  Generate", // Replace with your desired text
                          style: TextStyle(
                            color: Colors.white, // Text color
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Divider(
            height: 1, // Set the height of the divider line
            color: Color(0xFFE2E4FB),
            indent: 20, // Optional: Set the left indent of the divider
            endIndent: 20, // Optional: Set the right indent of the divider
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "        Generated Email",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 35, right: 35, bottom: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1 / 3,
              color: Color(0xffF4F8FD),
              // decoration: BoxDecoration(color: Color(0xff39D1B8)
              // ),
              // child: Container(
              //   height: 5,
              //   width: MediaQuery.of(context).size.width,
              //   decoration: BoxDecoration(color: Color(0xff39D1B8)),
              //   //decoration: BoxDecoration(color: Color(0xffF4F8FD)),
              // ),
              child: Column(children: [
                Container(
                  width: MediaQuery.of(context).size.width,
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
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 16.0, right: 16, bottom: 0, top: 16),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Lorem ipsum dolor,\n\n sit amet, consectetur adipiscing elit. Nunc luctus mauris in urna tincidunt, in lacinia justo venenatis. Sed auctor velit a massa ultricies, in condimentum dui tristique. Nullam euismod eros quis augue tristique, vel hendrerit purus tristique.\n' +
                              'In hac habitasse platea dictumst. Proin vitae libero non lectus malesuada posuere. Integer sit amet purus tristique, bibendum erat in, ullamcorper arcu. Phasellus et odio nec metus facilisis efficitur at a enim.\n' +
                              'Suspendisse tristique vestibulum odio, nec varius mi finibus a. Sed sit amet mi justo. In hac habitasse platea dictumst. Pellentesque scelerisque ac nunc id scelerisque.\n' +
                              'Vivamus ac eleifend ipsum. Integer nec hendrerit mi, quis scelerisque sapien. Vestibulum quis justo a odio fringilla efficitur. Fusce sit amet elit id orci lacinia gravida. Quisque laoreet odio in ante posuere, at lobortis mauris mattis.',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Poppins',
                            fontStyle: FontStyle.italic,
                            color: Color(0xff8598AD),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            'assets/images/copy.png',
                            // color: Colors.white, // Icon color
                            // width: 24, // Set the width as needed
                            // height: 24, // Set the height as needed
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]))
        ],
      ),
    );
  }
}

class CustomForm extends StatelessWidget {
  const CustomForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 45,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xff4C5AFE),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Generate Email",
                style: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 12,
                  fontFamily: 'Poppins',
                ),
              )),
        ),
      ),
      // MyCustomForm(),
      Positioned(
          top: 70,
          left: 25,
          child: Text(
            "Object",
            style: kFormLableStyle,
          )),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 100),
        child: Container(
          //   color: Color(0xffffffff),
          decoration: BoxDecoration(
            // color: Color(0xFFE2E4FB), // Background color
            color: Color(0xffffffff),
            borderRadius: BorderRadius.circular(20), // Border radius
            boxShadow: [
              BoxShadow(
                color: Color(0xFFE2E4FB), // Shadow color
                blurRadius: 5, // Blur amount
                spreadRadius: 5, // Spread amount (increase for a larger shadow)
                offset: Offset(0, 0), // Shadow offset (adjust as needed)
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {},
                icon:
                    Icon(Icons.arrow_drop_down), // Use the arrow_drop_down icon
              ),
              filled: true,
              fillColor: Color(0xffffffff), // NOT WORKING
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Color(0xFFE2E4FB), // Border color
                ),
                // Border radius
              ),
              hintText: 'Enter Object',
              hintStyle: TextStyle(
                fontSize: 12,
                color: Color(0xFF8598AD),
                fontFamily: 'Poppins',
                fontStyle: FontStyle.italic, // Make the text italic
              ),
            ),
          ),
        ),
      ),

      Row(
        children: [],
      )
    ]);
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: const Column(
        children: <Widget>[
          // Add TextFormFields and ElevatedButton here.

          // Align(
          //   alignment: Alignment.topLeft,
          //   child: Text(
          //     "Generate Email",
          //     style: TextStyle(fontSize: 18),
          //   ),
          // ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              decoration: InputDecoration(
                fillColor: Color(0xffFFFFFF),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFE2E4FB), // Border color
                  ),
                  // Border radius
                ),
                hintText: 'Enter Object',
                hintStyle: TextStyle(color: Color(0xFF8598AD)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
