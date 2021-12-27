import 'package:flutter/material.dart';
import 'package:climax/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:climax/services/weather_model.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationData();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LocationScreen(
                  locationWeatherData: weatherData,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitSpinningLines(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
