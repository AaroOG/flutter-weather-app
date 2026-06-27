import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_model.dart';

class WeatherService {
  final String apiKey = '9d5cb67cfe031434aa1fa064f55ee36e';

  Future<Weather> fetchWeatherByCityName(String cityName) async {
    final response = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=imperial',
      ),
    );

    print(
      http
          .get(
            Uri.parse(
              'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=imperial',
            ),
          )
          .toString(),
    );

    // ignore: avoid_print
    print(
      'API URL: https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=imperial',
    );
    // ignore: avoid_print
    print('Response: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return Weather.fromJson(jsonResponse);
    } else {
      // ignore: avoid_print
      print('Error response: ${response.body}');
      throw Exception('Failed to load weather data');
    }
  }
}
