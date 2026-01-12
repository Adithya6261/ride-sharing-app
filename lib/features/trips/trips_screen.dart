import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone_assignment/features/trips/widgets/trips_tile_card.dart';

import '../../controllers/trip_provider.dart';
import '../../core/widgets/empty_state.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final trips = context.watch<TripProvider>().trips;

    return Scaffold(
      appBar: AppBar(title: const Text('Your Trips')),
      body: trips.isEmpty
          ? const EmptyState(
              title: 'No trips yet',
              subtitle: 'Book a ride to see it here',
            )
          : ListView.builder(
              itemCount: trips.length,
              itemBuilder: (_, i) {
                return TripTile(trip: trips[i]);
              },
            ),
    );
  }
}
