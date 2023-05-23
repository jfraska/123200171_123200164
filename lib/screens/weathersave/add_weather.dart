import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/api/api_data_source.dart';
import 'package:weather/models/hive/boxes.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/models/hive/weather_hive.dart';

class AddWeather extends StatefulWidget {
  const AddWeather({Key key}) : super(key: key);

  @override
  State<AddWeather> createState() => _AddWeatherState();
}

class _AddWeatherState extends State<AddWeather> {
  String cityName;

  Box<WeatherHive> _myBox;

  @override
  void initState() {
    super.initState();
    _myBox = Hive.box<WeatherHive>(HiveBoxex.weather);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        padding: EdgeInsets.only(left: 32, right: 32),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            TextField(
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(
                  Icons.place,
                  color: Colors.grey,
                ),
                hintText: 'City Name',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                cityName = value;
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 40.0,
              width: double.infinity,
              child: FlatButton(
                color: Colors.blue[400],
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                onPressed: () async {
                  Weather weatherData = Weather.fromJson(
                      await ApiDataSource.instance.getCurrentWeather(cityName));

                  if (weatherData != null) {
                    _myBox.add(WeatherHive(
                      city: weatherData.name,
                      desc: weatherData.description,
                      lat: weatherData.lat,
                      lon: weatherData.lon,
                    ));
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        highlightColor: Colors.transparent,
        splashRadius: 27.5,
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
