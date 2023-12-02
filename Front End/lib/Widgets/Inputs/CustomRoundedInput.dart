import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  CustomTextInput({
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.047,
      width: width * 0.190,
      decoration: BoxDecoration(
        color: Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: controller,
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
            hintText: hintText,
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
    );
  }
}
