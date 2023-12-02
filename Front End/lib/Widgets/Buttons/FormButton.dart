import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final String buttonIconName;
  final double buttonWidth;
  final double buttonHeight;
  final Color iconColor;
  final double iconWidth;
  final double iconHeight;
  final double buttonRadius;

  FormButton({
    super.key,
    this.buttonText = "ButtonText",
    this.buttonColor = const Color(0xffFF8203),
    this.buttonIconName = 'autorenew.png',
    this.buttonWidth = 704,
    this.buttonHeight = 51,
    this.iconColor = Colors.white,
    this.iconWidth = 15,
    this.iconHeight = 15,
    this.buttonRadius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth,
      height: buttonHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(buttonRadius),
        // Make it circular
        color: buttonColor, // Button background color
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/' + buttonIconName,
              color: iconColor, // Icon color
              width: iconWidth, // Set the width as needed
              height: iconHeight, // Set the height as needed
            ),
            Text(
              buttonText, // Replace with your desired text
              style: TextStyle(
                color: Colors.white, // Text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
