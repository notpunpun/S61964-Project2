import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/pages/login_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tourist_guide/models/user.dart';

class SignUpPage extends StatefulWidget {
  final User? user;
  const SignUpPage({Key? key, this.user});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  void _navigateToLoginPage(BuildContext context, User user) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage(user: user)),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();
  late TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void handleSignUp() async {
    try {
      final url = Uri.https(
        'hensem-f1a58-default-rtdb.asia-southeast1.firebasedatabase.app',
        'users.json',
      );

      final response = await http.post(
        url,
        body: json.encode({
          'email': _emailController.text,
          'password': _passwordController.text,
          'phoneNumber': _phoneNumberController.text,
        }),
      );

      if (response.statusCode == 200) {
        print('Debug data sent to Firebase');
        // Create a User object with the entered data
        User newUser = User(
          email: _emailController.text,
          password: _passwordController.text,
          phone: _phoneNumberController.text,
        );
        // Navigate to login page with the user data
        _navigateToLoginPage(context, newUser);
      } else {
        print('Failed to send data to Firebase');
      }
    } catch (e) {
      print('Debug error = $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List images = [
      'https://i.pinimg.com/474x/6e/a2/2f/6ea22f0f8cd31cdc1835ead0e6b32994.jpg',
      'https://i.pinimg.com/474x/45/20/dd/4520ddfc56208707045c56232e946f7f.jpg',
      'https://i.pinimg.com/474x/8d/f5/e7/8df5e76136dcba44841002494e01e050.jpg',
    ];

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Background
          Container(
            width: w,
            height: h * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://i.pinimg.com/564x/e1/71/3c/e1713cc433898e6aa106274c87056aea.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: h * 0.14,
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 60,
                  backgroundImage: NetworkImage(
                    'https://i.pinimg.com/564x/e3/c9/a9/e3c9a9e5934d65cff25d83a2ac655230.jpg',
                  ),
                )
              ],
            ),
          ),

          // Hello
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            width: w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 45,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 7,
                        offset: Offset(1, 1),
                        color: Colors.grey.withOpacity(0.4),
                      )
                    ],
                  ),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email ',
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.deepOrangeAccent,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 7,
                        offset: Offset(1, 1),
                        color: Colors.grey.withOpacity(0.4),
                      )
                    ],
                  ),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(
                        Icons.password_outlined,
                        color: Colors.deepOrangeAccent,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 7,
                        offset: Offset(1, 1),
                        color: Colors.grey.withOpacity(0.4),
                      )
                    ],
                  ),
                  child: TextField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.deepOrangeAccent,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 70,
          ),

          // Sign Up button
          GestureDetector(
            onTap: () {
              print("button clicked");
              handleSignUp(); // Call the signup method
            },
            child: Container(
              width: w * 0.5,
              height: h * 0.08,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://i.pinimg.com/564x/be/4a/67/be4a678a95ff169aebf228d43ef2fc92.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 10),

          // RichText for "Have an account?" with onTap event
          RichText(
            text: TextSpan(
              recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
              text: 'Have an account?',
              style: TextStyle(fontSize: 16, color: Colors.grey[500]),
            ),
          ),
          SizedBox(height: 10),

          // RichText for "Sign up using"
          RichText(
            text: TextSpan(
              text: "Sign up using",
              style: TextStyle(color: Colors.grey[500], fontSize: 16),
            ),
          ),

          // Wrap for social media icons
          Wrap(
            children: List<Widget>.generate(3, (index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white54,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(images[index]),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
