import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/dashboard_provider.dart';
import '../../../core/widgets/info_card.dart';
import '../../../core/utils/currency_utils.dart';

class StatsCards extends StatelessWidget {
  const StatsCards({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboard = context.watch<DashboardProvider>(); // ✅ LISTENING

    return Row(
      children: [
        Expanded(
          child: InfoCard(
            title: 'Trips',
            value: dashboard.totalTrips.toString(),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: InfoCard(
            title: 'Spent',
            value: CurrencyUtils.format(dashboard.totalSpent),
          ),
        ),
      ],
    );
  }
}
