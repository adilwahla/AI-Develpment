import 'package:flutter/material.dart';

class DownloadButtons extends StatelessWidget {
  final String DownloadIconName;
  const DownloadButtons({super.key, required this.DownloadIconName});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width * 1 / 7,
      child: ElevatedButton(
        onPressed: () {
          // Add your onPressed functionality here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xffFDFFFF), // Button background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0), // Set the border radius
          ),
          side: BorderSide(
            color: Color(0xffE2E4FB), // Set the border color to E2E4FB
            width: 1.0, // Adjust the border width as needed
          ),
        ),
        child: Expanded(
          // Adjust as needed
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Image.asset(
                  'assets/images/download.png', // Path to your image asset
                  color: Color(0xffFF8203), // Set the icon color
                  width: 24, // Set the icon width as needed
                  height: 24, // Set the icon height as needed
                ),
              ),
              // Icon(Icons.download,
              //     color:
              //         Color(0xffFF8203),
              //         ), // Replace "icon1" with your icon
              // Replace "icon2" with another icon
              Text(
                " Download as ",
                style: TextStyle(
                    color: Color(0xff8B8FB5), // Set text color
                    fontSize: 12),
              ),
              //  Icon(Icons.input_rounded, color: Color(0xff8B8FB5)),
              // Icon(Icons.input_rounded, color: Color(0xff8B8FB5)),
              Flexible(
                child: Image.asset(
                  'assets/images/$DownloadIconName.png',
                  // color: Color(0xff8B8FB5),
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
          // children: [

          // ],
        ),
      ),
    );
  }
}
