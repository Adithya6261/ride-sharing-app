import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/budget_provider.dart';
import '../../controllers/trip_provider.dart';
import '../../core/constants/ride_types.dart';
import 'widgets/budget_card.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
   final tripProvider = context.watch<TripProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BudgetProvider>().recalculateFromTrips(tripProvider.trips);
    });


    return Scaffold(
      appBar: AppBar(title: const Text('Budgets')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: RideType.values.map((type) {
          return BudgetCard(rideType: type);
        }).toList(),
      ),
    );
  }
}
