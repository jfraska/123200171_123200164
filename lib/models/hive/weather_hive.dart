import 'package:hive_flutter/hive_flutter.dart';
part 'weather_hive.g.dart';

@HiveType(typeId: 1)
class WeatherHive extends HiveObject {
  @HiveField(0)
  String city;

  @HiveField(1)
  String desc;

  @HiveField(2)
  double lat;

  @HiveField(3)
  double lon;

  WeatherHive({this.city, this.desc, this.lat, this.lon});
}
