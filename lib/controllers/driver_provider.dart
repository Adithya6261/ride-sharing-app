import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../data/models/driver_model.dart';
import '../services/driver_tracking_service.dart';

class DriverProvider extends ChangeNotifier {
  DriverModel? driver;
  Timer? _timer;

  LatLng? _pickup;
  LatLng? _drop;

  /// Assign driver and start tracking
  void assignDriver({
    required LatLng pickup,
    required LatLng drop,
  }) {
    _pickup = pickup;
    _drop = drop;

    driver = DriverTrackingService.createDriver(start: pickup);

    _timer = DriverTrackingService.trackTowards(
      driver: driver!,
      destination: drop,
      onUpdate: notifyListeners,
      onArrived: _onDriverArrived,
    );

    notifyListeners();
  }

  void _onDriverArrived() {
    if (driver != null && _drop != null) {
      // SNAP DRIVER TO DROP
      driver!
        ..latitude = _drop!.latitude
        ..longitude = _drop!.longitude
        ..etaMinutes = 0;

      notifyListeners();
    }
  }

  void stopTracking() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    stopTracking();
    super.dispose();
  }
}
