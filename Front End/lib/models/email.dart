class EmailModel {
  final String object;
  final String typeOfEmail;
  final String emailTo;
  final String emailFrom;
  final String length;
  final String emailContent;

  EmailModel({
    required this.object,
    required this.typeOfEmail,
    required this.emailTo,
    required this.emailFrom,
    required this.length,
    required this.emailContent,
  });

  factory EmailModel.fromJson(Map<String, dynamic> json) {
    return EmailModel(
      object: json['object'],
      typeOfEmail: json['typeOfEmail'],
      emailTo: json['emailTo'],
      emailFrom: json['emailFrom'],
      length: json['length'],
      emailContent: json['emailContent'],
    );
  }
}
