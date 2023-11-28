import 'package:flutter/material.dart';

class CustomRoundedIconButton extends StatefulWidget {
  final String iconLink;
  final String buttonText;
  final Function()? onPressed;

  CustomRoundedIconButton({
    required this.iconLink,
    required this.buttonText,
    this.onPressed,
  });

  @override
  _CustomRoundedIconButtonState createState() =>
      _CustomRoundedIconButtonState();
}

class _CustomRoundedIconButtonState extends State<CustomRoundedIconButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.0472,
      width: width * 0.096,
      padding: EdgeInsets.zero,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isSelected = !isSelected;
          });
          if (widget.onPressed != null) {
            widget.onPressed!();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: isSelected ? Color(0xFF4C5AFE) : Color(0xFF9296C3),
          ),
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: Image.asset(
                  widget.iconLink,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8), // Adjust the space between icon and text
              Text(
                widget.buttonText,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
