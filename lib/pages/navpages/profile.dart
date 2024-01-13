import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tourist_guide/models/personaldetail.dart';
import 'package:tourist_guide/pages/home_page.dart'; // Import the homepage

class PersonalPage extends StatefulWidget {
  final Detail? detail;
  const PersonalPage({Key? key, this.detail}) : super(key: key);

  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isEditing = true;

  @override
  void initState() {
    super.initState();
    if (widget.detail != null) {
      // Populate text fields with existing details if available
      usernameController.text = widget.detail!.username;
      emailController.text = widget.detail!.email;
      phoneController.text = widget.detail!.phone;
      isEditing = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              // Navigate to the homepage
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://i.pinimg.com/564x/a0/53/1f/a0531f6459cd83419ad3619136b468c1.jpg',
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://i.pinimg.com/564x/bc/17/ce/bc17ce9c542f0c91708b4d767ea673cb.jpg',
                ),
              ),
              SizedBox(height: 20),
              buildEditableTextField(usernameController, 'Username', isEditing),
              SizedBox(height: 10),
              buildEditableTextField(emailController, 'Email', isEditing),
              SizedBox(height: 10),
              buildEditableTextField(phoneController, 'Phone', isEditing),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isEditing ? saveDetails : null,
                child: Text('Save', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEditableTextField(
      TextEditingController controller, String labelText, bool isEditing) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        fillColor: Colors.white,
        filled: true,
        suffix: !isEditing
            ? Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  controller.text,
                  style: TextStyle(fontSize: 14),
                ),
              )
            : null,
      ),
      style: TextStyle(fontSize: 16),
      enabled: isEditing,
    );
  }

  void saveDetails() async {
    try {
      final url = Uri.https(
        'hensem-f1a58-default-rtdb.asia-southeast1.firebasedatabase.app',
        'personaldetail.json',
      );

      final response = await http.post(
        url,
        body: json.encode({
          'username': usernameController.text,
          'email': emailController.text,
          'phone': phoneController.text,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          isEditing = false;
        });

        showSuccessDialog();
        print('Details saved successfully!');
      } else {
        print('Failed to save details. Error: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Details saved successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: PersonalPage(),
    ),
  );
}
