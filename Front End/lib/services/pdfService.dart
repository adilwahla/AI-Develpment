import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfService {
  static String removeUnicodeAndEmojis(String text) {
    // Use regex to match Unicode characters and emojis
    final regex = RegExp(r'[^\x00-\x7F]');
    return text.replaceAll(regex, '');
  }

  static Future<void> saveAndLaunchFile(String text, String fileName) async {
    print('i was called ');
    //Create a new PDF document
    PdfDocument document = PdfDocument();
    //Add a page to the document
    PdfPage page = document.pages.add();
    //Draw text
    // document.pages.add().graphics.drawString(
    //     '$text', PdfStandardFont(PdfFontFamily.timesRoman, 14),
    //     brush: PdfBrushes.black, bounds: Rect.fromLTWH(0, 0, 0, 0));

    //Load the paragraph text into PdfTextElement with standard font
    String fineText = removeUnicodeAndEmojis(text);
    PdfTextElement textElement = PdfTextElement(
        text: '$fineText', font: PdfStandardFont(PdfFontFamily.helvetica, 12));

//Draw the paragraph text on page and maintain the position in PdfLayoutResult
    PdfLayoutResult layoutResult = textElement.draw(
        page: page,
        bounds: Rect.fromLTWH(
            0, 150, page.getClientSize().width, page.getClientSize().height))!;

//Assign header text to PdfTextElement
    textElement.text = '';
//PdfFont pdfFont = new PdfTrueTypeFont(GoogleFonts.lato() as List<int>, 24);
//Assign standard font to PdfTextElement
    textElement.font = PdfStandardFont(PdfFontFamily.timesRoman, 10,
        style: PdfFontStyle.regular);

//Draw the header text on page, below the paragraph text with a height gap of 20 and maintain the position in PdfLayoutResult
    layoutResult = textElement.draw(
        page: page,
        bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + 20, 0, 0))!;

    List<int> bytes = await document.save();
    AnchorElement(
        href:
            'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
      ..setAttribute('download', fileName)
      ..click();
    //Dispose the document
    document.dispose();
  }
}
