import 'package:flutter/material.dart';
import 'package:weather/models/hive/weather_hive.dart';
import 'package:weather/screens/login/login_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/models/hive/boxes.dart';
import 'package:weather/models/hive/pengguna.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PenggunaAdapter());
  Hive.registerAdapter(WeatherHiveAdapter());
  await Hive.openBox<Pengguna>(HiveBoxex.pengguna);
  await Hive.openBox<WeatherHive>(HiveBoxex.weather);
  runApp(MyApp());
}

ColorScheme defaultColorScheme = const ColorScheme(
  primaryVariant: Color(0xffBB86FC),
  primary: Color(0xFFFFBD73),
  secondaryVariant: Color(0xff03DAC6),
  secondary: Color(0xff42a5f5),
  surface: Color(0xff181818),
  background: Color(0xFF121212),
  error: Color(0xffCF6679),
  onPrimary: Color(0xff000000),
  onSecondary: Color(0xff000000),
  onSurface: Color(0xffffffff),
  onBackground: Color(0xffffffff),
  onError: Color(0xff000000),
  brightness: Brightness.dark,
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: defaultColorScheme.background,
          elevation: 0,
        ),
        scaffoldBackgroundColor: defaultColorScheme.background,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}
