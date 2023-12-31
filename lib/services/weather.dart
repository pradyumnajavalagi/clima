
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

<<<<<<< HEAD
const apiKey = "cd5a2e569524f2d39dbdf5d92a589ff1";
=======
const apiKey = "YOUR_API_KEY";
>>>>>>> 9f495d5cf5fb09990997b6c2cf609730c21457f1
const openWeatherUrl = "https://api.openweathermap.org/data/2.5/weather";

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName) async{
    print(cityName);
    NetworkHelper networkHelper = NetworkHelper("$openWeatherUrl?q=$cityName&appid=$apiKey&units=metric");
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async{
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper("$openWeatherUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric");

    var weatherData = await networkHelper.getData();
    return weatherData;
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔';
    } else if (condition < 700) {
      return '☃';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀';
    } else if (condition <= 804) {
      return '☁';
    } else {
      return '🤷‍';
    }
  }
  String getBackground(int temp) {
    if (temp > 25){
      return 'images/sunny.jpg';
    }
    else if(temp >20){
      return 'images/cloudy.jpg';
    }
    else if(temp < 10){
      return 'images/winter.jpg';
    }
    else{
      return 'images/rainy.jpg';
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
