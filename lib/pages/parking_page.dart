import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tourist_guide/pages/parking_space.dart';

class ParkingPage extends StatefulWidget {
  final Function(Location?) onSubmit;
  final List<String> locationNames;
  final bool isAdmin;

  const ParkingPage({
    Key? key,
    required this.onSubmit,
    required this.locationNames,
    required this.isAdmin,
  }) : super(key: key);

  @override
  _ParkingPageState createState() => _ParkingPageState();
}

class Location {
  final String name;
  final double pricePerHour;

  Location({required this.name, required this.pricePerHour});
}

class _ParkingPageState extends State<ParkingPage> {
  final TextEditingController typeController = TextEditingController();
  final TextEditingController plateController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  String? selectedLocation;
  String? submittedType;
  String? submittedPlate;
  int? submittedDuration;
  double? submittedPrice;

  List<Location> locations = [];

  @override
  void initState() {
    super.initState();
    fetchLocations();
  }

  Future<void> fetchLocations() async {
    final url = Uri.https(
      'hensem-f1a58-default-rtdb.asia-southeast1.firebasedatabase.app',
      'ParkingLocation.json',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List<Location> fetchedLocations = [];

      data.forEach((key, value) {
        fetchedLocations.add(Location(
          name: value['location'],
          pricePerHour: value['price'] != null
              ? double.parse(value['price'].toString())
              : 0.0,
        ));
      });

      setState(() {
        locations = fetchedLocations;
        if (locations.isNotEmpty) {
          selectedLocation = locations.first.name;
        }
      });
    } else {
      print('Failed to fetch locations. Status code: ${response.statusCode}');
    }
  }

  Future<void> addParkingSession() async {
    double totalPrice = 0.0;
    if (selectedLocation != null) {
      totalPrice = locations
              .firstWhere((location) => location.name == selectedLocation)
              .pricePerHour *
          (int.tryParse(durationController.text) ?? 0);
    }

    final url = Uri.https(
      'hensem-f1a58-default-rtdb.asia-southeast1.firebasedatabase.app',
      'Session.json',
    );

    final response = await http.post(
      url,
      body: json.encode({
        'type': typeController.text,
        'plate': plateController.text,
        'location': selectedLocation,
        'duration': int.tryParse(durationController.text),
        'price': totalPrice,
        'isAdmin': widget.isAdmin,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        submittedType = typeController.text;
        submittedPlate = plateController.text;
        submittedDuration = int.tryParse(durationController.text);
        submittedPrice = totalPrice;
      });

      print('Parking session added successfully');
    } else {
      print(
          'Failed to add parking session. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parking App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add Vehicle',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: typeController,
              decoration: InputDecoration(
                labelText: 'Vehicle Type',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: plateController,
              decoration: InputDecoration(
                labelText: 'Vehicle Plate',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: durationController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Duration (in hours)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Select Location',
              style: TextStyle(fontSize: 18),
            ),
            DropdownButton<String>(
              value: selectedLocation,
              items: locations
                  .map((location) => DropdownMenuItem(
                        child: Text(location.name),
                        value: location.name,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedLocation = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: widget.isAdmin ? null : addParkingSession,
              child: Text('Start Parking Session'),
            ),
            SizedBox(height: 20),
            if (submittedType != null) ...{
              Text(
                'Submitted Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              // Button to navigate to ParkingUtilizationWidget
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ParkingUtilizationWidget(
                        utilizationService:
                            ParkingUtilizationService(numRows: 4, numCols: 3),
                      ),
                    ),
                  );
                },
                child: Text('Book Parking Slot'),
              ),

              Text('Vehicle Type: $submittedType'),
              Text('Vehicle Plate: $submittedPlate'),
              Text('Location: ${selectedLocation ?? "N/A"}'),
              Text('Duration: ${submittedDuration ?? "N/A"} hours'),
              Text('Price: ${submittedPrice ?? "N/A"}'),
            },
          ],
        ),
      ),
    );
  }
}
