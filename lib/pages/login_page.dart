import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tourist_guide/pages/signup_page.dart';
import 'package:tourist_guide/pages/home_page.dart';
import 'package:tourist_guide/pages/adpages/admin_home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String selectedRole = 'User';
  bool _isLoading = false;

  Future<void> handleLogin(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });

      // Simulated login data
      final Map<String, dynamic> usersJson = {
        'user1': {
          'email': 'user1@example.com',
          'password': 'password1',
          'role': 'User'
        },
        'admin1': {
          'email': 'admin1@example.com',
          'password': 'adminpassword1',
          'role': 'Admin'
        },
      };

      bool checkLogin = false;
      String role = '';

      usersJson.forEach((key, value) {
        if (value['email'] == emailController.text &&
            value['password'] == passwordController.text) {
          print("User found in the database");
          role = value['role'].toString();
          checkLogin = true;
        }
      });

      if (checkLogin) {
        Future.delayed(Duration.zero, () {
          if (role == 'Admin' && selectedRole == 'Admin') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminHomePage()),
            );
          } else if (role == 'User' && selectedRole == 'User') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else {
            print('Invalid role selected for the user.');
          }
        });
      } else {
        print('Invalid login credentials.');
      }
    } catch (e) {
      print('Error during login: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Email TextField
              Container(
                width: w * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 7,
                      offset: Offset(1, 1),
                      color: Colors.grey.withOpacity(0.4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
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

              // Password TextField
              Container(
                width: w * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 7,
                      offset: Offset(1, 1),
                      color: Colors.grey.withOpacity(0.4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock,
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

              // Role DropdownButton
              Container(
                width: w * 0.8,
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 7,
                      offset: Offset(1, 1),
                      color: Colors.grey.withOpacity(0.4),
                    ),
                  ],
                ),
                child: DropdownButton<String>(
                  value: selectedRole,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRole = newValue!;
                    });
                  },
                  items:
                      <String>['User', 'Admin'].map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              // SignIn Button
              Container(
                width: w * 0.5,
                height: h * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://i.pinimg.com/736x/c6/21/ec/c621ec370df60e6f39674cb3661d1813.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: TextButton(
                  onPressed: _isLoading ? null : () => handleLogin(context),
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),

              SizedBox(
                height: w * 0.2,
              ),

              // Sign Up Link
              RichText(
                text: TextSpan(
                  text: "Don\'t have an account?",
                  style: TextStyle(color: Colors.grey[500], fontSize: 18),
                  children: [
                    TextSpan(
                      text: " Create",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpPage(),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: LoginPage()));
}
