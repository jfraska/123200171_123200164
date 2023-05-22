// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherHiveModelAdapter extends TypeAdapter<WeatherHiveModel> {
  @override
  final int typeId = 1;

  @override
  WeatherHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherHiveModel(
      city: fields[0] as String,
      country: fields[1] as String,
      lat: fields[2] as String,
      lon: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherHiveModel obj) {
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
      other is WeatherHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
