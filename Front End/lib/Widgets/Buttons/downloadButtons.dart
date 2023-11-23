import 'package:flutter/material.dart';

class DownloadButtons extends StatelessWidget {
  final String downloadIconName;

  const DownloadButtons({Key? key, required this.downloadIconName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width * 0.175,
      height: height * 0.047,
      decoration: BoxDecoration(
        color: Color(0xffFDFFFF),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Color(0xffE2E4FB),
          width: 1.0,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          onTap: () {
            // Add your onPressed functionality here
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 0.0), // Left side padding
            child: Row(
              children: [
                Image.asset(
                  'assets/images/download.png',
                  color: Color(0xffFF8203),
                  width: width * 0.035,
                  height: height * 0.035,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    Text(
                      " Download as",
                      style: TextStyle(
                        color: Color(0xff8B8FB5),
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: 5),
                    Image.asset(
                      'assets/images/$downloadIconName.png',
                      width: width * 0.035,
                      height: height * 0.035,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
