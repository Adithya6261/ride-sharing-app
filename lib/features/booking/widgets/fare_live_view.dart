import 'package:flutter/material.dart';
import '../../../core/constants/ride_types.dart';

class FareLiveView extends StatelessWidget {
  final RideType rideType;
  final double? distanceKm;

  const FareLiveView({
    super.key,
    required this.rideType,
    required this.distanceKm,
  });

  double _calculateFare() {
    if (distanceKm == null) return rideType.baseFare;

    // per km rates (Uber-like)
    final perKmRate = switch (rideType) {
      RideType.mini => 10.0,
      RideType.sedan => 14.0,
      RideType.auto => 8.0,
      RideType.bike => 6.0,
    };

    // simulated surge (can be dynamic later)
    final surgeMultiplier = 1.2;

    final fare = rideType.baseFare + (distanceKm! * perKmRate * surgeMultiplier);

    return fare;
  }

  @override
  Widget build(BuildContext context) {
    final fare = _calculateFare();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.currency_rupee, color: Colors.greenAccent),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Estimated Fare',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                '₹${fare.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (distanceKm != null)
                Text(
                  '${distanceKm!.toStringAsFixed(1)} km',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
