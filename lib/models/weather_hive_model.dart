import 'package:hive_flutter/hive_flutter.dart';
part 'weather_hive_model.g.dart';

@HiveType(typeId: 1)
class WeatherHiveModel extends HiveObject {
  @HiveField(0)
  String city;

  @HiveField(1)
  String country;

  @HiveField(2)
  String lat;

  @HiveField(3)
  String lon;

  WeatherHiveModel({this.city, this.country, this.lat, this.lon});
}
