// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherHiveAdapter extends TypeAdapter<WeatherHive> {
  @override
  final int typeId = 1;

  @override
  WeatherHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherHive(
      city: fields[0] as String,
      country: fields[1] as String,
      lat: fields[2] as String,
      lon: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.city)
      ..writeByte(1)
      ..write(obj.country)
      ..writeByte(2)
      ..write(obj.lat)
      ..writeByte(3)
      ..write(obj.lon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
