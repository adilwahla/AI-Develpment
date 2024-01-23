import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
    required this.width,
    required this.height,
    required this.onEmailTap,
  });

  final double width;
  final double height;
  final VoidCallback onEmailTap;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4),
        child: Container(
          width: width * 0.142,
          height: height * 0.12,
          decoration: BoxDecoration(
            color: Color(0xFF3D4AE0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          child: DottedBorder(
            color: Color(0xff7A85FF),
            borderType: BorderType.RRect,
            radius: Radius.circular(15),
            dashPattern: [5, 5],
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/fone.png', // path to your asset image
                      width: 20.0,
                      height: 20.0,
                    ),
                    Image.asset(
                      'assets/images/mail2.png', // path to your asset image
                      width: 20.0,
                      height: 20.0,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0), //implement here
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: 'PHONE\n+36301533386',
                        ),
                        style: GoogleFonts.montserrat(
                          // fontFamily: 'Montserrat',
                          color: Color(0xffF2F2F2),
                          fontSize: 10,
                          height:
                              1, // Line height is set as a multiplier of font size
                          letterSpacing: 0.04,
                        ),
                      ),
                      GestureDetector(
                        onTap: onEmailTap,
                        child: Text.rich(
                          TextSpan(
                            text: 'EMAIL\ninfo@aidevelopment.hu',
                          ),
                          style: GoogleFonts.montserrat(
                            // fontFamily: 'Montserrat',
                            color: Color(0xffF2F2F2),
                            fontSize: 10,
                            height:
                                1, // Line height is set as a multiplier of font size
                            letterSpacing: 0.04,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
