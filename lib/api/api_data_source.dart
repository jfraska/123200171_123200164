import 'package:weather/api/location.dart';
import 'base_network.dart';

final String apiKey = "15d599b59a580618222470452af27f66";

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> getForecast(double lat, double lon) {
    return BaseNetwork.get(
        '/3.0/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric');
  }

  Future<Map<String, dynamic>> getCurrentWeather(String city) {
    return BaseNetwork.get('/2.5/weather?q=$city&appid=$apiKey&units=metric');
  }

  Future<Map<String, dynamic>> getWeather(
      double latitude, double longitude) async {
    return BaseNetwork.get(
        '/2.5/weather?lat=${latitude}&lon=${longitude}&appid=$apiKey&units=metric');
  }

  Future<Map<String, dynamic>> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    return BaseNetwork.get(
        '/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
  }
}
