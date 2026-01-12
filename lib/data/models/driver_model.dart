import 'package:hive/hive.dart';

part 'driver_model.g.dart';

@HiveType(typeId: 2)
class DriverModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  double latitude;

  @HiveField(2)
  double longitude;

  @HiveField(3)
  int etaMinutes;

  DriverModel({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.etaMinutes,
  });
}
