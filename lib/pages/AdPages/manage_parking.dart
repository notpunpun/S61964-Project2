import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tourist_guide/pages/parking_page.dart';

class ManageParkingPage extends StatefulWidget {
  @override
  _ManageParkingPageState createState() => _ManageParkingPageState();
}

class _ManageParkingPageState extends State<ManageParkingPage> {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  String? submittedLocation;
  double? submittedPrice;

  List<String> parkingLocations = [];

  Future<void> addParkingLocation() async {
    final url = Uri.https(
      'hensem-f1a58-default-rtdb.asia-southeast1.firebasedatabase.app',
      'ParkingLocation.json',
    );

    final response = await http.post(
      url,
      body: json.encode({
        'location': locationController.text,
        'price': double.tryParse(priceController.text),
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        parkingLocations.add(locationController.text);
        submittedLocation = locationController.text;
        submittedPrice = double.tryParse(priceController.text);
      });

      print('Parking location added successfully');
    } else {
      print(
        'Failed to add parking location. Status code: ${response.statusCode}',
      );
    }
  }

  void navigateToParkingPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ParkingPage(
          onSubmit: (location) {
            // Handle the submitted location data here
            print('Submitted Location: $location');
          },
          locationNames: parkingLocations,
          isAdmin: false, // Set the isAdmin value accordingly
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Parking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add Parking Location',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: 'Location Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Price Per Hour',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addParkingLocation,
              child: Text('Add Parking Location'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: navigateToParkingPage,
              child: Text('Go to Parking Page'),
            ),
            SizedBox(height: 20),
            if (submittedLocation != null) ...{
              Text(
                'Submitted Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Location Name: $submittedLocation'),
              Text('Price Per Hour: ${submittedPrice ?? "N/A"}'),
            },
          ],
        ),
      ),
    );
  }
}
