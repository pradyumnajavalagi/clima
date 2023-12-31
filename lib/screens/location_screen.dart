// import 'dart:convert';
// import 'dart:html';
// import 'dart:io';
import 'dart:ui';
// import 'package:http/http.dart' as http;
// import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

// const gptKey = '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';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late int temperature;
  late String weatherIcon;
  late String cityName;
  late String weatherMessage;
  late String background;

  // late final TextEditingController promptController;
  // String responseTxt = '';

  @override
  void initState() {
    super.initState();
    // promptController = TextEditingController();
    updateUI(widget.locationWeather);
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   promptController.dispose();
  //   super.dispose();
  // }

  // void sendChatMessage(String message) async {
  //   final conversation = [
  //     {'role': 'user', 'content': "testing"},
  //   ];
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse('https://api.openai.com/v1/chat/completions'),
  //       headers: {
  //         HttpHeaders.authorizationHeader: 'Bearer $gptKey',
  //         'Content-Type': 'application/json',
  //       },
  //       body: json.encode({
  //         'model': 'text-davinci-003',
  //         'prompt': promptController.text,
  //         'max_tokens': 250,
  //         'messages': [
  //       {'role': 'user', 'content': "testing"},
  //       ],
  //       }),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       final assistantResponse = data['choices'][0]['message']['content'];
  //       setState(() {
  //         responseTxt = assistantResponse;
  //       });
  //     } else {
  //       setState(() {
  //         responseTxt = 'Error: Unable to get a response from GPT-3.5 Turbo.';
  //       });
  //       print('API Error: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     setState(() {
  //       responseTxt = 'Error: $e';
  //     });
  //   }
  // }


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
      background = weather.getBackground(temperature);
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
            image: AssetImage(background),
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
                height: 300,
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
              // Padding(
              //   padding: const EdgeInsets.all(15.0),
              //   child: Stack(
              //     alignment: Alignment.centerRight,
              //     children: [
              //       TextField(
              //         controller: promptController,
              //         autofocus: true,
              //         decoration: InputDecoration(
              //           filled: true,
              //           fillColor: Colors.white.withOpacity(0.4),
              //           hintText: 'Type here...',
              //         ),
              //       ),
              //       IconButton(
              //         onPressed: () {
              //           sendChatMessage(promptController.text);
              //           promptController.clear();
              //         },
              //         icon: Icon(Icons.send),
              //       ),
              //     ],
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(15.0),
              //   child: Stack(
              //     alignment: Alignment.centerRight,
              //     children: [
              //       TextField(
              //         controller: promptController,
              //         autofocus: true,
              //         decoration: InputDecoration(
              //           filled: true,
              //           fillColor: Colors.white.withOpacity(0.4),
              //           // Set the opacity (0.5 for semi-translucent)
              //           hintText: 'Type here...',
              //           hintStyle: const TextStyle(
              //               color: Colors.black, fontFamily: 'SF pro Display'),
              //           border: const OutlineInputBorder(
              //             borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //             borderSide: BorderSide.none,
              //           ),
              //           floatingLabelBehavior: FloatingLabelBehavior.never,
              //         ),
              //       ),
              //       IconButton(onPressed: () => completionFun(),
              //           icon: const Icon(Icons.send)),
              //     ],
              //   ),
              // ), // Add some vertical space
              // Expanded(
              //   child: Padding(
              //     padding: const EdgeInsets.all(15.0),
              //     child: Container(
              //       alignment: Alignment.topCenter,
              //       constraints: BoxConstraints(minWidth: 200, minHeight: 200),
              //       color: Colors.white.withOpacity(0.3),
              //       child: Padding(
              //         padding: EdgeInsets.all(15),
              //         child: Text(
              //           responseTxt,
              //           style: TextStyle(
              //             color: Colors.black, // Change text color as needed
              //             fontWeight: FontWeight.normal,
              //             fontSize: 18, // Adjust font size as needed
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

//   completionFun() async {
//     setState(() => responseTxt = 'Loading...');
//   }
}