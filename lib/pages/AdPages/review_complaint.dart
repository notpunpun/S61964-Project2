import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tourist_guide/models/review_complaint.dart';
import 'package:tourist_guide/pages/navpages/complaint_page.dart'; // Import your model

class ReviewComplaintPage extends StatefulWidget {
  @override
  _ReviewComplaintPageState createState() => _ReviewComplaintPageState();
}

class _ReviewComplaintPageState extends State<ReviewComplaintPage> {
  List<ReviewComplaint> complaints = [];

  @override
  void initState() {
    super.initState();
    fetchComplaints();
  }

  Future<void> fetchComplaints() async {
    try {
      final url = Uri.https(
        'hensem-f1a58-default-rtdb.asia-southeast1.firebasedatabase.app',
        'complaints.json',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final complaintList = data.values
            .map<ReviewComplaint>((json) => ReviewComplaint.fromJson(json))
            .toList();

        setState(() {
          complaints = complaintList;
        });
      } else {
        print('Failed to fetch complaints. Error: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> _refreshComplaints() async {
    await fetchComplaints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Complaints'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshComplaints,
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'User Complaints:',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: complaints.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 3.0,
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          complaints[index].complaint,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ComplaintPage()),
                  );
                },
                child: Text('Go to Complaint Page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
