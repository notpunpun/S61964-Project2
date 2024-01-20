import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/models/session.dart';
import 'package:tourist_guide/pages/AdPages/admin_home_page.dart';
import 'package:tourist_guide/pages/AdPages/manage_parking.dart';
import 'package:tourist_guide/pages/edit_parking.dart';
//import 'package:tourist_guide/pages/detail_page.dart';
//import 'package:tourist_guide/pages/navpages/main_page.dart';
//import 'package:tourist_guide/pages/welcome_page.dart';
import 'package:tourist_guide/pages/home_page.dart';
import 'package:tourist_guide/pages/login_page.dart';
import 'package:tourist_guide/pages/navpages/complaint_page.dart';
import 'package:tourist_guide/pages/navpages/profile.dart';
//import 'package:tourist_guide/pages/login_page.dart';
import 'package:tourist_guide/pages/navpages/seat_booking.dart';
import 'package:tourist_guide/pages/parking_page.dart';
import 'package:tourist_guide/pages/signup_page.dart';
import 'package:tourist_guide/pages/log_out.dart';
import 'package:tourist_guide/widgets/reviews_slider.dart';
import 'package:tourist_guide/pages/parking_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUpPage(),
    );
  }
}
