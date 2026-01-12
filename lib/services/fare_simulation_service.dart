import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import '../data/models/trip_model.dart';
import '../core/constants/enums.dart';

class FareSimulationService {
  static void simulate({
    required TripModel trip,
    required VoidCallback onUpdate,
  }) {
    final random = Random();

    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (trip.status == TripStatus.completed || trip.status == TripStatus.cancelled) {
        timer.cancel();
        return;
      }

      final surge = 1 + random.nextDouble();
      trip.durationMinutes += 1;
      trip.fare += surge;

      trip.save();
      onUpdate();
    });
  }
}
