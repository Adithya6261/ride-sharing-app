import 'package:hive/hive.dart';
import '../../core/constants/enums.dart';
import '../../core/constants/ride_types.dart';

part 'trip_model.g.dart';

@HiveType(typeId: 1)
class TripModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String pickup;

  @HiveField(2)
  final String drop;

  @HiveField(3)
  final RideType rideType;

  @HiveField(4)
  TripStatus status;

  @HiveField(5)
  double fare;

  @HiveField(6)
  final DateTime createdAt;

  @HiveField(7)
  int durationMinutes;

  TripModel({
    required this.id,
    required this.pickup,
    required this.drop,
    required this.rideType,
    required this.fare,
    required this.createdAt,
    this.status = TripStatus.requested,
    this.durationMinutes = 0,
  });
}
