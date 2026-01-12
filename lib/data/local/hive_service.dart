import 'package:hive_flutter/hive_flutter.dart';
import '../models/trip_model.dart';
import '../models/budget_model.dart';
import '../models/driver_model.dart';
import 'hive_adapters.dart';

class HiveService {
  static const tripBox = 'trips';
  static const budgetBox = 'budgets';

  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(RideTypeAdapter());
    Hive.registerAdapter(TripStatusAdapter());
    Hive.registerAdapter(TripModelAdapter());
    Hive.registerAdapter(DriverModelAdapter());
    Hive.registerAdapter(BudgetModelAdapter());

    await Hive.openBox<TripModel>(tripBox);
    await Hive.openBox<BudgetModel>(budgetBox);
  }

  static Box<TripModel> get trips => Hive.box<TripModel>(tripBox);

  static Box<BudgetModel> get budgets => Hive.box<BudgetModel>(budgetBox);
}
