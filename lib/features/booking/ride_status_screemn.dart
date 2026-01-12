import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone_assignment/core/constants/enums.dart';

import '../../controllers/trip_provider.dart';
import '../../controllers/driver_provider.dart';

class RideStatusScreen extends StatefulWidget {
  const RideStatusScreen({super.key});

  @override
  State<RideStatusScreen> createState() => _RideStatusScreenState();
}

class _RideStatusScreenState extends State<RideStatusScreen> {
  GoogleMapController? _mapController;

  /// Temporary mock coordinates
  static const LatLng pickup = LatLng(17.3850, 78.4867);
  static const LatLng drop = LatLng(17.3950, 78.4967);

  @override
  Widget build(BuildContext context) {
    final trip = context.watch<TripProvider>().activeTrip;
    final driver = context.watch<DriverProvider>().driver;

    final markers = <Marker>{
      const Marker(
        markerId: MarkerId('pickup'),
        position: pickup,
      ),
      const Marker(
        markerId: MarkerId('drop'),
        position: drop,
      ),
      if (driver != null)
        Marker(
          markerId: const MarkerId('driver'),
          position: LatLng(driver.latitude, driver.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueAzure,
          ),
        ),
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Your Ride')),
      body: Column(
        children: [
          /// 🗺️ MAP
          Expanded(
            flex: 3,
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: pickup,
                zoom: 14,
              ),
              markers: markers,
              polylines: {
                Polyline(
                  polylineId: PolylineId('route'),
                  points: [pickup, drop],
                  color: Colors.blue,
                  width: 5,
                ),
              },
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              onMapCreated: (c) => _mapController = c,
            ),
          ),

          ///  STATUS PANEL
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trip!.status.label,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (driver != null)
                    Text(
                      'Driver ${driver.name} • ETA ${driver.etaMinutes} mins',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  const SizedBox(height: 16),
                  Text(
                    'Fare: ₹${trip.fare.toStringAsFixed(0)}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    context.read<DriverProvider>().stopTracking();
    _mapController?.dispose();
    super.dispose();
  }
}
