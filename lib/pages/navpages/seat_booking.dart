import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ParkingSpot {
  final String id;
  final double price;
  int hours; // Added hours attribute

  ParkingSpot({required this.id, required this.price, this.hours = 1});
}

class ParkingBookingScreen extends StatefulWidget {
  const ParkingBookingScreen({Key? key}) : super(key: key);

  @override
  _ParkingBookingScreenState createState() => _ParkingBookingScreenState();
}

class _ParkingBookingScreenState extends State<ParkingBookingScreen> {
  List<ParkingSpot> availableParkingSpots = List.generate(
    20,
    (index) => ParkingSpot(id: 'A${index + 1}', price: 5 + index.toDouble()),
  );

  List<ParkingSpot> bookedParkingSpots = [];

  double totalBookingPrice = 0;
  int selectedHours = 1; // Default selected hours

  void bookParkingSpot(ParkingSpot parkingSpot) {
    setState(() {
      availableParkingSpots.remove(parkingSpot);
      bookedParkingSpots.add(parkingSpot);
      totalBookingPrice += calculatePrice(parkingSpot.price, parkingSpot.hours);
    });
  }

  void removeBookedParkingSpot(ParkingSpot parkingSpot) {
    setState(() {
      bookedParkingSpots.remove(parkingSpot);
      availableParkingSpots.add(parkingSpot);
      totalBookingPrice -= calculatePrice(parkingSpot.price, parkingSpot.hours);
    });
  }

  double calculatePrice(double basePrice, int hours) {
    double multiplier = 1.0;

    if (hours >= 51 && hours <= 75) {
      multiplier = 1.5;
    } else if (hours >= 76 && hours <= 90) {
      multiplier = 2.0;
    } else if (hours >= 91) {
      multiplier = 2.5;
    }

    return basePrice * multiplier * hours;
  }

  void sendBookingDataToFirebase() async {
    List<Map<String, dynamic>> bookedParkingData = bookedParkingSpots
        .map(
            (spot) => {'id': spot.id, 'price': spot.price, 'hours': spot.hours})
        .toList();

    try {
      final response = await http.post(
        Uri.https(
          'hensem-f1a58-default-rtdb.asia-southeast1.firebasedatabase.app',
          'ParkingDetail.json',
        ),
        body: json.encode({
          'bookedParkingSpots': bookedParkingData,
          'totalBookingPrice': totalBookingPrice,
        }),
      );

      if (response.statusCode == 200) {
        print('Booking data sent to Firebase successfully');
      } else {
        print('Error sending booking data to Firebase: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending booking data to Firebase: $error');
    }

    setState(() {
      bookedParkingSpots = [];
      totalBookingPrice = 0;
    });
  }

  Widget buildParkingSpotGrid(List<ParkingSpot> spots) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: spots.length,
        itemBuilder: (context, index) {
          final parkingSpot = spots[index];

          return GestureDetector(
            onTap: () {
              bookParkingSpot(parkingSpot);
            },
            child: Card(
              child: Column(
                children: [
                  Text('${parkingSpot.id}'),
                  Text('Time: ${parkingSpot.hours} hours'),
                  Text('\$${parkingSpot.price}'),
                  ElevatedButton(
                    onPressed: () {
                      bookParkingSpot(parkingSpot);
                    },
                    child: Text('Book'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildHourDropdown() {
    return DropdownButton<int>(
      value: selectedHours,
      onChanged: (value) {
        setState(() {
          selectedHours = value!;
        });
      },
      items: List.generate(
        24,
        (index) => DropdownMenuItem<int>(
          value: index + 1,
          child: Text('$index hours'),
        ),
      ),
    );
  }

  Widget buildTimeDisplay() {
    DateTime now = DateTime.now();
    String formattedTime = '${now.hour}:${now.minute}:${now.second}';
    return Text('Current Time: $formattedTime');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parking Booking System'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Select Hours: '),
              buildHourDropdown(),
            ],
          ),
          SizedBox(height: 10),
          buildTimeDisplay(),
          SizedBox(height: 10),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Available Parking Spots',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      buildParkingSpotGrid(availableParkingSpots),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Booked Parking Spots',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      buildParkingSpotGrid(bookedParkingSpots),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendBookingDataToFirebase,
        child: Icon(Icons.send),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ParkingBookingScreen(),
  ));
}
