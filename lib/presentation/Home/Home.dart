import 'dart:async';

import 'package:advanced_mobile/model/schedule-dto.dart';
import 'package:advanced_mobile/model/tutor.dart';
import 'package:advanced_mobile/presentation/Courses/Courses.dart';
import 'package:advanced_mobile/presentation/History/History.dart';
import 'package:advanced_mobile/presentation/Home/searchTutor.dart';
import 'package:advanced_mobile/presentation/Schedule/Schedule.dart';
import 'package:advanced_mobile/presentation/VideoCall/VideoCallPage.dart';
import 'package:advanced_mobile/repository/schedule-student-repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../model/rate-dto.dart';
import 'listTutors.dart';

typedef FilterCallback = void Function(
    String filter, String nameTutor, List<String> nation);

class Home extends StatefulWidget {
  const Home(this.loginCallback, {super.key});
  final LoginCallback loginCallback;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  List<TutorDTO> tutorsFilter = [];
  List<TutorDTO> tutors = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print("huhu");

    Future.delayed(Duration.zero, () {
      filterCallback("All", "", []);
    });
  }

  void filterCallback(String filter, String nameTutor, List<String> nation) {
    List<TutorDTO> temp = [];
    if (filter == "All") {
      temp = tutors;
    } else {
      temp =
          tutors.where((tutor) => tutor.specialties.contains(filter)).toList();
    }

    if (!nation.isEmpty) {
      List<TutorDTO> filterOfNation = [];
      nation.forEach((element) {
        if (element == "Foreign Tutor") {
          filterOfNation = filterOfNation +
              temp
                  .where((tutor) =>
                      !tutor.country.contains("US") &&
                      !tutor.country.contains("England") &&
                      !tutor.country.contains("Vietnam"))
                  .toList();
        } else if (element == "Vietnamese Tutor") {
          filterOfNation = filterOfNation +
              temp.where((tutor) => tutor.country.contains("Vietnam")).toList();
        } else if (element == "Native English Tutor") {
          filterOfNation = filterOfNation +
              temp
                  .where((tutor) =>
                      tutor.country.contains("US") ||
                      tutor.country.contains("England"))
                  .toList();
        }
      });
      temp = filterOfNation;
    }
    temp = temp
        .where((tutor) =>
            tutor.name.toLowerCase().contains(nameTutor.toLowerCase()))
        .toList();

    setState(() {
      tutorsFilter = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    tutors = context.watch<List<TutorDTO>>();
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
                  MaterialPageRoute(
                      builder: (context) => Home(widget.loginCallback)),
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
                      builder: (context) => Courses(widget.loginCallback)),
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
                      builder: (context) => Schedule(widget.loginCallback)),
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
                      builder: (context) => History(widget.loginCallback)),
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
                widget.loginCallback(0);
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
              child: Column(children: [
        UpcomingLesson(mySchedule: mySchedule),
        SearchTutor(filterCallback),
        Divider(
          // Add a horizontal line
          color: Colors.grey, // Line color
          height: 10, // Line height
          thickness: 0.5, // Line thickness
          indent: 20, // Line indent on the left
          endIndent: 10, // Line indent on the right
        ),
        ListTutors(tutorsFilter),
      ]))),
    );
  }
}

class UpcomingLesson extends StatefulWidget {
  const UpcomingLesson({required this.mySchedule, super.key});
  final MyScheduleChangeNotifier mySchedule;

  @override
  State<UpcomingLesson> createState() => _UpcomingLessonState();
}

class _UpcomingLessonState extends State<UpcomingLesson>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int? timestamp;
  int? endstamp;
  late DateTime targetTime;
  late Timer countdownTimer;
  Duration remainingTime = Duration.zero;

  ScheduleDTO? upcomingLesson = null;

  bool compareTime(int time1, int time2) {
    DateTime dateTime1 = DateTime.fromMillisecondsSinceEpoch(time1);
    DateTime dateTime2 = DateTime.fromMillisecondsSinceEpoch(time2);

    // Thời điểm hiện tại
    DateTime now = DateTime.now();

    // Tính khoảng cách thời gian từ mỗi timestamp đến thời điểm hiện tại
    Duration difference1 = dateTime1.difference(now).abs();
    Duration difference2 = dateTime2.difference(now).abs();

    // So sánh khoảng cách thời gian
    if (difference1 < difference2) {
      return true;
    } else {
      return false;
    }
  }

  void updateRemainingTime() {
    DateTime now = DateTime.now();
    setState(() {
      remainingTime =
          targetTime.isAfter(now) ? targetTime.difference(now) : Duration.zero;
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.mySchedule.mySchedule.length != 0) {
      upcomingLesson = widget.mySchedule.mySchedule.reduce(
          (current, schedule) =>
              compareTime(schedule.startTimestamp, current.startTimestamp)
                  ? schedule
                  : current);

      timestamp = upcomingLesson?.startTimestamp;
      endstamp = upcomingLesson?.endTimestamp;
      targetTime = DateTime.fromMillisecondsSinceEpoch(timestamp!);
      DateTime now = DateTime.now();
      remainingTime =
          targetTime.isAfter(now) ? targetTime.difference(now) : Duration.zero;

      countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        updateRemainingTime();

        if (remainingTime <= Duration.zero) {
          timer.cancel();
        }
      });
    }
  }

  @override
  void dispose() {
    countdownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Color backgroundColor = Color.fromARGB(255, 12, 61, 223);
    int hours = 0;
    int minutes = 0;
    int seconds = 0;
    if (widget.mySchedule.mySchedule.length != 0) {
      hours = remainingTime.inHours;
      minutes = (remainingTime.inMinutes % 60);
      seconds = (remainingTime.inSeconds % 60);
    }

    String convertTimeToString(int time1, int time2) {
      DateTime timestart = DateTime.fromMillisecondsSinceEpoch(time1);
      DateTime timeend = DateTime.fromMillisecondsSinceEpoch(time2);

      String start =
          "${timestart.hour.toString().length == 1 ? "0" + timestart.hour.toString() : timestart.hour.toString()}:${timestart.minute.toString().length == 1 ? "0" + timestart.minute.toString() : timestart.minute.toString()}";
      String end =
          "${timeend.hour.toString().length == 1 ? "0" + timeend.hour.toString() : timeend.hour.toString()}:${timeend.minute.toString().length == 1 ? "0" + timeend.minute.toString() : timeend.minute.toString()}";
      String result = start + " - " + end;
      return result;
    }

    return Container(
      width: double.infinity,
      color: backgroundColor,
      padding: EdgeInsets.only(top: 40, bottom: 30),
      child: Column(
        children: [
          Text(
            widget.mySchedule.mySchedule.length == 0
                ? "You have no upcoming lesson."
                : "Upcoming lesson",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
          SizedBox(
            height: widget.mySchedule.mySchedule.length != 0 ? 20 : 0,
          ),
          Visibility(
            visible: widget.mySchedule.mySchedule.length != 0,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text(
                        DateFormat('EEEE, MMMM d').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                timestamp != null ? timestamp! : 0)),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        convertTimeToString(timestamp != null ? timestamp! : 0,
                            endstamp != null ? endstamp! : 0),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        "Start in ($hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')})",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.yellow),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // Đặt góc bo tròn
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VideoCallPage()),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.slow_motion_video,
                            color: Colors.blueAccent,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Enter lesson room",
                            style: TextStyle(
                                color: Colors.blueAccent, fontSize: 14),
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Total lesson time is 0 hours 0 minutes",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
