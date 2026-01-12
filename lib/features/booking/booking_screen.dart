import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../controllers/trip_provider.dart';
import '../../controllers/driver_provider.dart';
import '../../core/constants/ride_types.dart';
import '../../core/utils/distance_utils.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';
import 'ride_status_screemn.dart';
import 'widgets/ride_type_selector.dart';
import 'widgets/fare_live_view.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final pickupCtrl = TextEditingController();
  final dropCtrl = TextEditingController();

  RideType selectedType = RideType.mini;

  GoogleMapController? _mapController;
  Timer? _debounce;

  LatLng? _pickupLatLng;
  LatLng? _dropLatLng;

  double? _distanceKm;

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(17.3850, 78.4867),
    zoom: 14,
  );

  bool get _isFormValid => pickupCtrl.text.isNotEmpty && dropCtrl.text.isNotEmpty && _distanceKm != null;

  @override
  void dispose() {
    pickupCtrl.dispose();
    dropCtrl.dispose();
    _mapController?.dispose();
    _debounce?.cancel();
    super.dispose();
  }

void _onSearchChanged(String value, {required bool isPickup}) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 700), () {
      _searchAndUpdateMap(value, isPickup: isPickup);
    });
  }


  /// 🔍 Geocode → marker → polyline → distance
  Future<void> _searchAndUpdateMap(
    String address, {
    required bool isPickup,
  }) async {
    if (address.length < 3) return;

    try {
      final locations = await locationFromAddress(address);
      if (locations.isEmpty) return;

      final pos = LatLng(
        locations.first.latitude,
        locations.first.longitude,
      );

      setState(() {
        if (isPickup) {
          _pickupLatLng = pos;
        } else {
          _dropLatLng = pos;
        }

        _markers.removeWhere(
          (m) => m.markerId.value == (isPickup ? 'pickup' : 'drop'),
        );

        _markers.add(
          Marker(
            markerId: MarkerId(isPickup ? 'pickup' : 'drop'),
            position: pos,
          ),
        );

        _updatePolylineAndDistance();
      });

      await _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(pos, 15),
      );
    } catch (e) {
      debugPrint('Geocoding error: $e');
    }
  }

  /// 🧮 Distance + polyline
  void _updatePolylineAndDistance() {
    if (_pickupLatLng == null || _dropLatLng == null) return;

    _distanceKm = DistanceUtils.calculateKm(
      lat1: _pickupLatLng!.latitude,
      lon1: _pickupLatLng!.longitude,
      lat2: _dropLatLng!.latitude,
      lon2: _dropLatLng!.longitude,
    );

    _polylines.clear();
    _polylines.add(
      Polyline(
        polylineId: const PolylineId('route'),
        points: [_pickupLatLng!, _dropLatLng!],
        color: Colors.blueAccent,
        width: 5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🗺️ MAP
          GoogleMap(
            initialCameraPosition: _initialCameraPosition,
            markers: _markers,
            polylines: _polylines,
            zoomControlsEnabled: false,
            onMapCreated: (c) => _mapController = c,
          ),

          /// ⬆️ BOTTOM SHEET
          DraggableScrollableSheet(
            initialChildSize: 0.45,
            minChildSize: 0.35,
            maxChildSize: 0.85,
            builder: (_, controller) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: ListView(
                  controller: controller,
                  children: [
                    AppTextField(
                      controller: pickupCtrl,
                      hint: 'Pickup location',
                      icon: Icons.my_location,
                      onChanged: (v) => _onSearchChanged(v, isPickup: true),
                    ),
                    const SizedBox(height: 12),
                    AppTextField(
                      controller: dropCtrl,
                      hint: 'Where to?',
                      icon: Icons.location_on,
                      onChanged: (v) => _onSearchChanged(v, isPickup: false),
                    ),
                    const SizedBox(height: 20),
                    RideTypeSelector(
                      selected: selectedType,
                      onChanged: (t) => setState(() => selectedType = t),
                    ),
                    const SizedBox(height: 16),

                    /// 💰 LIVE FARE
                    FareLiveView(
                      rideType: selectedType,
                      distanceKm: _distanceKm,
                    ),

                    const SizedBox(height: 24),
                    AppButton(
                      label: 'Confirm Ride',
                      onTap: _isFormValid ? _confirmRide : null,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _confirmRide() {
    context.read<TripProvider>().addTrip(
          pickup: pickupCtrl.text,
          drop: dropCtrl.text,
          rideType: selectedType,
        );

    context.read<DriverProvider>().assignDriver();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const RideStatusScreen()),
    );
  }
}
