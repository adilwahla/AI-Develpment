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
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Color(0xffFFFFFF),
        border: Border.all(
          color: Color(0xffE2E4FB),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        style: TextStyle(
          color: Color(0xff8598AD),
          fontSize: 12.0,
          fontFamily: 'Poppins',
          fontWeight: FontWeight
              .w200, // FontWeight.w200 represents the "extra-light" weight
          fontStyle: FontStyle.italic,
        ),
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(0xff8598AD),
            fontSize: 12.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight
                .w200, // FontWeight.w200 represents the "extra-light" weight
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
