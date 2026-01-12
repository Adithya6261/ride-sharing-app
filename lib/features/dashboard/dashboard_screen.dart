import 'package:flutter/material.dart';
import 'package:uber_clone_assignment/features/booking/booking_screen.dart';
import 'package:uber_clone_assignment/features/dashboard/widgets/stats_card.dart';
import 'package:uber_clone_assignment/features/trips/trips_screen.dart';
import 'widgets/recent_trips.dart';
import 'widgets/trips_chart.dart';
import 'widgets/book_ride_cta.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Good Evening'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TripsScreen(),
                ),
              );
            },
          ),
        ],
      ),

      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                StatsCards(),
                SizedBox(height: 24),
                TripsChart(),
                SizedBox(height: 24),
                RecentTrips(),
              ],
            ),
          ),

          /// 🔥 Uber-style persistent CTA
          Align(
            alignment: Alignment.bottomCenter,
            child: BookRideCTA(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const BookingScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
