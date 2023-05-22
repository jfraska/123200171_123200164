import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather/api/api_data_source.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/screens/navigasi.dart';

class LoadingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadingPageState();
  }
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Weather weatherData =
        Weather.fromJson(await ApiDataSource.instance.getLocationWeather());

    print(weatherData);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Navigasi(weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingFour(
          color: Colors.white,
          size: 25.0,
        ),
      ),
    );
  }
}
