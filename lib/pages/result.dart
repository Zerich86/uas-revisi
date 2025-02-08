import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Result extends StatefulWidget {
  final String place;

  const Result({super.key, required this.place});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  Future<Map<String, dynamic>> getDataFromAPI() async {
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=${widget.place}&appid=4ba0c457bb0f1404c9c3cbe93bff935b&units=metric"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return data;
    } else {
      throw Exception("Error!");
    }
  }

  String getWindDirection(int degrees) {
    if (degrees >= 337.5 || degrees < 22.5) {
      return 'Utara';
    } else if (degrees >= 22.5 && degrees < 67.5) {
      return 'Timur Laut';
    } else if (degrees >= 67.5 && degrees < 112.5) {
      return 'Timur';
    } else if (degrees >= 112.5 && degrees < 157.5) {
      return 'Tenggara';
    } else if (degrees >= 157.5 && degrees < 202.5) {
      return 'Selatan';
    } else if (degrees >= 202.5 && degrees < 247.5) {
      return 'Barat Daya';
    } else if (degrees >= 247.5 && degrees < 292.5) {
      return 'Barat';
    } else {
      return 'Barat Laut';
    }
  }

  String getCountryName(String countryCode) {
    switch (countryCode) {
      case 'ID':
        return 'Indonesia';
      case 'JP':
        return 'Jepang';
      // Add more country codes and names as needed
      default:
        return countryCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              title: const Text(
                "Hasil Tracking",
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: Colors.blueAccent,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    setState(() {});
                  },
                ),
              ]),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: FutureBuilder(
              future: getDataFromAPI(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasData) {
                  final data = snapshot.data!; //data tidak boleh nol
                  final windDirection = getWindDirection(data['wind']['deg']);
                  final dateTime = DateTime.now();
                  final formattedDate =
                      "${dateTime.day}-${dateTime.month}-${dateTime.year}";
                  final formattedTime =
                      "${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
                  final countryName = getCountryName(data['sys']['country']);
                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                            'https://flagcdn.com/w320/${data["sys"]["country"].toLowerCase()}.png'),
                        const SizedBox(height: 20),
                        Table(
                          columnWidths: const {
                            0: IntrinsicColumnWidth(),
                            1: FlexColumnWidth(),
                          },
                          border: TableBorder.all(),
                          children: [
                            TableRow(children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Negara'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(countryName),
                              ),
                            ]),
                            TableRow(children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Suhu'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("${data['main']['feels_like']} C"),
                              ),
                            ]),
                            TableRow(children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Kecepatan Angin'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("${data["wind"]["speed"]} m/s"),
                              ),
                            ]),
                            TableRow(children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Arah Angin'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(windDirection),
                              ),
                            ]),
                            TableRow(children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Tanggal'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(formattedDate),
                              ),
                            ]),
                            TableRow(children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Waktu'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(formattedTime),
                              ),
                            ]),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {});
                          },
                          child: const Text('Refresh'),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Text("Tempat tidak diketahui");
                }
              },
            ),
          )),
    );
  }
}
