import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF000000);
  static const secondary = Color(0xFF1DB954);

  static const success = Colors.green;
  static const warning = Colors.orange;
  static const danger = Colors.red;

  static Color statusColor(String status) {
    switch (status) {
      case 'Completed':
        return success;
      case 'Ride Started':
        return secondary;
      case 'Driver Assigned':
        return Colors.blue;
      case 'Cancelled':
        return danger;
      default:
        return Colors.grey;
    }
  }
}
