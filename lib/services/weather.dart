import 'package:flutter/cupertino.dart';

import 'networking.dart';
import 'location.dart';

const apiKey = '460924f234496809ce8ec1001e24a1cc';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    MyLocation location = MyLocation();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

   var weatherData = await networkHelper.getData();
   return weatherData;
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
  getWeatherBackground(int condition) {
    if (condition < 300) {
      return AssetImage('assets/cloudy.jpeg');
    } else if (condition < 400) {
      return AssetImage('assets/rainy.jpg');
    } else if (condition < 600) {
       return AssetImage('assets/rainy.jpg');
    } else if (condition < 700) {
        return AssetImage('assets/rainy.jpg');
    } else if (condition < 800) {
        return AssetImage('assets/rainy.jpg');
    } else if (condition == 800) {
        return AssetImage('assets/sunny.jpg');
    } else if (condition <= 804) {
      return AssetImage('assets/sunny.jpg');
    } else {
       return AssetImage('assets/night.jpg');
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
