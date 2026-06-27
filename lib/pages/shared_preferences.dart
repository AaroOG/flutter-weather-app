import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _initPrefs();
    _loadCity();
  }

  void _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _saveCity('defaultCity');
  }

  void _saveCity(String city) async {
    if (_prefs != null) {
      await _prefs!.setString('city', city);
      print('City saved: $city'); // Debug log
    }
  }

  void _loadCity() async {
    if (_prefs != null) {
      String? city = _prefs!.getString('city');
      print('City loaded: $city'); // Debug log
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shared Preferences Example')),
      body: Center(child: Text('Check console for logs')),
    );
  }
}
