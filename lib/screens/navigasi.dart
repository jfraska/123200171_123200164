import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weather/screens/weathersave/card_weather.dart';
import 'package:weather/screens/login/login_screen.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/screens/homepage/weather.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Navigasi extends StatefulWidget {
  Weather locationWeather;

  Navigasi(this.locationWeather);
  @override
  _Navigasi createState() => _Navigasi();
}

class _Navigasi extends State<Navigasi> {
  int tabIndex = 0;
  bool visible = false;

  SharedPreferences logindata;

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
  }

  // List<Location> locations = [
  //   new Location(
  //       city: "calgary",
  //       country: "canada",
  //       lat: "51.0407154",
  //       lon: "-114.1513999"),
  //   new Location(
  //       city: "edmonton",
  //       country: "canada",
  //       lat: "53.5365386",
  //       lon: "-114.1513999"),
  //   new Location(
  //       city: "Yogyakarta",
  //       country: "indonesia",
  //       lat: "-7.797068",
  //       lon: "110.370529")
  // ];

  void changeTabIndex(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: tabIndex,
          children: [
            WeatherPage(widget.locationWeather),
            CardWeather(),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: CustomNavigationBar(
          // backgroundColor:
          //     context.theme.bottomNavigationBarTheme.backgroundColor!,
          onTap: (int index) {
            if (index == 2) {
              exit(context);
            } else {
              changeTabIndex(index);
            }
          },
          currentIndex: tabIndex,
          strokeColor: const Color(0x300c18fb),
          items: [
            CustomNavigationBarItem(
              icon: const Icon(Iconsax.cloud_sunny),
            ),
            CustomNavigationBarItem(
              icon: const Icon(Iconsax.global),
            ),
            CustomNavigationBarItem(
              icon: const Icon(Iconsax.logout_1),
            ),
          ],
        ),
      ),
    );
  }

  void exit(BuildContext context) {
    AlertDialog alert = AlertDialog(
      // title: Text("Log Out"),
      content: Container(
        child: Text("Apakah anda yakin ingin logout ?"),
      ),
      actions: [
        TextButton(
            child: Text('Yes'),
            onPressed: () async {
              await logindata.remove('username');
              if (mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false);
              }
            }),
        TextButton(
          child: Text('No'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    showDialog(context: context, builder: (context) => alert);
    return;
  }
}
