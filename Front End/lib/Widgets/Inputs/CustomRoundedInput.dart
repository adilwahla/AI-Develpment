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
    return Expanded(
      child: Container(
        height: 30,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xffE2E4FB),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
              color: Color(0xff8598AD),
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w200,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
