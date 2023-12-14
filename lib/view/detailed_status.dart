import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:smartwaste/view/weight_graph.dart';
import 'package:http/http.dart' as http;

class detailedStatusPage extends StatefulWidget {
  const detailedStatusPage({super.key});

  @override
  State<detailedStatusPage> createState() => _detailedStatusPage();
}

class _detailedStatusPage extends State<detailedStatusPage> {
  // URL for get latest Heat data
  final String urlT =
      "https://api.thingspeak.com/channels/2364486/fields/1/last.json?api_key=2WBJ4ZYNMCJCAFC0&results";
  dynamic temperature;

  /*final String urlW =
      "https://api.thingspeak.com/channels/2364486/fields/2/last.json?api_key=2WBJ4ZYNMCJCAFC0&results";
  List? weight;*/

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    try {
      var response = await http
          .get(Uri.parse(urlT), headers: {"Accept": "application/json"});

      if (response.statusCode == 200) {
        var convertDataToJson = jsonDecode(response.body);

        // Ensure the response contains the expected field name 'field1'
        if (convertDataToJson.containsKey('field1')) {
          temperature = convertDataToJson['field1'];
        } else {
          // Handle the case where 'field1' is not present in the response
          print("Field 'field1' not found in API response");
        }
      } else {
        // Handle HTTP error
        print("HTTP Error: ${response.statusCode}");
      }
    } catch (e) {
      // Handle other errors
      print("Error fetching data: $e");
    }

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('BIN STATUS'),
        backgroundColor: Colors.amber,
      ),
      backgroundColor: Colors.amberAccent,
      body: ListView(
        children: [
          GestureDetector(
            onTap: () {
              // Handle tap for CardLocation
              print('CardLocation tapped!');
            },
            child: Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, color: Colors.red, size: 60.0),
                    SizedBox(height: 16),
                    Column(
                      children: [
                        Text(
                          'Location',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Display Location',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Handle tap for CardDistance
              print('CardDistance tapped!');
            },
            child: Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.restore_from_trash,
                        color: Colors.red, size: 60.0),
                    SizedBox(height: 16),
                    Column(
                      children: [
                        Text(
                          'Distance Level',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Display Distance',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WeightAppPage()),
              );*/
              print('CardWeight tapped!');
              // Handle tap for CardWeight
            },
            child: Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.scale_outlined, color: Colors.red, size: 60.0),
                    SizedBox(height: 16),
                    Column(
                      children: [
                        Text(
                          'Current Weight Level',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Display Weight Level',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Handle tap for CardTemperature
              print('CardTemperature tapped!');
              print(temperature);
            },
            child: Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.local_fire_department,
                        color: Colors.red, size: 60.0),
                    SizedBox(height: 16),
                    Column(
                      children: [
                        Text(
                          'Current Temperature Level',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '$temperature (C)',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}