import 'package:flutter/foundation.dart';
import 'package:my_app/services/reportService.dart';

class ReportProvider extends ChangeNotifier {
   ReportService reportService = ReportService();
   bool _isProcessing = false;

  bool get isReportProcessing => _isProcessing;

  void startProcessing() {
    _isProcessing = true;
    notifyListeners();
  }

  void stopProcessing() {
    _isProcessing = false;
    notifyListeners();
  }
}