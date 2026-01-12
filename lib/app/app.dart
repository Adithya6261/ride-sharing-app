import 'package:flutter/material.dart';
import '../services/notification_service.dart';
import 'theme.dart';
import '../features/dashboard/dashboard_screen.dart';

class RideSharingApp extends StatelessWidget {
  const RideSharingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ride Sharing App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      scaffoldMessengerKey: NotificationService.messengerKey,
      home: const DashboardScreen(),
    );
  }
}
