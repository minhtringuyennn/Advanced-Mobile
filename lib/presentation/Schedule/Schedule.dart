import 'package:advanced_mobile/presentation/History/History.dart';
import 'package:advanced_mobile/presentation/Schedule/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Courses/Courses.dart';
import '../Home/Home.dart';

class Schedule extends StatelessWidget {
  const Schedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 125,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue, border: null),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.close_outlined,
                              color: Colors.white,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Text(
                            "Menu",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.people_alt,
                  color: Colors.blue.shade700,
                  size: 30,
                ),
                title: const Text(
                  'Tutors',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.school,
                  color: Colors.blue.shade700,
                  size: 30,
                ),
                title: const Text(
                  'Courses',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Courses()),
                  );
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.calendar_month,
                  color: Colors.blue.shade700,
                  size: 30,
                ),
                title: const Text(
                  'Schedule',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Schedule()),
                  );
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.history,
                  color: Colors.blue.shade700,
                  size: 30,
                ),
                title: const Text(
                  'History',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => History()),
                  );
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.blue.shade700,
                  size: 30,
                ),
                title: const Text('Logout',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        appBar: PreferredSize(
          preferredSize:
              const Size.fromHeight(50.0), // Define the height of the AppBar
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(0.2), // Color and opacity of the shadow
                  spreadRadius: 5, // Spread radius of the shadow
                  blurRadius: 7, // Blur radius of the shadow
                  offset: const Offset(0, 3), // Offset of the shadow
                ),
              ],
            ),
            child: AppBar(
                automaticallyImplyLeading: false,
                systemOverlayStyle: const SystemUiOverlayStyle(
                  // Status bar color
                  statusBarColor: Colors.black,
                  // Status bar brightness (optional)
                  statusBarIconBrightness:
                      Brightness.light, // For Android (dark icons)
                ),
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.school,
                          size: 45,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(width: 7),
                        Text(
                          "LetTutor",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                )

                // Replace 'assets/icon.png' with your image path

                ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(25),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: Colors.blueAccent,
                    size: 130,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Schedule",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 20),
                    decoration: BoxDecoration(
                        border: Border(
                      left: BorderSide(
                        color: Colors.grey, // Color of the left border
                        width: 2.5, // Width of the left border
                      ),
                    )),
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Here is a list of the sessions you have booked",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                              "You can track when the meeting starts, join the meeting with one click or can cancel the meeting before 2 hours",
                              style: TextStyle(fontSize: 16)),
                        ]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Session(
                          typeSession: "Schedule", time_or_number: '1 lesson'),
                      Session(
                        typeSession: "Schedule",
                        time_or_number: "1 lesson",
                      ),
                    ],
                  ),
                ]),
          ),
        ));
  }
}
