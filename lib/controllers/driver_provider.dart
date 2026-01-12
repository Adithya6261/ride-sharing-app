import 'dart:async';
import 'package:flutter/material.dart';

import '../data/models/driver_model.dart';
import '../services/driver_tracking_service.dart';

class DriverProvider extends ChangeNotifier {
  DriverModel? driver;
  Timer? _timer;

  /// Assign and start tracking driver
  void assignDriver() {
    driver = DriverTrackingService.createDriver();

    _timer = DriverTrackingService.track(
      driver!,
      onUpdate: notifyListeners,
    );

    notifyListeners();
  }

  void stopTracking() {
    _timer?.cancel();
    driver = null;
    notifyListeners();
  }
}
