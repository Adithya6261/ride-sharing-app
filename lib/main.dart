import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'data/local/hive_service.dart';
import 'services/notification_service.dart';

import 'controllers/trip_provider.dart';
import 'controllers/dashboard_provider.dart';
import 'controllers/budget_provider.dart';
import 'controllers/driver_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TripProvider(),
        ),
        ChangeNotifierProxyProvider<TripProvider, DashboardProvider>(
          create: (_) => DashboardProvider(),
          update: (_, tripProvider, dashboardProvider) {
            dashboardProvider!.updateTrips(tripProvider.trips);
            return dashboardProvider;
          },
        ),
        ChangeNotifierProvider(
          create: (_) => BudgetProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DriverProvider(),
        ),
      ],
      child: const RideSharingApp(),
    ),
  );
}
