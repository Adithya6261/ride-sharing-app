import 'package:hive/hive.dart';
import '../../core/constants/ride_types.dart';

part 'budget_model.g.dart';

@HiveType(typeId: 3)
class BudgetModel extends HiveObject {
  @HiveField(0)
  final RideType rideType;

  @HiveField(1)
  double monthlyLimit;

  @HiveField(2)
  double spentAmount;

  BudgetModel({
    required this.rideType,
    required this.monthlyLimit,
    this.spentAmount = 0,
  });

  bool get isOverLimit => spentAmount > monthlyLimit;

  double get usagePercent => monthlyLimit == 0 ? 0 : (spentAmount / monthlyLimit);
}
