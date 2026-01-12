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

  String? _activeTripId;

  /// 🔹 All trips (for dashboard & history)
  List<TripModel> get trips => _repository.fetchTrips().reversed.toList();

  /// 🔹 ONLY active trip (for RideStatusScreen)
  TripModel? get activeTrip {
    if (_activeTripId == null) return null;

    return trips.firstWhere(
      (t) => t.id == _activeTripId,
      orElse: () => trips.first,
    );
  }

  /// 🔹 Create trip + start simulations
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

    _activeTripId = trip.id;

    /// Ride lifecycle
    RideSimulationService.simulate(
      trip: trip,
      onUpdate: notifyListeners,
    );

    /// Live fare
    FareSimulationService.simulate(
      trip: trip,
      onUpdate: notifyListeners,
    );

    notifyListeners();
  }

  /// 🔹 Clear active trip after completion
  void clearActiveTrip() {
    _activeTripId = null;
    notifyListeners();
  }

  /// 🔹 Delete trip (history)
  void deleteTrip(String id) {
    if (_activeTripId == id) {
      _activeTripId = null;
    }

    _repository.deleteTrip(id);
    notifyListeners();
  }
}
