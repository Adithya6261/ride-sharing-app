import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteUtils {
  /// Mock directions route
  static List<LatLng> generateRoute(
    LatLng from,
    LatLng to, {
    int steps = 30,
  }) {
    final List<LatLng> points = [];

    for (int i = 0; i <= steps; i++) {
      points.add(
        LatLng(
          from.latitude + (to.latitude - from.latitude) * (i / steps),
          from.longitude + (to.longitude - from.longitude) * (i / steps),
        ),
      );
    }

    return points;
  }
}
