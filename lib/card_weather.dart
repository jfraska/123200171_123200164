import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weather/add_weather.dart';
import 'package:weather/models/boxes.dart';
import 'package:weather/models/weather_hive.dart';

class CardWeather extends StatefulWidget {
  @override
  State<CardWeather> createState() => _CardWeatherState();
}

class _CardWeatherState extends State<CardWeather> {
  Box<WeatherHive> _myBox;

  @override
  void initState() {
    super.initState();
    _myBox = Hive.box<WeatherHive>(HiveBoxex.weather);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: ValueListenableBuilder<Box>(
        valueListenable: _myBox.listenable(),
        builder: (context, value, child) {
          if (value.isEmpty) {
            return const Center(
              child: Text('Weather Tidak Ada'),
            );
          }
          return ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              WeatherHive weather = value.getAt(index);
              return Dismissible(
                key: UniqueKey(),
                background: Container(
                  color: Colors.red,
                ),
                onDismissed: (direction) {
                  // DELETE TODO AT INDEX
                  _myBox.deleteAt(index);
                },
                child: ListTile(
                  title: Text(weather.city),
                  subtitle: Text(weather.lat),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddWeather(),
            ),
          );
        },
        child: const Icon(Iconsax.add),
      ),
    );
  }

  // Widget weatherBox(Weather _weather) {
  //   return Stack(children: [
  //     Container(
  //       padding: const EdgeInsets.all(15.0),
  //       margin: const EdgeInsets.all(15.0),
  //       height: 160.0,
  //       decoration: BoxDecoration(
  //           color: Colors.indigoAccent,
  //           borderRadius: BorderRadius.all(Radius.circular(20))),
  //     ),
  //     ClipPath(
  //         clipper: Clipper(),
  //         child: Container(
  //             padding: const EdgeInsets.all(15.0),
  //             margin: const EdgeInsets.all(15.0),
  //             height: 160.0,
  //             decoration: BoxDecoration(
  //                 color: Colors.indigoAccent[400],
  //                 borderRadius: BorderRadius.all(Radius.circular(20))))),
  //     Container(
  //         padding: const EdgeInsets.all(15.0),
  //         margin: const EdgeInsets.all(15.0),
  //         height: 160.0,
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.all(Radius.circular(20))),
  //         child: Row(
  //           children: [
  //             Expanded(
  //                 child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: <Widget>[
  //                   getWeatherIcon(_weather.icon),
  //                   Container(
  //                       margin: const EdgeInsets.all(5.0),
  //                       child: Text(
  //                         "${_weather.description.capitalizeFirstOfEach}",
  //                         style: TextStyle(
  //                             fontWeight: FontWeight.normal,
  //                             fontSize: 16,
  //                             color: Colors.white),
  //                       )),
  //                   Container(
  //                       margin: const EdgeInsets.all(5.0),
  //                       child: Text(
  //                         "H:${_weather.high.toInt()}° L:${_weather.low.toInt()}°",
  //                         textAlign: TextAlign.left,
  //                         style: TextStyle(
  //                             fontWeight: FontWeight.normal,
  //                             fontSize: 13,
  //                             color: Colors.white),
  //                       )),
  //                 ])),
  //             Column(children: <Widget>[
  //               Container(
  //                   child: Text(
  //                 "${_weather.temp.toInt()}°",
  //                 textAlign: TextAlign.left,
  //                 style: TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 60,
  //                     color: Colors.white),
  //               )),
  //               Container(
  //                   margin: const EdgeInsets.all(0),
  //                   child: Text(
  //                     "Feels like ${_weather.feelsLike.toInt()}°",
  //                     textAlign: TextAlign.left,
  //                     style: TextStyle(
  //                         fontWeight: FontWeight.normal,
  //                         fontSize: 13,
  //                         color: Colors.white),
  //                   )),
  //             ])
  //           ],
  //         ))
  //   ]);
  // }
}
