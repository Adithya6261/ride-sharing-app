import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import '../data/models/driver_model.dart';

class DriverTrackingService {
  static final Random _random = Random();

  /// Create mock driver near Hyderabad
  static DriverModel createDriver({
    double baseLat = 17.3850,
    double baseLng = 78.4867,
  }) {
    return DriverModel(
      name: _randomDriverName(),
      latitude: baseLat + (_random.nextDouble() - 0.5) / 100,
      longitude: baseLng + (_random.nextDouble() - 0.5) / 100,
      etaMinutes: 6 + _random.nextInt(5), // 6–10 mins
    );
  }

  /// Track driver movement (Uber-style mock)
  static Timer track(
    DriverModel driver, {
    required VoidCallback onUpdate,
  }) {
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if (driver.etaMinutes <= 0) {
        timer.cancel();
        return;
      }

      // Simulated movement (small deltas)
      driver.latitude += (_random.nextDouble() - 0.5) / 1000;
      driver.longitude += (_random.nextDouble() - 0.5) / 1000;

      // Decrease ETA
      driver.etaMinutes -= 1;

      onUpdate();
    });
  }

  static String _randomDriverName() {
    const names = [
      'Ramesh',
      'Suresh',
      'Vikram',
      'Amit',
      'Rahul',
      'Kiran',
      'Manoj',
    ];
    return names[_random.nextInt(names.length)];
  }
}
