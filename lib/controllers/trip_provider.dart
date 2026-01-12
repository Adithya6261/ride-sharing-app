import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../core/constants/enums.dart';
import '../core/constants/ride_types.dart';
import '../data/models/trip_model.dart';
import '../data/repositories/trip_repository.dart';
import '../services/ride_simulation_service.dart';
import '../services/fare_simulation_service.dart';

class TripProvider extends ChangeNotifier {
  final TripRepository _repository = TripRepository();
  final Uuid _uuid = const Uuid();

  /// 🔹 UI reads trips ONLY from provider
  List<TripModel> get trips => _repository.fetchTrips().reversed.toList();

  /// 🔹 Booking → create trip → start simulations
  void addTrip({
    required String pickup,
    required String drop,
    required RideType rideType,
  }) {
    final trip = TripModel(
      id: _uuid.v4(),
      pickup: pickup,
      drop: drop,
      rideType: rideType,
      fare: rideType.baseFare,
      createdAt: DateTime.now(),
    );

    _repository.addTrip(trip);

    /// Ride lifecycle simulation
    RideSimulationService.simulate(
      trip: trip,
      onUpdate: notifyListeners,
    );

    /// Live fare updates
    FareSimulationService.simulate(
      trip: trip,
      onUpdate: notifyListeners,
    );

    notifyListeners();
  }

  void startStatusFlow(TripModel trip) {
    Future.delayed(const Duration(seconds: 2), () {
      trip.status = TripStatus.driverAssigned;
      notifyListeners();
    });

    Future.delayed(const Duration(seconds: 6), () {
      trip.status = TripStatus.rideStarted;
      notifyListeners();
    });

    Future.delayed(const Duration(seconds: 18), () {
      trip.status = TripStatus.completed;
      notifyListeners();
    });
  }


  /// 🔹 Used by TripsScreen (swipe delete)
  void deleteTrip(String id) {
    _repository.deleteTrip(id);
    notifyListeners();
  }
}
