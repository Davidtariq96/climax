import 'package:climax/services/location.dart';
import 'package:climax/services/networking.dart';

const keys = "60a50656da7356dc53ed629b7cba2216";
const openWeatherUrl = "http://api.openweathermap.org/data/2.5/weather";

class WeatherModel {
  Future<dynamic> getWeatherByCityName({required String cityName}) async {
    var url = '$openWeatherUrl?q=$cityName&appid=$keys&units=metric';
    Networking networking = Networking(url: url);
    var remoteData = await networking.fetchRemoteData();
    return remoteData;
  }

  Future<dynamic> getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    Networking networking = Networking(
        url:
            "$openWeatherUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$keys&units=metric");
    var remoteData = await networking.fetchRemoteData();
    return remoteData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
