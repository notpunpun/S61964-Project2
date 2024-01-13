import 'package:flutter/material.dart';
import 'login_page.dart'; // Import your login page

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    'https://i.pinimg.com/564x/23/86/84/2386849a71c7f23d310e35331d84a33c.jpg',
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 70,
          ),

          Container(
            width: w,
            margin: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sign Out',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  'you have signed out',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 200,
          ),

          // Button
          Container(
            width: w * 0.5,
            height: h * 0.08,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 175, 140, 236), // Button color
                onPrimary: Colors.white, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Sign out',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
