

import 'package:flutter/material.dart';

class InvoiceBalanceProvider with ChangeNotifier {
  String _partsTotal = '0.00';
  String _serviceTotal = '0.00';
  String _service75Percent = '0.00';
  String _service25Percent = '0.00';

  String get partsTotal => _partsTotal;
  String get serviceTotal => _serviceTotal;
  String get service75Percent => _service75Percent;
  String get service25Percent => _service25Percent;
  void setPartsTotal(String value) {
    _partsTotal = value;

    // Schedule notifyListeners() in the next microtask
    Future.microtask(() {
      notifyListeners();
    });
  }

  void setServiceTotals(String total, String perc75, String perc25) {
    _serviceTotal = total;
    _service75Percent = perc75;
    _service25Percent = perc25;

    // Schedule notifyListeners() in the next microtask
    Future.microtask(() {
      notifyListeners();
    });
  }
}
