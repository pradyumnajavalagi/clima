// import 'package:clima/screens/city_screen.dart';
// import 'package:clima/services/weather.dart';
// import 'package:flutter/material.dart';
// import 'package:clima/utilities/constants.dart';
//
// class LocationScreen extends StatefulWidget {
//   LocationScreen({required this.locationWeather});
//
//   final locationWeather;
//
//   @override
//   _LocationScreenState createState() => _LocationScreenState();
// }
//
// class _LocationScreenState extends State<LocationScreen> {
//   WeatherModel weather = WeatherModel();
//   double temperatureInKelvin = 0;
//   String weatherIcon = '';
//   String message = '';
//   String cityName = '';
//   int temperature = 0;
//   @override
//   void initState() {
//     super.initState();
//     updateUI(widget.locationWeather);
//   }
//
//   void updateUI(weatherData) {
//     setState(() {
//       temperatureInKelvin = weatherData['main']['temp'];
//       var condition = weatherData['weather'][0]['id'];
//       cityName = weatherData['name'];
//       weatherIcon = weather.getWeatherIcon(condition);
//       print(weatherIcon);
//       // (temperatureInKelvin).toStringAsFixed(0);
//       // print(temperatureInKelvin);
//       temperature = (temperatureInKelvin - 273.15).toInt();
//       message = weather.getMessage(temperature);
//       // print(temperature);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('images/location_background.jpg'),
//             fit: BoxFit.cover,
//             colorFilter: ColorFilter.mode(
//                 Colors.white.withOpacity(0.8), BlendMode.dstATop),
//           ),
//         ),
//         constraints: BoxConstraints.expand(),
//         child: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   TextButton(
//                     onPressed: () async {
//                       var weatherData = await weather.getLocationWeather();
//                       updateUI(weatherData);
//                     },
//                     child: Icon(
//                       Icons.near_me,
//                       size: 50.0,
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () async {
//                       var typeName = await Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) {
//                             return CityScreen();
//                           },
//                         ),
//                       );
//                       if (typeName != null){
//                        var weatherData = await weather.getCityWeather(typeName);
//                        updateUI(weatherData);
//                       }
//                     },
//                     child: Icon(
//                       Icons.location_city,
//                       size: 50.0,
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 15.0),
//                 child: Row(
//                   children: <Widget>[
//                     Text(
//                       '$temperature°',
//                       style: kTempTextStyle,
//                     ),
//                     Text(
//                       weatherIcon,
//                       style: kConditionTextStyle,
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(right: 15.0),
//                 child: Text(
//                   "$message in $cityName!",
//                   textAlign: TextAlign.right,
//                   style: kMessageTextStyle,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature = 0;
  String weatherIcon = '';
  String cityName = '';
  String weatherMessage = '';

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: const BoxDecoration(
                        color: Color(0xFF3E4772),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.near_me,
                        color: Colors.white,
                        size: 40.0,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: const BoxDecoration(
                        color: Color(0xFF3E4772),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(
                              -5.0,
                              5.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.location_city,
                        color: Colors.white,
                        size: 40.0,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      textAlign: TextAlign.center,
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName',
                  textAlign: TextAlign.center,
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
