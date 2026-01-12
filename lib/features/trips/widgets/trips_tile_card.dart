import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone_assignment/core/constants/enums.dart';
import 'package:uber_clone_assignment/core/constants/ride_types.dart';
import 'package:uber_clone_assignment/core/utils/currency_utils.dart';
import 'package:uber_clone_assignment/core/utils/date_utils.dart';

import '../../../controllers/trip_provider.dart';
import '../../../data/models/trip_model.dart';
import '../../../core/constants/app_colors.dart';

class TripTile extends StatelessWidget {
  final TripModel trip;

  const TripTile({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(trip.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        context.read<TripProvider>().deleteTrip(trip.id);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Trip deleted')),
        );
      },
      child: ListTile(
        title: Text('${trip.pickup} → ${trip.drop}'),
       subtitle: Text(
          DateUtilsX.format(trip.createdAt),
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(CurrencyUtils.format(trip.fare)),
            Text(
              trip.status.label,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.statusColor(trip.status.label),
              ),
            ),
          ],
        ),

      ),
    );
  }
}
