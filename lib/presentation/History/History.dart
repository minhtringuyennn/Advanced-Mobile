import 'package:advanced_mobile/main.dart';
import 'package:advanced_mobile/presentation/Home/Home.dart';
import 'package:advanced_mobile/presentation/Schedule/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../repository/schedule-student-repository.dart';
import '../Courses/Courses.dart';
import '../Schedule/Schedule.dart';

class History extends StatelessWidget {
  const History(this.loginCallback, {super.key});
  final LoginCallback loginCallback;
  @override
  Widget build(BuildContext context) {
    MyScheduleChangeNotifier mySchedule =
        context.watch<MyScheduleChangeNotifier>();

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
                  MaterialPageRoute(builder: (context) => Home(loginCallback)),
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
                  MaterialPageRoute(
                      builder: (context) => Courses(loginCallback)),
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
                  MaterialPageRoute(
                      builder: (context) => Schedule(loginCallback)),
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
                  MaterialPageRoute(
                      builder: (context) => History(loginCallback)),
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
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Schedule(loginCallback)),
                );
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
              )),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(25),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SvgPicture.asset(
              'images/history.svg', // Replace with the path to your SVG file
              // Adjust the height as needed
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "History",
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
                      "The following is a list of lessons you have attended",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                        "You can review the details of the lessons you have attended",
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
                // Session(
                //   typeSession: "History", schedule:mySchedule.mySchedule[0]
                // ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
