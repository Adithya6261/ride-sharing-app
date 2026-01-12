import 'package:flutter/material.dart';

import '../core/constants/ride_types.dart';
import '../core/constants/enums.dart';
import '../data/models/budget_model.dart';
import '../data/models/trip_model.dart';
import '../data/repositories/budget_repository.dart';

class BudgetProvider extends ChangeNotifier {
  final BudgetRepository _repository = BudgetRepository();

  List<BudgetModel> get budgets => _repository.fetchBudgets();

  /// Set update monthly limit
  void setLimit(RideType type, double limit) {
    final existing = _repository.getByRideType(type);

    if (existing == null) {
      _repository.upsert(
        BudgetModel(
          rideType: type,
          monthlyLimit: limit,
          spentAmount: 0,
        ),
      );
    } else {
      existing.monthlyLimit = limit;
      _repository.upsert(existing);
    }

    notifyListeners();
  }

  /// Recalculate spending from completed trips
  void recalculateFromTrips(List<TripModel> trips) {
    for (final type in RideType.values) {
      final spent = trips
          .where((t) => t.rideType == type && t.status == TripStatus.completed)
          .fold<double>(0, (sum, t) => sum + t.fare);

      final existing = _repository.getByRideType(type);

      if (existing != null) {
        existing.spentAmount = spent;
        _repository.upsert(existing);
      }
    }

    notifyListeners();
  }
}
