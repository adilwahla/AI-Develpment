import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  final String headerText;
  const FormHeader({super.key, required this.headerText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff4C5AFE),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              headerText,
              style: TextStyle(
                color: Color(0xffffffff),
                fontSize: 12,
                fontFamily: 'Poppins',
              ),
            )),
      ),
    );
  }
}
