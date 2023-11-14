import 'package:flutter/material.dart';

class FormLabelText extends StatelessWidget {
  final String labelText;
  final double fontSize;
  const FormLabelText(
      {super.key, this.labelText = "label", this.fontSize = 16});

  @override
  Widget build(BuildContext context) {
    return Text(
      labelText,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          color: Color(0xff000000)),
    );
  }
}