import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weath_app/consts.dart';
import 'package:weath_app/model/cityselect.dart';
import 'package:weather/weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);

  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("Bandarawela").then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue[300]!,
            Colors.blue[100]!
          ], // Light to darker shade of purple
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _buildUI(),
      ),
    );
  }

  Widget _buildUI() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _locationHeader(),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.08,
            ),
            _dateTimeInfo(),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.08,
            ),
            _weatherIcon(),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.08,
            ),
            _currentTemperature(),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.08,
            ),
            _extraInfo(),
          ]),
    );
  }

  Widget _locationHeader() {
    return GestureDetector(
      onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => WeatherScreen()),
      );
    },
      
      
      
      child: Text(
        _weather?.areaName ?? "",
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _dateTimeInfo() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              DateFormat("d MMMM").format(now),
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _weatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.2,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"))),
        ),
        Text(
          _weather?.weatherDescription ?? "",
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _currentTemperature() {
    return Text(
      "${_weather?.temperature?.celsius?.round()}°",
      style: const TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
  Widget _extraInfo(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              "${(_weather!.windSpeed! * 3.6).toStringAsFixed(2)} km/h",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const Text(
              "Wind",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 16,
        ),
        Column(
          children: [
            Text(
              "${_weather?.cloudiness}%",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const Text(
              "Cloudiness",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 16,
        ),
        Column(
          children: [
            Text(
              "${_weather?.humidity}%",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const Text(
              "Humidity",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
  
}
