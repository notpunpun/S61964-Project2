import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/main.dart';
import 'package:tourist_guide/pages/home_page.dart';
// import 'package:tourist_guide/pages/navpages/my_page.dart';
import 'package:tourist_guide/pages/navpages/profile.dart';

class BarItem extends StatelessWidget {
  const BarItem({Key? key}) : super(key: key);
  final int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bar Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              // Navigate to the HomePage
              Get.off(() => HomePage());
            },
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: Text("Bar Page"),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 0,
        selectedFontSize: 0,
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.white,
        onTap: (index) {
          // Handle navigation based on the selected index
          switch (index) {
            case 0:
              // Navigate to Home page
              Get.off(() => BarItem());
              break;
            case 1:
              // Navigate to Bar page
              Get.off(() => HomePage());
              break;
            case 2:
              // Navigate to My page
              Get.off(() => PersonalPage());
              break;
            // Add more cases if you have additional items
          }
        },
        currentIndex: currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showUnselectedLabels: false,
        showSelectedLabels: false,
        elevation: 0,
        items: [
          BottomNavigationBarItem(label: "Bar", icon: Icon(Icons.bar_chart)),
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          //BottomNavigationBarItem(label: "Search", icon: Icon(Icons.search)),
          BottomNavigationBarItem(label: "My", icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
