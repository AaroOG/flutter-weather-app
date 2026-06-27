import 'package:flutter/material.dart';
import 'weather.dart'; // Import WeatherService
import 'weather_model.dart'; // Import

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 13, 0, 253),
        ),
      ),
      home: const MyHomePage(title: 'Weather Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final WeatherService _weatherService = WeatherService();
  final List<String> _cities = ['London', 'Tokyo', 'Austin,TX,US'];
  final Map<String, String> _cityTemperatures = {};

  @override
  void initState() {
    super.initState();
    _fetchWeatherForCities();
  }

  Future<void> _fetchWeatherForCities() async {
    print('Fetching weather for cities: $_cities');
    for (var city in _cities) {
      try {
        print('Fetching weather for $city');
        Weather weather = await _weatherService.fetchWeatherByCityName(city);
        print(
          'Weather fetched for $city: ${weather.temperature}°F',
        ); // Debug log
        setState(() {
          _cityTemperatures[city] = '${weather.temperature}°F';
        });
      } catch (e) {
        print('Error fetching weather for $city: $e');
        setState(() {
          _cityTemperatures[city] = 'Error';
        });
      }
    }
  }

  void _addCity(String name) {
    setState(() {
      _cities.add(name);
    });
    _fetchWeatherForCities();
  }

  void _showAddCityDialog() {
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add City'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'City,State,Country (e.g., Los Angeles,CA,US)',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final String name = nameController.text;

                // Validate the input format
                final regex = RegExp(r'^[a-zA-Z\s]+,[a-zA-Z]{2},[a-zA-Z]{2}$');
                if (name.isNotEmpty && regex.hasMatch(name)) {
                  _addCity(name);
                  Navigator.of(context).pop();
                } else {
                  // Show an error message if the format is invalid
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Invalid format. Please use City,State,Country (e.g., Los Angeles,CA,US).',
                      ),
                    ),
                  );
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          // Background Text
          Align(
            alignment: Alignment.center,
            child: Text(
              'Swipe left to Remove a City',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey.withOpacity(0.2),
              ),
            ),
          ),

          // Foreground Content
          Stack(
            children: [
              Column(
                children:
                    _cities.map((city) {
                      return Dismissible(
                        key: Key(city),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            _cities.remove(city);
                            _cityTemperatures.remove(city);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('$city removed')),
                          );
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 87, 153, 244),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.35),
                                  blurRadius: 15,
                                  spreadRadius: 0,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                // Centered Temperature Text
                                Center(
                                  child: Text(
                                    _cityTemperatures[city] ?? 'Loading...',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                                // Top-left City Name Text
                                Positioned(
                                  left: 10,
                                  top: 10,
                                  child: FittedBox(
                                    fit:
                                        BoxFit
                                            .scaleDown, // Makes sure the text fits
                                    child: Text(
                                      city,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCityDialog,
        tooltip: 'Add City',
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
