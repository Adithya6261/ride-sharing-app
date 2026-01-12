import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../data/models/driver_model.dart';

class DriverTrackingService {
  static final _random = Random();

  static DriverModel createDriver({required LatLng start}) {
    return DriverModel(
      name: _randomDriverName(),
      latitude: start.latitude + 0.003,
      longitude: start.longitude + 0.003,
      etaMinutes: 6,
    );
  }

  /// Move driver TOWARDS destination
  static Timer trackTowards({
    required DriverModel driver,
    required LatLng destination,
    required VoidCallback onUpdate,
    required VoidCallback onArrived,
  }) {
    return Timer.periodic(const Duration(seconds: 2), (timer) {
      if (driver.etaMinutes <= 0) {
        timer.cancel();
        onArrived();
        return;
      }

      // Move closer to destination
      driver.latitude += (destination.latitude - driver.latitude) * 0.25;
      driver.longitude += (destination.longitude - driver.longitude) * 0.25;

      driver.etaMinutes -= 1;

      onUpdate();
    });
  }

  static String _randomDriverName() {
    const names = ['Ramesh', 'Suresh', 'Vikram', 'Amit', 'Rahul'];
    return names[_random.nextInt(names.length)];
  }
}
