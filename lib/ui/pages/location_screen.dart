import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loginv1/constants/theme.dart';
import 'package:loginv1/services/weather.dart';
import 'package:loginv1/ui/widgets/form_vertical_spacing.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
    int temperature = 0;

  String weatherIcon = 'no';

  String cityName = 'Iasi';

  String country = 'Romania';

  String mood = 'Sunny';

  int wind = 0;

  

  String weatherMessage = 'All good';

  int tempmin = 0;

  int tempmax = 0;

  String weatherMin = 'min';

  String windMessage = '';

  String weatherMax = 'max';

  AssetImage weatherBackground = AssetImage('assets/night.jpg');

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
        weatherBackground = AssetImage('assets/night.jpg');
        cityName = '';
        country = '';
        mood = '';
        wind = 0;
       
        tempmin = 0;
        tempmax = 0;
        weatherMin = 'Unable to get weather data';
        windMessage = 'Unable to get weather data';
        weatherMax = 'Unable to get weather data';
        return;
      }
      double temp = weatherData['main']['temp'];
      double temp1 = weatherData['main']['temp_min'];
      double temp2 = weatherData['main']['temp_max'];
      temperature = temp.toInt();
      tempmin = temp1.toInt();
      tempmax = temp2.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherBackground = weather.getWeatherBackground(condition);
      weatherMessage = weather.getMessage(temperature);
      weatherMin = weather.getMessage(tempmin);
      weatherMax = weather.getMessage(tempmax);
      cityName = weatherData['name'];
      country = weatherData['sys']['country'];
      mood = weatherData['weather'][0]['main'];
      double windy = weatherData['wind']['speed'];
      wind = windy.toInt();
      windMessage = weather.getMessage(wind);

     
          });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: weatherBackground,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.srgbToLinearGamma(),
            opacity: 0.5,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () async {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: primaryClr,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                      print(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      color: primaryClr,
                    ),
                  ),
                ],
              ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 150,
                      ),
                      Text(
                        '$cityName',
                        style: GoogleFonts.lato(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()..shader = linearGradient,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '$country',
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                           foreground: Paint()..shader = linearGradient,
                         
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$temperature°',
                        style: GoogleFonts.lato(
                          fontSize: 85,
                          fontWeight: FontWeight.w300,
                          foreground: Paint()..shader = linearGradient,
                        ),
                      ),
                      Row(
                        children: [
                         Text(
                           weatherIcon,
                           style: TextStyle(
                             fontSize: 25,
                           ),
                           
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '$mood',
                            style: GoogleFonts.lato(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            foreground: Paint()..shader = linearGradient,
                            ),
                          ),
                        ],
                      ),
                      FormVerticalSpace(),
                      FormVerticalSpace(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                         Text(
                            'Temp. min: $tempmin°',
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            foreground: Paint()..shader = linearGradient,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                              'Temp. max: $tempmax°',
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            foreground: Paint()..shader = linearGradient,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              ),
              Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: primaryClr,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Wind',
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                               foreground: Paint()..shader = linearGradient,
                            ),
                          ),
                          Text(
                            '$wind',
                            style: GoogleFonts.lato(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                               foreground: Paint()..shader = linearGradient,
                            ),
                          ),
                          Text(
                            'km/h',
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                               foreground: Paint()..shader = linearGradient,
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 5,
                                width: 50,
                                color: secClr,
                              ),
                              Container(
                                height: 5,
                                width: wind/2,
                                color: primaryClr,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Rain',
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                               foreground: Paint()..shader = linearGradient,
                            ),
                          ),
                          Text(
                            '0',
                            style: GoogleFonts.lato(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                               foreground: Paint()..shader = linearGradient,
                            ),
                          ),
                          Text(
                            '%',
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                               foreground: Paint()..shader = linearGradient,
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 5,
                                width: 50,
                                color: secClr,
                              ),
                              Container(
                                height: 5,
                                width: wind/2,
                                color: primaryClr,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Humidy',
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                               foreground: Paint()..shader = linearGradient,
                            ),
                          ),
                          Text(
                           '0',
                            style: GoogleFonts.lato(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                               foreground: Paint()..shader = linearGradient,
                            ),
                          ),
                          Text(
                            '%',
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                               foreground: Paint()..shader = linearGradient,
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 5,
                                width: 50,
                                color: secClr,
                              ),
                              Container(
                                height: 5,
                                width: wind/2,
                                color: primaryClr,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ],      
          ),
        ),
      ),
    );
  }
}
