import 'package:hive_flutter/hive_flutter.dart';
part 'weather_hive.g.dart';

@HiveType(typeId: 1)
class WeatherHive extends HiveObject {
  @HiveField(0)
  String city;

  @HiveField(1)
  String country;

  @HiveField(2)
  String lat;

  @HiveField(3)
  String lon;

  WeatherHive({this.city, this.country, this.lat, this.lon});
}
