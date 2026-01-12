enum RideType { mini, sedan, auto, bike }

extension Ridetypes on RideType {
  String get label {
    switch (this) {
      case RideType.mini:
        return 'Mini';
      case RideType.sedan:
        return 'Sedan';
      case RideType.auto:
        return 'Auto';
      case RideType.bike:
        return 'Bike';
    }
  }

  double get baseFare {
    switch (this) {
      case RideType.mini:
        return 8;
      case RideType.sedan:
        return 12;
      case RideType.auto:
        return 6;
      case RideType.bike:
        return 4;
    }
  }
}
