import 'package:flutter/material.dart';
import 'package:weather/models/forcast.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/screens/search_screen.dart';
import '../extensions.dart';
import 'package:intl/intl.dart';
import 'package:weather/api/api_data_source.dart';

class WeatherPage extends StatefulWidget {
  Weather locationWeather;
  WeatherPage(this.locationWeather);

  @override
  State<WeatherPage> createState() => _WeatherPageState(this.locationWeather);
}

class _WeatherPageState extends State<WeatherPage> {
  Weather locationWeather;
  _WeatherPageState(Weather locationWeather)
      : this.locationWeather = locationWeather;

  @override
  void initState() {
    super.initState();

    _changeLocation(locationWeather);
  }

  @override
  Widget build(BuildContext context) {
    print(this.locationWeather);
    return Scaffold(
      appBar: buildAppBar(this.locationWeather.name),
      body: ListView(children: <Widget>[
        currentWeatherViews(this.locationWeather),
        forcastViewsHourly(this.locationWeather),
        forcastViewsDaily(this.locationWeather),
      ]),
    );
  }

  void _changeLocation(Weather newLocation) {
    setState(() {
      locationWeather = newLocation;
    });
  }

  Widget currentWeatherViews(Weather location) {
    Weather _weather;

    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          _weather = Weather.fromJson(snapshot.data);
          if (_weather == null) {
            return Text("Error getting weather");
          } else {
            return Column(children: [
              // createAppBar(locations, location, context),
              weatherBox(_weather),
              weatherDetailsBox(_weather),
            ]);
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
      future: ApiDataSource.instance.getWeather(location.lat, location.lon),
    );
  }

  Widget forcastViewsHourly(Weather location) {
    Forecast _forcast;

    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          _forcast = Forecast.fromJson(snapshot.data);
          if (_forcast == null) {
            return Text("Error getting weather");
          } else {
            return hourlyBoxes(_forcast);
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
      future: ApiDataSource.instance.getForecast(location.lat, location.lon),
    );
  }

  Widget forcastViewsDaily(Weather location) {
    Forecast _forcast;

    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          _forcast = Forecast.fromJson(snapshot.data);
          if (_forcast == null) {
            return Text("Error getting weather");
          } else {
            return dailyBoxes(_forcast);
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
      future: ApiDataSource.instance.getForecast(location.lat, location.lon),
    );
  }

