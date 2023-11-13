import 'package:flutter/material.dart';
import 'package:my_app/Utils.dart';

class FormContainer extends StatelessWidget {
  final double left, right, bottom, top, widthFactor, heightFactor;
  final Widget addFormElements;
  const FormContainer(
      {super.key,
      this.left = 40,
      this.right = 40,
      this.bottom = 30,
      this.top = 30,
      this.widthFactor = 0.85,
      this.heightFactor = 3 / 4,
      required this.addFormElements});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(50),
      margin:
          EdgeInsets.only(left: left, right: right, bottom: bottom, top: top),
      width: MediaQuery.of(context).size.width * widthFactor,
      height: MediaQuery.of(context).size.height * heightFactor,
      //     margin: EdgeInsets.only(left: 40, right: 40, bottom: 30, top: 30),
      // width: MediaQuery.of(context).size.width * 0.85,
      // height: MediaQuery.of(context).size.height * 3 / 4,

      decoration: kFormContainerDecoration,
      // child: CustomForm(),
      child: addFormElements,
    );
  }
}