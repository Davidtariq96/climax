import 'package:flutter/material.dart';
import 'package:climax/utilities/constants.dart';
import 'package:climax/services/weather_model.dart';
import 'package:climax/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  //a variable to receive the remote data from loading screen
  final dynamic locationWeatherData;
  const LocationScreen({Key? key, required this.locationWeatherData})
      : super(key: key);
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();

  int? temperature;
  String? weatherIcon;
  String? weatherDescription;
  String? city;

  //every STATE has the WIDGET property to tap into it's own properties of the state
  @override
  void initState() {
    super.initState();
    updateUI(weatherInformation: widget.locationWeatherData);
    // print(widget.locationWeatherData);
  }

  void updateUI({dynamic weatherInformation}) {
    setState(() {
      if (weatherInformation == null) {
        temperature = 0;
        weatherIcon = "Error";
        weatherDescription = "Unable to get weather data now";
        city = "";
        return;
      }
      double temp = weatherInformation["main"]["temp"];
      temperature = temp.toInt();
      weatherDescription = weatherModel.getMessage(temperature ?? 0);
      var id = weatherInformation["weather"][0]["id"];
      weatherIcon = weatherModel.getWeatherIcon(id);
      city = weatherInformation["name"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getLocationData();
                      updateUI(weatherInformation: weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      //storing value gotten from user on the city-screen
                      var userCityNameInput = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CityScreen()));
                      if (userCityNameInput != null) {
                        var cityWeatherData = await weatherModel
                            .getWeatherByCityName(cityName: userCityNameInput);
                        updateUI(weatherInformation: cityWeatherData);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Expanded(
                      child: Text(
                        weatherIcon.toString(),
                        style: kConditionTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherDescription in $city!!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
