import 'package:flutter/material.dart';

class MlutiLineTextArea extends StatefulWidget {
  final String iconName;
  final double width;
  final int lines;
  const MlutiLineTextArea({
    super.key,
    required this.iconName,
    this.width = 400,
    this.lines = 8,
  });

  @override
  State<MlutiLineTextArea> createState() => _MlutiLineTextAreaState();
}

class _MlutiLineTextAreaState extends State<MlutiLineTextArea> {
  TextEditingController textarea = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        // color: Color(0xffE2E4FB),
        color: Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Color(0xffE2E4FB), // Set the border color to E2E4FB
          width: 2, // Customize the border width
        ),
      ),
      width: widget.width,
      child: Column(
        children: [
          TextField(
            style: TextStyle(
              fontSize: 16.0,
              fontFamily: 'Poppins',
              fontStyle: FontStyle.italic,
              color: Color(0xff8598AD),
            ),
            controller: textarea,
            keyboardType: TextInputType.multiline,
            maxLines: widget.lines,
            decoration: InputDecoration(
              labelStyle: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Poppins',
                fontStyle: FontStyle.italic,
                color: Color(0xff8598AD),
              ),
              contentPadding: EdgeInsets.all(10),
              // hintText: "Enter Remarks",
              prefixText: "I want this text to be added",
              hintStyle: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Poppins',
                fontStyle: FontStyle.italic,
                color: Color(0xff8598AD),
              ),
              border: InputBorder.none, // Remove the underline
              // focusedBorder: OutlineInputBorder(
              //     borderSide: BorderSide(width: 1, color: Colors.redAccent),
              //     ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Visibility(
              visible: widget.iconName != '0',
              child: IconButton(
                onPressed: () {
                  print(textarea.text);
                },
                icon: Image.asset('assets/images/' + widget.iconName),
              ),
            ),
          )
        ],
      ),
    );
  }
}
