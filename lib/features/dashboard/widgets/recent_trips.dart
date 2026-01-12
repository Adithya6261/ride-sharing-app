import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone_assignment/core/constants/ride_types.dart';

import '../../../controllers/dashboard_provider.dart';
import '../../../core/widgets/section_title.dart';

class RecentTrips extends StatelessWidget {
  const RecentTrips({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboard = context.watch<DashboardProvider>(); // ✅
    final trips = dashboard.recentTrips;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Recent trips'),
        const SizedBox(height: 8),
        if (trips.isEmpty)
          const Text(
            'No trips yet',
            style: TextStyle(color: Colors.grey),
          ),
        ...trips.map(
          (t) => ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('${t.pickup} → ${t.drop}'),
            subtitle: Text(t.rideType.label),
            trailing: Text('₹${t.fare.toStringAsFixed(0)}'),
          ),
        ),
      ],
    );
  }
}
