class ReportResponse {
  final String message;
  final String generatedReport;

  ReportResponse({
    required this.message,
    required this.generatedReport,
  });

  factory ReportResponse.fromJson(Map<String, dynamic> json) {
    return ReportResponse(
      message: json['message'],
      generatedReport: json['reportResponse'],
    );
  }
}
