import 'dart:convert';

import 'package:advanced_mobile/model/account-dto.dart';
import 'package:advanced_mobile/model/tutor.dart';
import 'package:advanced_mobile/presentation/Courses/Courses.dart';
import 'package:advanced_mobile/presentation/History/History.dart';
import 'package:advanced_mobile/presentation/Home/Home.dart';
import 'package:advanced_mobile/presentation/Login/Login.dart';
import 'package:advanced_mobile/presentation/Schedule/Schedule.dart';
import 'package:advanced_mobile/presentation/Setting/Setting.dart';
import 'package:advanced_mobile/repository/favorite-repository.dart';
import 'package:advanced_mobile/repository/schedule-student-repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import 'model/course-dto.dart';
import 'model/user-dto.dart';

void main() {
  runApp(MyApp());
}

typedef LoginCallback = void Function(int _appState);

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Account account = Account(email: "", password: "");
  List<TutorDTO> listTutor = [];
  List<CourseDTO> listCourse = [];

  final mySchedule = new MyScheduleChangeNotifier();
  final favouriteRepository = new FavouriteRepository();
  late User userData;

  @override
  void initState() {
    // TODO: implement initState

    loadTutors();
    loadCourse();
    loadUser();
  }

  Future<void> loadUser() async {
    // Đọc dữ liệu từ file JSON
    User data;
    String jsonString = await rootBundle.loadString('assets/data/user.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);

    // Lấy danh sách tutors từ dữ liệu JSON
    Map<String, dynamic> userJson = {};

    if (jsonData['user'] != null) {
      userJson = Map<String, dynamic>.from(jsonData['user']);
    }
    print(userJson);
    userData = User.fromJson(userJson);
  }

  Future<void> loadCourse() async {
    // Đọc dữ liệu từ file JSON
    String jsonString = await rootBundle.loadString('assets/data/course.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);

    // Lấy danh sách tutors từ dữ liệu JSON
    List<Map<String, dynamic>> courseList = [];

    if (jsonData['data'] != null && jsonData['data']['rows'] is List) {
      courseList = List<Map<String, dynamic>>.from(jsonData['data']['rows']);
    }
    listCourse = courseList.map((json) => CourseDTO.fromJson(json)).toList();
  }

  Future<void> loadTutors() async {
    // Đọc dữ liệu từ file JSON
    String jsonString =
        await rootBundle.loadString('assets/data/dataTutor.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);

    // Lấy danh sách tutors từ dữ liệu JSON
    List<Map<String, dynamic>> tutorList = [];
    List<Map<String, dynamic>> favoriteList = [];

    if (jsonData['tutors'] != null && jsonData['tutors']['rows'] is List) {
      tutorList = List<Map<String, dynamic>>.from(jsonData['tutors']['rows']);
    }

    // Chuyển đổi thành danh sách các đối tượng Tutor'
    listTutor = tutorList.map((json) => TutorDTO.fromJson(json)).toList();

    if (jsonData['tutors'] != null && jsonData['favoriteTutor'] is List) {
      favoriteList = List<Map<String, dynamic>>.from(jsonData['favoriteTutor']);
    }
    List<String> idindex = [];

    for (var tutor in favoriteList) {
      String secondId = tutor['secondId'];
      idindex.add(secondId);
    }

    setState(() {
      favouriteRepository.setListIds(idindex);
    });
  }

  int appState = 0;
  void loginCallback(int _appState) {
    setState(() {
      appState = _appState;
    });
  }

  Widget displayWidget() {
    if (appState == 0) {
      return Login(loginCallback);
    } else {
      return BottomNavBar(loginCallback);
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => account),
        Provider(create: (context) => listTutor),
        Provider(create: (context) => listCourse),
        ChangeNotifierProvider(create: (context) => favouriteRepository),
        ChangeNotifierProvider(create: (context) => mySchedule),
        ChangeNotifierProvider(create: (context) => userData)
      ],
      child: MaterialApp(
          title: 'LetTutor',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: Consumer<Account>(builder: (context, account, _) {
            return displayWidget();
          })),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar(this.loginCallback, {super.key});
  final LoginCallback loginCallback;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  @override
  Widget build(BuildContext context) {
    List<Widget> _buildScreens() {
      return [
        Home(widget.loginCallback),
        Courses(widget.loginCallback),
        Schedule(widget.loginCallback),
        History(widget.loginCallback),
        SettingPage(widget.loginCallback)
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home_outlined),
          title: ("Home"),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.school),
          title: ("Courses"),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.calendar_month),
          title: ("Schedule"),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.history),
          title: ("History"),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.settings),
          title: ("Setting"),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style3, // Choose the nav bar style with this property.
    );
  }
}
