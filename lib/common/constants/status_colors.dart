import 'package:flutter/material.dart';

class StatusColors {
  static const Map<String, Color> _statusColorMap = {
    "APPROVE": Colors.green,
    "APPROVED": Colors.green,
    "COMPLETED": Colors.green,
    "CANCELLED": Colors.red,
    "PENDING": Colors.orange,
    "REJECTED": Colors.red,
    "DRAFT": Colors.black,
    "EXPIRED": Colors.red,
    "PROFESSIONAL": Colors.blue,
    "GUEST": Colors.black,
    "PAID": Colors.green,
    "NOT_APPLICABLE": Colors.orange
  };

  static Color getColor(String status) {
    return _statusColorMap[status] ?? Colors.black;
  }
}
