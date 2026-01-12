import 'package:flutter/material.dart';

class NotificationService {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static void notify(String message) {
    messengerKey.currentState?.showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
