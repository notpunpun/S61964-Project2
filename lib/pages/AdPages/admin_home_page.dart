import 'package:flutter/material.dart';
import 'manage_parking.dart'; // Import your ManageParking page
import 'review_complaint.dart'; // Import your ReviewComplaint page
import 'package:tourist_guide/pages/log_out.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Home Page'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://i.pinimg.com/564x/e2/63/96/e26396967b75284daf00ffe9c56a8812.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome, Admin!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ManageParkingPage()),
                  );
                },
                child: Text('Manage Parking'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReviewComplaintPage()),
                  );
                },
                child: Text('Review Complaints'),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  // Perform logout action here
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomePage()),
                  );
                },
                icon: Icon(Icons.power_settings_new),
                label: Text('Log Out'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // Set the button color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
