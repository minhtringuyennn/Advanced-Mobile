import 'package:advanced_mobile/common/loading.dart';
import 'package:advanced_mobile/presentation/Home/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pagination_flutter/pagination.dart';
import 'package:provider/provider.dart';

import '../../Provider/auth_provider.dart';
import '../../model/schedule/booking_infor.dart';
import '../../repository/schedule-student-repository.dart';
import '../../services/booking.api.dart';
import '../Courses/Courses.dart';
import '../Schedule/Schedule.dart';
import '../Schedule/session.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<BookingInfo> listHistoryLesson = [];
  bool isCallApi = false;
  bool loading = true;

  //Pagination
  int _numPages = 1;
  int _currentPage = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    if (!isCallApi) {
      callApiGetHistoryLesson(1, BookingRepository(), authProvider);
    }
  }

  Future<void> refreshSchedule() async {
    setState(() {
      listHistoryLesson = [];
      loading = true;
    });
    await Future.wait([
      callApiGetHistoryLesson(1, BookingRepository(),
          Provider.of<AuthProvider>(context, listen: false)),
    ]).whenComplete(() {
      setState(() {
        loading = false;
      });
      return Future<void>.delayed(const Duration(seconds: 0));
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
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
                  var authProvider =
                      Provider.of<AuthProvider>(context, listen: false);
                  authProvider.clearUserInfo();
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
        body: RefreshIndicator(
          onRefresh: () async {
            refreshSchedule();
          },
          child: loading
              ? Loading()
              : SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(25),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "History",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
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
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: listHistoryLesson?.length,
                            itemBuilder: (context, index) {
                              return Session(
                                  typeSession: "History",
                                  schedule: listHistoryLesson[index]);
                              // Add more customization here if needed
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            visible: _numPages > 1,
                            child: Container(
                              alignment: Alignment.center,
                              child: Pagination(
                                numOfPages: _numPages,
                                selectedPage: _currentPage,
                                pagesVisible: 3,
                                onPageChanged: (page) {
                                  setState(() {
                                    loading = true;
                                    _currentPage = page;
                                  });

                                  callApiGetHistoryLesson(
                                      page, BookingRepository(), authProvider);
                                },
                                nextIcon: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.blue,
                                  size: 14,
                                ),
                                previousIcon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.blue,
                                  size: 14,
                                ),
                                activeTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                                activeBtnStyle: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.blue),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                                inactiveBtnStyle: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  )),
                                ),
                                inactiveTextStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          )
                        ]),
                  ),
                ),
        ));
  }

  Future<void> callApiGetHistoryLesson(int page,
      BookingRepository bookingRepository, AuthProvider authProvider) async {
    await bookingRepository.getHistoryLesson(
        accessToken: authProvider.token?.access?.token ?? "",
        page: page,
        perPage: 10,
        now: DateTime.now().millisecondsSinceEpoch.toString(),
        onSuccess: (response, total) async {
          listHistoryLesson = [];

          for (var value in response) {
            if (value.isDeleted != true) {
              listHistoryLesson.add(value);
            }
          }

          setState(() {
            _numPages = total;
            isCallApi = true;
            loading = false;
          });
        },
        onFail: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.toString()}')),
          );
        });
  }
}
