import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ParkingID {
  final String id;

  ParkingID({
    required this.id,
  });

  factory ParkingID.fromJson(Map<String, dynamic> json) {
    return ParkingID(
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Parking Id': id,
    };
  }
}

class ParkingUtilizationService {
  final int numRows;
  final int numCols;
  final List<List<ParkingID>> gridIds;

  ParkingUtilizationService({
    required this.numRows,
    required this.numCols,
  }) : gridIds = _generateGridIds(numRows, numCols);

  static List<List<ParkingID>> _generateGridIds(int numRows, int numCols) {
    List<List<ParkingID>> ids = [];
    for (int i = 0; i < numRows; i++) {
      List<ParkingID> rowIds = [];
      for (int j = 0; j < numCols; j++) {
        String rowChar = String.fromCharCode('a'.codeUnitAt(0) + i);
        String colNumber = (j + 1).toString();
        String id = '$rowChar$colNumber';
        rowIds.add(ParkingID(id: id));
      }
      ids.add(rowIds);
    }
    return ids;
  }

  double calculateUtilizationRate(int row, int col) {
    return 1; // Example utilization rate (80%)
  }
}

class ParkingUtilizationWidget extends StatefulWidget {
  final ParkingUtilizationService utilizationService;

  ParkingUtilizationWidget({
    required this.utilizationService,
  });

  @override
  _ParkingUtilizationWidgetState createState() =>
      _ParkingUtilizationWidgetState();
}

class _ParkingUtilizationWidgetState extends State<ParkingUtilizationWidget> {
  List<List<bool>> isBooked = [];
  double totalUtilization = 0.0;

  @override
  void initState() {
    super.initState();
    initializeIsBooked();
  }

  void initializeIsBooked() {
    for (int i = 0; i < widget.utilizationService.numRows; i++) {
      List<bool> rowList = [];
      for (int j = 0; j < widget.utilizationService.numCols; j++) {
        rowList.add(false);
      }
      isBooked.add(rowList);
    }
  }

  Future<void> _showConfirmationDialog(int row, int col) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Booking'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you want to book this parking space?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Book'),
              onPressed: () async {
                await bookParking(row, col);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeleteConfirmationDialog(int row, int col) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete Booking'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Do you want to delete the booking for this parking space?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () async {
                await deleteBooking(row, col);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> bookParking(int row, int col) async {
    if (!isBooked[row][col]) {
      // Get the parking ID
      String parkingId = widget.utilizationService.gridIds[row][col].id;

      // Make an HTTP request to add the booked parking ID to Firebase
      final response = await http.post(
        Uri.parse(
            'https://hensem-f1a58-default-rtdb.asia-southeast1.firebasedatabase.app/booked_parking_ids.json'),
        body: jsonEncode({
          'parking_id': parkingId,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          isBooked[row][col] = true;
          totalUtilization +=
              widget.utilizationService.calculateUtilizationRate(row, col);
        });
      } else {
        print('Failed to book parking space. Error: ${response.reasonPhrase}');
      }
    }
  }

  Future<void> deleteBooking(int row, int col) async {
    if (isBooked[row][col]) {
      // Get the parking ID
      String parkingId = widget.utilizationService.gridIds[row][col].id;

      // Make an HTTP request to remove the booked parking ID from Firebase
      final response = await http.delete(
        Uri.parse(
            'https://hensem-f1a58-default-rtdb.asia-southeast1.firebasedatabase.app/booked_parking_ids/$parkingId.json'),
      );

      if (response.statusCode == 200) {
        setState(() {
          isBooked[row][col] = false;
          totalUtilization -=
              widget.utilizationService.calculateUtilizationRate(row, col);
        });
      } else {
        print('Failed to delete booking. Error: ${response.reasonPhrase}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parking Utilization'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Average Utilization Rate: ${(totalUtilization / (widget.utilizationService.numRows * widget.utilizationService.numCols)).toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Parking Grid',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.utilizationService.numCols,
              ),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                int row = index ~/ widget.utilizationService.numCols;
                int col = index % widget.utilizationService.numCols;
                double utilizationRate = widget.utilizationService
                    .calculateUtilizationRate(row, col);
                ParkingID parkingID =
                    widget.utilizationService.gridIds[row][col];
                return ParkingCellWidget(
                  utilizationRate: utilizationRate,
                  isBooked: isBooked[row][col],
                  parkingID: parkingID,
                  onTap: () {
                    if (!isBooked[row][col]) {
                      _showConfirmationDialog(row, col);
                    }
                  },
                  onLongPress: () {
                    if (isBooked[row][col]) {
                      _showDeleteConfirmationDialog(row, col);
                    }
                  },
                );
              },
              itemCount: widget.utilizationService.numRows *
                  widget.utilizationService.numCols,
            ),
          ],
        ),
      ),
    );
  }
}

class ParkingCellWidget extends StatelessWidget {
  final double utilizationRate;
  final bool isBooked;
  final ParkingID parkingID;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  ParkingCellWidget({
    required this.utilizationRate,
    required this.isBooked,
    required this.parkingID,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isBooked ? Colors.red : Colors.green,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isBooked
                  ? 'Reserved'
                  : 'Utilization: ${utilizationRate.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              'ID: ${parkingID.id}',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  ParkingUtilizationService utilizationService =
      ParkingUtilizationService(numRows: 4, numCols: 3);
  runApp(
    MaterialApp(
      home: ParkingUtilizationWidget(
        utilizationService: utilizationService,
      ),
    ),
  );
}