  // Widget createAppBar(
  //     List<Location> locations, Location location, BuildContext context) {
  //   // Location dropdownValue = locations.first;
  //   return Container(
  //       padding:
  //           const EdgeInsets.only(left: 20, top: 15, bottom: 15, right: 20),
  //       margin: const EdgeInsets.only(
  //           top: 35, left: 15.0, bottom: 15.0, right: 15.0),
  //       decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.all(Radius.circular(60)),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.grey.withOpacity(0.1),
  //               spreadRadius: 5,
  //               blurRadius: 7,
  //               offset: Offset(0, 3),
  //             )
  //           ]),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           DropdownButton<Location>(
  //             value: location,
  //             icon: Icon(
  //               Icons.keyboard_arrow_down_rounded,
  //               color: Colors.black,
  //               size: 24.0,
  //               semanticLabel: 'Tap to change location',
  //             ),
  //             elevation: 16,
  //             underline: Container(
  //               height: 0,
  //               color: Colors.deepPurpleAccent,
  //             ),
  //             onChanged: (Location newLocation) {
  //               // callback(newValue);
  //               // setState(() {
  //               //   location = newValue;
  //               // });
  //               _changeLocation(newLocation);
  //             },
  //             items:
  //                 locations.map<DropdownMenuItem<Location>>((Location value) {
  //               return DropdownMenuItem<Location>(
  //                 value: value,
  //                 child: Text.rich(
  //                   TextSpan(
  //                     children: <TextSpan>[
  //                       TextSpan(
  //                           text: '${value.city.capitalizeFirstOfEach}, ',
  //                           style: TextStyle(
  //                               fontWeight: FontWeight.bold, fontSize: 16)),
  //                       TextSpan(
  //                           text: '${value.country.capitalizeFirstOfEach}',
  //                           style: TextStyle(
  //                               fontWeight: FontWeight.normal, fontSize: 16)),
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             }).toList(),
  //           ),
  //         ],
  //       ));
  // }

  Widget weatherDetailsBox(Weather _weather) {
    return Container(
      padding: const EdgeInsets.only(left: 15, top: 25, bottom: 25, right: 15),
      margin: const EdgeInsets.only(left: 15, top: 5, bottom: 15, right: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ]),
      child: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              Container(
                  child: Text(
                "Wind",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.grey),
              )),
              Container(
                  child: Text(
                "${_weather.wind} km/h",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.black),
              ))
            ],
          )),
          Expanded(
              child: Column(
            children: [
              Container(
                  child: Text(
                "Humidity",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.grey),
              )),
              Container(
                  child: Text(
                "${_weather.humidity.toInt()}%",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.black),
              ))
            ],
          )),
          Expanded(
              child: Column(
            children: [
              Container(
                  child: Text(
                "Pressure",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.grey),
              )),
              Container(
                  child: Text(
                "${_weather.pressure} hPa",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.black),
              ))
            ],
          ))
        ],
      ),
    );
  }

  Widget weatherBox(Weather _weather) {
    return Stack(children: [
      Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.all(15.0),
        height: 160.0,
        decoration: BoxDecoration(
            color: Colors.indigoAccent,
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
      ClipPath(
          clipper: Clipper(),
          child: Container(
              padding: const EdgeInsets.all(15.0),
              margin: const EdgeInsets.all(15.0),
              height: 160.0,
              decoration: BoxDecoration(
                  color: Colors.indigoAccent[400],
                  borderRadius: BorderRadius.all(Radius.circular(20))))),
      Container(
          padding: const EdgeInsets.all(15.0),
          margin: const EdgeInsets.all(15.0),
          height: 160.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                    getWeatherIcon(_weather.icon),
                    Container(
                        margin: const EdgeInsets.all(5.0),
                        child: Text(
                          "${_weather.description.capitalizeFirstOfEach}",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.white),
                        )),
                    Container(
                        margin: const EdgeInsets.all(5.0),
                        child: Text(
                          "H:${_weather.high.toInt()}° L:${_weather.low.toInt()}°",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                              color: Colors.white),
                        )),
                  ])),
              Column(children: <Widget>[
                Container(
                    child: Text(
                  "${_weather.temp.toInt()}°",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 60,
                      color: Colors.white),
                )),
                Container(
                    margin: const EdgeInsets.all(0),
                    child: Text(
                      "Feels like ${_weather.feelsLike.toInt()}°",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                          color: Colors.white),
                    )),
              ])
            ],
          ))
    ]);
  }

  Image getWeatherIcon(String _icon) {
    String path = 'assets/icons/';
    String imageExtension = ".png";
    return Image.asset(
      path + _icon + imageExtension,
      width: 70,
      height: 70,
    );
  }

  Image getWeatherIconSmall(String _icon) {
    String path = 'assets/icons/';
    String imageExtension = ".png";
    return Image.asset(
      path + _icon + imageExtension,
      width: 40,
      height: 40,
    );
  }

  Widget hourlyBoxes(Forecast _forecast) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 0.0),
        height: 150.0,
        child: ListView.builder(
            padding:
                const EdgeInsets.only(left: 8, top: 0, bottom: 0, right: 8),
            scrollDirection: Axis.horizontal,
            itemCount: _forecast.hourly.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  padding: const EdgeInsets.only(
                      left: 10, top: 15, bottom: 15, right: 10),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 1), // changes position of shadow
                        )
                      ]),
                  child: Column(children: [
                    Text(
                      "${_forecast.hourly[index].temp}°",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: Colors.black),
                    ),
                    getWeatherIcon(_forecast.hourly[index].icon),
                    Text(
                      "${getTimeFromTimestamp(_forecast.hourly[index].dt)}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.grey),
                    ),
                  ]));
            }));
  }

  String getTimeFromTimestamp(int timestamp) {
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var formatter = new DateFormat('h:mm a');
    return formatter.format(date);
  }

  String getDateFromTimestamp(int timestamp) {
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var formatter = new DateFormat('E');
    return formatter.format(date);
  }

  Widget dailyBoxes(Forecast _forcast) {
    return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            padding:
                const EdgeInsets.only(left: 8, top: 0, bottom: 0, right: 8),
            itemCount: _forcast.daily.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  padding: const EdgeInsets.only(
                      left: 10, top: 5, bottom: 5, right: 10),
                  margin: const EdgeInsets.all(5),
                  child: Row(children: [
                    Expanded(
                        child: Text(
                      "${getDateFromTimestamp(_forcast.daily[index].dt)}",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    )),
                    Expanded(
                        child: getWeatherIconSmall(_forcast.daily[index].icon)),
                    Expanded(
                        child: Text(
                      "${_forcast.daily[index].high.toInt()}/${_forcast.daily[index].low.toInt()}",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    )),
                  ]));
            }));
  }

  AppBar buildAppBar(String location) {
    return AppBar(
      leading: IconButton(
        highlightColor: Colors.transparent,
        splashRadius: 27.5,
        icon: Icon(
          Icons.near_me,
          color: Colors.white,
        ),
        onPressed: () async {
          Weather weatherData = Weather.fromJson(
              await ApiDataSource.instance.getLocationWeather());
          _changeLocation(weatherData);
        },
      ),
      centerTitle: true,
      title: Text(location),
      actions: <Widget>[
        IconButton(
          highlightColor: Colors.transparent,
          splashRadius: 27.5,
          icon: Icon(
            Icons.my_location,
            color: Colors.white,
          ),
          onPressed: () async {
            var typedName = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SearchPage();
                },
              ),
            );
            if (typedName != null) {
              Weather weatherData = Weather.fromJson(
                  await ApiDataSource.instance.getCurrentWeather(typedName));
              _changeLocation(weatherData);
            }
          },
        )
      ],
    );
  }
}

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height - 20);

    path.quadraticBezierTo((size.width / 6) * 1, (size.height / 2) + 15,
        (size.width / 3) * 1, size.height - 30);
    path.quadraticBezierTo((size.width / 2) * 1, (size.height + 0),
        (size.width / 3) * 2, (size.height / 4) * 3);
    path.quadraticBezierTo((size.width / 6) * 5, (size.height / 2) - 20,
        size.width, size.height - 60);

    path.lineTo(size.width, size.height - 60);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(Clipper oldClipper) => false;
}
