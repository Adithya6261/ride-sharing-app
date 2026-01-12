import '../local/hive_service.dart';
import '../models/budget_model.dart';
import '../../core/constants/ride_types.dart';

class BudgetRepository {
  /// Get all budgets
  List<BudgetModel> fetchBudgets() {
    return HiveService.budgets.values.toList();
  }

  /// Get budget by ride type
  BudgetModel? getByRideType(RideType type) {
    try {
      return HiveService.budgets.values.firstWhere((b) => b.rideType == type);
    } catch (_) {
      return null;
    }
  }

  /// Create or update budget
  void upsert(BudgetModel budget) {
    if (budget.isInBox) {
      budget.save();
    } else {
      HiveService.budgets.add(budget);
    }
  }
}
  