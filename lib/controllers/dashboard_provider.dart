import 'package:flutter/material.dart';
import '../data/models/trip_model.dart';
import '../core/constants/enums.dart';
import '../core/constants/ride_types.dart';

class DashboardProvider extends ChangeNotifier {
  List<TripModel> _completedTrips = [];

  /// Called automatically by ProxyProvider
  void updateTrips(List<TripModel> allTrips) {
    _completedTrips = allTrips.where((t) => t.status == TripStatus.completed).toList();

    notifyListeners();
  }

  int get totalTrips => _completedTrips.length;

  double get totalSpent => _completedTrips.fold(0, (sum, t) => sum + t.fare);

  Map<RideType, int> get tripsByType {
    final map = <RideType, int>{};
    for (final type in RideType.values) {
      map[type] = _completedTrips.where((t) => t.rideType == type).length;
    }
    return map;
  }

  List<TripModel> get recentTrips => _completedTrips.reversed.take(5).toList();
}
