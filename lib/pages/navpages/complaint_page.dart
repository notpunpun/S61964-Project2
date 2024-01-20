import 'package:flutter/material.dart';
import 'package:tourist_guide/models/complaint.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tourist_guide/pages/home_page.dart';
import 'package:tourist_guide/pages/navpages/profile.dart';

class ComplaintPage extends StatefulWidget {
  final Complaint? complaint;
  const ComplaintPage({Key? key, this.complaint});

  @override
  _ComplaintPageState createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  final TextEditingController _complaintController = TextEditingController();
  String submittedComplaint = '';
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.complaint != null) {
      _complaintController.text = widget.complaint!.complaint;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://i.pinimg.com/564x/e2/d5/84/e2d584447f92f0aced0c632779b00a07.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Please describe your complaint:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _complaintController,
                  maxLines: 5,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.4),
                    border: OutlineInputBorder(),
                    hintText: 'Type your complaint here...',
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String complaint = _complaintController.text;
                    sendComplaintToFirebase(complaint);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 180, 71, 171),
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 0,
        selectedFontSize: 0,
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });

          switch (index) {
            case 0:
              // Already on the complaint page, do nothing
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PersonalPage()),
              );
              break;
          }
        },
        currentIndex: currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showUnselectedLabels: false,
        showSelectedLabels: false,
        elevation: 0,
        items: [
          BottomNavigationBarItem(label: "Bar", icon: Icon(Icons.message)),
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "My", icon: Icon(Icons.person)),
        ],
      ),
    );
  }

  void sendComplaintToFirebase(String complaint) async {
    try {
      final url = Uri.https(
        'hensem-f1a58-default-rtdb.asia-southeast1.firebasedatabase.app',
        'complaints.json',
      );

      final response = await http.post(
        url,
        body: json.encode({'complaint': complaint}),
      );

      if (response.statusCode == 200) {
        print('Complaint submitted successfully!');
        // Optionally, you can show a success message or navigate to another screen.
        // Example: ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Complaint submitted!')));

        // Show a pop-up dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Complaint submitted successfully!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5), // Adjust padding here
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                          255, 192, 83, 212), // Button color
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.white, // Button text color
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      } else {
        print('Failed to submit complaint. Error: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  void dispose() {
    _complaintController.dispose();
    super.dispose();
  }
}
