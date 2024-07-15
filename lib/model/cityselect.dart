import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherFactory _wf = WeatherFactory("YOUR_OPENWEATHER_API_KEY");
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    fetchWeather("Bandarawela"); // Default city
  }

  void fetchWeather(String cityName) {
    _wf.currentWeatherByCityName(cityName).then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  void _showCityInputDialog() async {
    String? cityName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _textFieldController = TextEditingController();
        return AlertDialog(
          title: Text('Enter City Name'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "City Name"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(_textFieldController.text);
              },
            ),
          ],
        );
      },
    );
    if (cityName != null && cityName.isNotEmpty) {
      fetchWeather(cityName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _showCityInputDialog,
          ),
        ],
      ),
      body: Container(
  child: _weather == null
      ? Text('Enter a city name to get weather information')
      : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'City: ${_weather!.areaName}',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Temperature: ${_weather!.temperature!.celsius!.toStringAsFixed(2)} °C',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Weather: ${_weather!.weatherDescription}',
              style: TextStyle(fontSize: 20),
            ),
            // Add more weather details as needed
          ],
        ),
        // Your existing UI code
      ),
    );
  }
}