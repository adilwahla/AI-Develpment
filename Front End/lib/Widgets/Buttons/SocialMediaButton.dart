import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomRoundedIconButton extends StatefulWidget {
  final IconData iconData;
  final String buttonText;
  final Function()? onPressed;

  CustomRoundedIconButton({
    required this.iconData,
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
    return ElevatedButton.icon(
      onPressed: () {
        setState(() {
          isSelected = !isSelected;
        });
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
      },
      icon: FaIcon(
        widget.iconData,
        color: Colors.white,
      ),
      label: Text(
        widget.buttonText,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Color(0xFF4C5AFE) : Color(0xFF9296C3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
