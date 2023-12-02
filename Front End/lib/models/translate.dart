class TranslationResponse {
  final String message;
  final String translatedText;

  TranslationResponse({
    required this.message,
    required this.translatedText,
  });

  factory TranslationResponse.fromJson(Map<String, dynamic> json) {
    return TranslationResponse(
      message: json['message'],
      translatedText: json['translatedText'],
    );
  }
}
