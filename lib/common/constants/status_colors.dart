import 'package:flutter/material.dart';

class StatusColors {
  static const Map<String, Color> _statusColorMap = {
    "APPROVE": Colors.green,
    "PENDING": Colors.orange,
    "REJECTED": Colors.red,
    "DRAFT": Colors.black,
    "EXPIRED": Colors.red,
  };

  static Color getColor(String status) {
    return _statusColorMap[status] ?? Colors.black; 
  }
}
