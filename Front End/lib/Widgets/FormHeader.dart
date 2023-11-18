import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  final String headerText;
  const FormHeader({super.key, required this.headerText});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 30,
      height: MediaQuery.of(context).size.height * 0.07037,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff4C5AFE),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              headerText,
              style: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500),
            )),
      ),
    );
  }
}
