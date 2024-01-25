import 'package:advanced_mobile/Provider/auth_provider.dart';
import 'package:advanced_mobile/common/loading.dart';
import 'package:advanced_mobile/presentation/Courses/filter.dart';
import 'package:advanced_mobile/presentation/Courses/search.dart';
import 'package:advanced_mobile/presentation/History/History.dart';
import 'package:advanced_mobile/presentation/Home/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../model/course-dto.dart';
import '../../model/course/course_model.dart';
import '../../services/course.api.dart';
import '../Schedule/Schedule.dart';
import 'content.dart';

typedef FilterCourseCallback = void Function(String sort, List<String> level);
typedef SearchCourseCallback = void Function(String keyword);

class Courses extends StatefulWidget {
  const Courses({super.key});

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  //Searh
  String keyword = "";
  String sort = "";
  List<String> level = [];

  //API
  List<CourseDTO> courses = [];

  bool isCallApi = false;
  bool isLoading = true;
  Map<String, List<CourseModel>> groupedCourses = {};

  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    var authProvider = Provider.of<AuthProvider>(context);

    //Fetch API
    if (!isCallApi) {
      setState(() {
        isLoading = true;
      });
      await Future.wait([
        callAPIGetCourseList(
            1, CourseRepository(), authProvider, keyword, sort, level)
      ]).whenComplete(() {
        if (mounted) {
          setState(() {
            isCallApi = true;
            isLoading = false;
          });
        }
      });
    }
  }

  Future<void> refreshHome(AuthProvider authProvider) async {
    setState(() {
      courses = [];
      groupedCourses = {};
      isLoading = true;
    });
    await Future.wait([
      callAPIGetCourseList(
          1, CourseRepository(), authProvider, keyword, sort, level)
    ]).whenComplete(() {
      setState(() {
        isLoading = false;
      });
      return Future<void>.delayed(const Duration(seconds: 0));
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    void filterCallback(String sort, List<String> level) {
      String realSort = "";
      switch (sort) {
        case '':
          realSort = "";
          break;
        case "Level ascending":
          realSort = "ASC";
          break;
        case "Level decreasing":
          realSort = "DESC";
          break;
      }

      setState(() {
        sort = realSort;
        level = level;
      });
      callAPIGetCourseList(
          1, CourseRepository(), authProvider, keyword, sort, level);
    }

    void searchCourseCallback(String keyword) {
      setState(() {
        keyword = keyword;
      });
      callAPIGetCourseList(
          1, CourseRepository(), authProvider, keyword, sort, level);
    }

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
            refreshHome(authProvider);
          },
          child: isLoading
              ? Loading()
              : SingleChildScrollView(
                  child: Container(
                  padding: EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SearchCourse(searchCourseCallback),
                      Filter(filterCallback),
                      SizedBox(height: 20),
                      Content(courses, groupedCourses),
                      SizedBox(height: 10),
                    ],
                  ),
                )),
        ));
  }

  Future<void> callAPIGetCourseList(
      int page,
      CourseRepository courseRepository,
      AuthProvider authProvider,
      String keyword,
      String sort,
      List<String> level) async {
    await courseRepository.getCourseListWithPagination(
        accessToken: authProvider.token?.access?.token ?? "",
        search: keyword,
        sort: sort,
        level: level,
        page: page,
        size: 100,
        onSuccess: (response, total) async {
          Map<String, List<CourseModel>> groupedCoursesTemp = {};

          for (CourseModel course in response) {
            if (groupedCoursesTemp.containsKey(course.categories![0].title)) {
              groupedCoursesTemp[course.categories![0].title]!.add(course);
            } else {
              groupedCoursesTemp[course.categories![0].title!] = [course];
            }
          }
          setState(() {
            groupedCourses = groupedCoursesTemp;
            isCallApi = true;
            isLoading = false;
          });
        },
        onFail: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.toString()}')),
          );
        });
  }
}
