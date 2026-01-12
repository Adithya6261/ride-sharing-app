import 'dart:async';
import 'package:flutter/material.dart';

import '../data/models/trip_model.dart';
import '../core/constants/enums.dart';
import 'notification_service.dart';

class RideSimulationService {
  static void simulate({
    required TripModel trip,
    required VoidCallback onUpdate,
  }) {
    Timer(const Duration(seconds: 3), () {
      trip.status = TripStatus.driverAssigned;
      trip.save();
      NotificationService.notify('Driver assigned');
      onUpdate();
    });

    Timer(const Duration(seconds: 7), () {
      trip.status = TripStatus.rideStarted;
      trip.save();
      NotificationService.notify('Ride started');
      onUpdate();
    });

    Timer(const Duration(seconds: 15), () {
      trip.status = TripStatus.completed;
      trip.save();
      NotificationService.notify('Ride completed');
      onUpdate();
    });
  }
}
