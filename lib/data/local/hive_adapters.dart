import 'package:hive/hive.dart';
import '../../core/constants/enums.dart';
import '../../core/constants/ride_types.dart';

class RideTypeAdapter extends TypeAdapter<RideType> {
  @override
  final typeId = 10;

  @override
  RideType read(BinaryReader reader) {
    return RideType.values[reader.readInt()];
  }

  @override
  void write(BinaryWriter writer, RideType obj) {
    writer.writeInt(obj.index);
  }
}

class TripStatusAdapter extends TypeAdapter<TripStatus> {
  @override
  final typeId = 11;

  @override
  TripStatus read(BinaryReader reader) {
    return TripStatus.values[reader.readInt()];
  }

  @override
  void write(BinaryWriter writer, TripStatus obj) {
    writer.writeInt(obj.index);
  }
}
