import 'package:uber_clone_assignment/data/local/hive_service.dart';
import 'package:uber_clone_assignment/data/models/trip_model.dart';

class TripRepository {
  List<TripModel> fetchTrips() {
    return HiveService.trips.values.toList();
  }

  void addTrip(TripModel trip) {
    HiveService.trips.put(trip.id, trip);
  }

  void deleteTrip(String id) {
    HiveService.trips.delete(id);
  }

  void updateTrip(TripModel trip) {
    trip.save();
  }
}
