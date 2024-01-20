// // parking_location_page.dart

// import 'package:flutter/material.dart';
// import 'package:tourist_guide/pages/parking_page.dart';
// import 'package:tourist_guide/models/update_parking.dart';

// class ParkingLocationPage extends StatefulWidget {
//   const ParkingLocationPage({Key? key}) : super(key: key);

//   @override
//   _ParkingLocationPageState createState() => _ParkingLocationPageState();
// }

// class ParkingLocation {
//   final String name;
//   double pricePerHour;

//   ParkingLocation({required this.name, required this.pricePerHour});
// }

// class _ParkingLocationPageState extends State<ParkingLocationPage> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();

//   List<ParkingLocation> parkingLocations = [
//     ParkingLocation(name: "KTCC", pricePerHour: 0.80),
//     ParkingLocation(name: "Paya Bunga", pricePerHour: 1.00),
//     ParkingLocation(name: "Dataran Austin", pricePerHour: 0.60),
//   ];

//   void addOrUpdateLocation() {
//     String name = nameController.text;
//     double price = double.parse(priceController.text);

//     bool locationExists =
//         parkingLocations.any((location) => location.name == name);

//     setState(() {
//       if (locationExists) {
//         int index =
//             parkingLocations.indexWhere((location) => location.name == name);
//         parkingLocations[index].pricePerHour = price;
//       } else {
//         parkingLocations.add(ParkingLocation(name: name, pricePerHour: price));
//       }

//       nameController.clear();
//       priceController.clear();
//     });
//   }

//   void navigateToSessionPage() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ParkingPage(
//           onSubmit: submitSession,
//           locationNames:
//               parkingLocations.map((location) => location.name).toList(),
//         ),
//       ),
//     );
//   }

//   void submitSession(ParkingLocation? submittedLocation) {
//     if (submittedLocation != null) {
//       // Handle the submitted location data here
//       print('Submitted Location: $submittedLocation');
//     } else {
//       print('No location submitted.');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Parking Locations'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               'Add/Update Parking Location',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               controller: nameController,
//               decoration: InputDecoration(
//                 labelText: 'Location Name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: priceController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: 'Price per Hour',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: addOrUpdateLocation,
//               child: Text('Add/Update Location'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: navigateToSessionPage,
//               child: Text('Go to Session Page'),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Parking Locations',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             if (parkingLocations.isNotEmpty) ...{
//               for (var location in parkingLocations)
//                 ListTile(
//                   title: Text(location.name),
//                   subtitle: Text(
//                       'Price per Hour: \$${location.pricePerHour.toStringAsFixed(2)}'),
//                 ),
//             } else
//               Text('No parking locations added.'),
//           ],
//         ),
//       ),
//     );
//   }
// }
