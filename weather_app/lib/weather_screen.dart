import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/AdditionalInfo.dart';
import 'package:weather_app/card.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:weather_app/private.dart';
import 'package:weather_app/locator.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String cityName = "122102";

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      final res = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherApiKey'),
      );
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw 'An Unexpected error occured';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              try {
                Map<String, double> location = await getCurrentLocation();
                double? latitude = location['latitude'];
                double? longitude = location['longitude'];
                final resi = await http.get(
                  Uri.parse(
                      'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyBBpZbnLKXp3fGdf2-jC-nx-DH9nocvGfY'),
                );
                final urdata = jsonDecode(resi.body);
                setState(() {
                  cityName = urdata?["results"][0]["address_components"][6]
                      ["long_name"];
                });
              } catch (e) {
                throw e.toString();
              }
            },
            icon: const Icon(
              Icons.location_on,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.refresh)),
        ],
        centerTitle: true,
        title: const Text(
          "Weather App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          final data = snapshot.data;
          final extract = data!['list'][0];
          final weather = extract['weather'][0]['main'];
          final temp = extract['main']['temp'];
          final humidity = extract['main']['humidity'];
          final windspeed = extract['wind']['speed'];
          final pressure = extract['main']['pressure'];
          final visibility = extract['visibility'];
          final feelslike = extract['main']['feels_like'];
          final sealevel = extract['main']['sea_level'];

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Postal Code",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      Text(cityName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white)),
                    ],
                  ),
                  //main Card
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 210,
                    width: double.infinity,
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 10,
                              sigmaY: 10,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text(
                                    "$temp K".toString(),
                                    style: const TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Icon(
                                      weather == 'clouds' || weather == 'Rain'
                                          ? Icons.cloudy_snowing
                                          : Icons.sunny,
                                      size: 70,
                                      color: Colors.white),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    weather,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Weather Forecast",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: [
                  //       //small card
                  //       for (int i = 1; i < 6; i++)
                  //
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 130,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          final forcast = data['list'][index + 1];
                          final time =
                              DateTime.parse(forcast['dt_txt'].toString());
                          return MyWidget(
                            temp: forcast['main']['temp'].toString(),
                            time: DateFormat.j().format(time).toString(),
                            icon: Icons.cloud,
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Additional Information",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInfo(
                        icon: Icons.water_drop,
                        label: "Humidity",
                        value: humidity.toString(),
                      ),
                      AdditionalInfo(
                        icon: Icons.air,
                        label: "Wind speed",
                        value: windspeed.toString(),
                      ),
                      AdditionalInfo(
                        icon: Icons.beach_access,
                        label: "Pressure",
                        value: pressure.toString(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInfo(
                        icon: Icons.clear_all_rounded,
                        label: "Feels Like",
                        value: feelslike.toString(),
                      ),
                      AdditionalInfo(
                        icon: Icons.visibility,
                        label: "Visibility",
                        value: visibility.toString(),
                      ),
                      AdditionalInfo(
                        icon: Icons.water,
                        label: "Sea Level",
                        value: sealevel.toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
