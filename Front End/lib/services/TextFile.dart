import 'dart:convert';
import 'dart:html' as html;

import 'package:flutter/foundation.dart';

class TextFileGeneration {
  void generateAndDownloadFile(String textContent) {
    // Convert text content to bytes
    List<int> bytes = utf8.encode(textContent);

    // Create a Blob with the content and specify the MIME type
    final blob = html.Blob([Uint8List.fromList(bytes)], 'text/plain');

    // Create a download URL for the Blob
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create an anchor element and set its attributes
    final anchor = html.AnchorElement(href: url)
      ..target = 'blank'
      ..download = 'operify.txt';

    // Trigger a click on the anchor element to start the download
    html.document.body!.children.add(anchor);
    anchor.click();

    // Remove the anchor element from the body
    html.document.body!.children.remove(anchor);

    // Revoke the URL to free up resources
    html.Url.revokeObjectUrl(url);
  }
}
