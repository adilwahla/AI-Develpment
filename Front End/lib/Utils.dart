import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:xen_popup_card/xen_popup_card.dart';

const kFormLableStyle = TextStyle(
    fontSize: 14,
    color: Color(0xFF000000),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500);

const kFormHintStyle = TextStyle(
  fontSize: 12,
  color: Color(0xFF8598AD),
  fontFamily: 'Poppins',
  fontStyle: FontStyle.italic, // Make the text italic
);

TextStyle kh1Style = TextStyle(
  fontSize: 34, // Adjust the font size as needed
  fontWeight: FontWeight.w800, // You can adjust the font weight
  color: const Color.fromARGB(255, 255, 255, 255), // Adjust the text color
  fontFamily: 'Inter',
  shadows: [
    Shadow(
      offset: Offset(0, 0),
      blurRadius: 5.0,
      color: Colors.black, // Stroke color (black)
    ),
  ],
);

TextStyle line1Style = TextStyle(
  fontSize: 18,
  color: const Color(0xFFFFFFFF), // White text color
  fontFamily: 'Inter',
  fontWeight: FontWeight.w800,
  height: 39 / 20, // Line height is set to 39
  letterSpacing: 0.0, // No letter spacing
  shadows: [
    Shadow(
      offset: Offset(0, 0),
      blurRadius: 5.0,
      color: Colors.black, // Stroke color (black)
    ),
  ],
);

BoxDecoration kHomeCardsdecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(30.0), // Adjust the radius as needed
  color: Color(0xFFFDFFFF),
  // Background color
  border: Border.all(
    color: Colors.black.withOpacity(0.5), // Stroke color
    width: 0.5, // Stroke width
  ),
  boxShadow: [
    BoxShadow(
      color: Color(0xff666CFF).withAlpha(153), // 60% opacity
      offset: Offset(0, 0), // Offset (x, y) of the shadow
      blurRadius: 2, // Spread of the shadow
      spreadRadius: 1, // Expansion of the shadow
    ),
  ],
);

BoxDecoration kFormContainerDecoration = BoxDecoration(
  // color: Colors.amberAccent,
  // color: Color(0xFFFDFFFF),
  //color: Color(0xffE2E4FB).withOpacity(0.2), //  ebf2fc
  color: Color(0xffebf2fc).withOpacity(0.4), //  ebf2fc
  borderRadius: BorderRadius.circular(20),
  border: Border.all(
    color: Color(0xffE2E4FB), // Set the border color to E2E4FB
    width: 1, // Customize the border width
  ), // Border width
  boxShadow: [
    BoxShadow(
      color: Color(0xFFFDFFFF), // Shadow color with transparency
      //   color: Colors.black.withOpacity(0.1),
      // spreadRadius: 2, // Spread radius
      // blurRadius: 1, // Blur radius
      offset: Offset(0, 0), // Offset
    ),
  ],
);

Gradient kCardsLinearGradient = LinearGradient(
  begin: Alignment.bottomCenter, // Start from the top
  end: Alignment.topCenter,
  stops: [0.0, 0.2], // End at the bottom
  colors: [
    Color(0xff404DE0),
    Color(0xff6874FF).withOpacity(1),
  ],
);

TextStyle kMiniCardsStyle =
    GoogleFonts.inter(color: Color(0xFFFFFFFF), fontSize: 12);

class AppColors {
  static const Color backColor = Color(0xffF6F6F6);
  static const Color mainBlueColor = Color(0xff4C5AFE);
  static const Color blueDarkColor = Color(0xff252B5C);
  static const Color textColor = Color(0xff53587A);
  static const Color greyColor = Color(0xffAAAAAA);
  static const Color whiteColor = Color(0xffFFFFFF);
}

const kEmailInputStyle = TextStyle(
  color: Color(0xff8598AD),
  fontSize: 13.0,
  fontFamily: 'Poppins',
  fontWeight:
      FontWeight.w200, // FontWeight.w200 represents the "extra-light" weight
  fontStyle: FontStyle.italic,
);
InputDecoration kEmailInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintStyle: TextStyle(
    color: Color(0xff8598AD),
    fontSize: 12.0,
    fontFamily: 'Poppins',
    fontWeight:
        FontWeight.w200, // FontWeight.w200 represents the "extra-light" weight
    fontStyle: FontStyle.italic,
  ),
  contentPadding: const EdgeInsets.all(15),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(
      width: 1,
      color: Color(0xffE2E4FB), //E2E4FB
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: Color(0xff4C5AFE)),
  ),
);

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBar(context, response.body);
  }
}

class Constants {
  static String uri = 'http://localhost:3000';
}

class HttpUtils {
  static void httpErrorHandle({
    required http.Response response,
    required Function onSuccess,
    required Function(String) onError,
  }) {
    // Handle HTTP errors here
    if (response.statusCode == 200) {
      onSuccess();
    } else {
      onError(response.body);
    }
  }
}
