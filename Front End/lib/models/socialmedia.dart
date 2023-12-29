// social_media_request.dart

import 'dart:convert';

class SocialMediaRequest {
  final String selectedPlatform;
  final String contentIdeas;
  final String captionsText;
  final String responseGeneration;
  final String? timeframe;
  final String? frequency;
  final String? type;
  final String? themes;

  SocialMediaRequest({
    required this.selectedPlatform,
    required this.contentIdeas,
    required this.captionsText,
    required this.responseGeneration,
    required this.timeframe,
    required this.frequency,
    required this.type,
    required this.themes,
  });

  Map<String, dynamic> toJson() {
    return {
      'selectedPlatform': selectedPlatform,
      'contentIdeas': contentIdeas,
      'captionsText': captionsText,
      'responseGeneration': responseGeneration,
      'timeframe': timeframe,
      'frequency': frequency,
      'type': type,
      'themes': themes,
    };
  }

  factory SocialMediaRequest.fromJson(Map<String, dynamic> json) {
    return SocialMediaRequest(
      selectedPlatform: json['selectedPlatform'],
      contentIdeas: json['contentIdeas'],
      captionsText: json['captionsText'],
      responseGeneration: json['responseGeneration'],
      timeframe: json['timeframe'],
      frequency: json['frequency'],
      type: json['type'],
      themes: json['themes'],
    );
  }

  String toJsonString() => jsonEncode(toJson());
}
