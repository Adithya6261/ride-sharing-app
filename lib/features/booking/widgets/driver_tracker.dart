import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/driver_provider.dart';

class DriverTracker extends StatelessWidget {
  const DriverTracker({super.key});

  @override
  Widget build(BuildContext context) {
    final driver = context.watch<DriverProvider>().driver;

    if (driver == null) {
      return const SizedBox();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Driver: ${driver.name}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            'ETA: ${driver.etaMinutes} mins',
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
