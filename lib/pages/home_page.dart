import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tourist_guide/pages/navpages/complaint_page.dart';
import 'package:tourist_guide/pages/navpages/profile.dart';
import 'package:tourist_guide/pages/parking_page.dart';
import 'package:tourist_guide/models/session.dart';
import 'package:tourist_guide/pages/log_out.dart';

void main() {
  runApp(MyApp());
}

class ParkingLocation {
  final String name;

  ParkingLocation({required this.name});
}

class AppColors {
  static const Color mainColor = Colors.blue;
}

class AppLargeText extends StatelessWidget {
  final String text;
  final Color color;

  const AppLargeText({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({required Color color, required double radius})
      : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _painter;
  }
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius - 5);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parking App',
      initialRoute: '/',
      routes: {
        '/complaint': (context) => ComplaintPage(),
        '/personal': (context) => PersonalPage(),
        '/logout': (context) => WelcomePage(),
      },
      onGenerateRoute: (settings) {
        // You can handle dynamic routes here if needed
        // For example: /user/:id
        // Parse the settings.name and return a corresponding page
      },
      onUnknownRoute: (settings) {
        // Handle unknown routes here
        return MaterialPageRoute(builder: (context) => NotFoundPage());
      },
    );
  }
}

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Not Found'),
      ),
      body: Center(
        child: Text('Uh-oh'),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  int currentIndex = 1;

  var car = [
    'https://lirp.cdn-website.com/md/unsplash/dms3rep/multi/opt/photo-1506521781263-d8422e82f27a-1920w.jpg',
    'https://i.pinimg.com/564x/20/1e/39/201e39e032e7764ec7f5d6e013bfb6b9.jpg',
    'https://i.pinimg.com/564x/2c/59/68/2c596892e7a259b6cca6cd4b89142a2d.jpg'
  ];

  List<ParkingLocation> parkingLocations = [
    ParkingLocation(name: "KTCC"),
    ParkingLocation(name: "Paya Bunga"),
    ParkingLocation(name: "Dataran Austin"),
  ];

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void onSubmitCallback(dynamic location) {
    if (location != null && location is ParkingLocation) {
      // Handle the submitted location data here
      print('Submitted Location: $location');
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void onTap(int index) {
    // Handle navigation based on the selected tab
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parking App'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Your Name'),
              accountEmail: Text('your.email@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text('Complaint Page'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComplaintPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Personal Page'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonalPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Log Out'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomePage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: AppLargeText(
              text: "Discover",
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20),
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                labelPadding: const EdgeInsets.only(left: 20, right: 20),
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicator:
                    CircleTabIndicator(color: AppColors.mainColor, radius: 4),
                tabs: [
                  Tab(text: "Parking"),
                  Tab(text: "Parking"),
                  Tab(text: "History"),
                ],
              ),
            ),
          ),
          // Display Selected Date
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}',
                  style: TextStyle(fontSize: 18),
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select Date'),
                ),
              ],
            ),
          ),
          // Display Selected Time
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected Time: ${selectedTime.format(context)}',
                  style: TextStyle(fontSize: 18),
                ),
                ElevatedButton(
                  onPressed: () => _selectTime(context),
                  child: Text('Select Time'),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20),
            height: 400,
            width: 700,
            child: TabBarView(
              controller: _tabController,
              children: [
                // Parking Tab
                ListView.builder(
                  itemCount: car.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        // Handle parking tab item click
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 15, top: 10),
                        width: 200,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          image: DecorationImage(
                            image: NetworkImage(car[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ParkingPage(
                                    onSubmit: onSubmitCallback,
                                    locationNames: parkingLocations
                                        .map((location) => location.name)
                                        .toList(),
                                    isAdmin:
                                        false, // Set the isAdmin value accordingly
                                  ),
                                ),
                              );
                            },
                            child: Text('Book Now'),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // Utilisation Tab
                // Add your content for Utilisation Tab here
                Container(
                  child: Center(
                    child: Text('CarParking price is based on utilisation'),
                  ),
                ),
                // History Tab
                // Add your content for History Tab here
                Container(
                  child: Center(
                    child: Text('You haven\'t booked yet!'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
