import 'dart:async';

import 'package:advanced_mobile/common/loading.dart';
import 'package:advanced_mobile/presentation/Courses/Courses.dart';
import 'package:advanced_mobile/presentation/History/History.dart';
import 'package:advanced_mobile/presentation/Home/searchTutor.dart';
import 'package:advanced_mobile/presentation/Schedule/Schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_pagination/flutter_pagination.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Provider/auth_provider.dart';
import '../../model/schedule/booking_infor.dart';
import '../../model/tutor/tutor_model.dart';
import '../../responses/list_tutor_response.dart';
import '../../services/booking.api.dart';
import '../../services/tutors.api.dart';
import '../../styles/styles.dart';
import 'listTutors.dart';

typedef FilterCallback = void Function(
    String filter, String nameTutor, List<String> nation);
typedef ChangeFavorite = void Function(String tutorId);

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<TutorModel> _tutorList = [];
  List<BookingInfo> lessonList = [];

  List<String> _favTutorsId = [];

  int currentPage = 1;
  int maxPage = 1;

  bool isLoading = true;
  //Đã call api này chưa
  bool hasCallAPI = false;

  //Upcoming
  String totalLessonTime = "";
  BookingInfo upcomingLesson = BookingInfo();
  //search
  String specialities = 'all';
  String nameTutor = "";
  Map<String, dynamic> national = {};
  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    var authProvider = Provider.of<AuthProvider>(context);

    //Fetch API
    if (!hasCallAPI) {
      await Future.wait([
        callAPIGetTutorList(1, TutorRepository(), authProvider),
        callApiGetListSchedules(BookingRepository(), authProvider)
      ]).whenComplete(() {
        if (mounted) {
          setState(() {
            hasCallAPI = true;
            isLoading = false;
          });
        }
      });
    }
  }

  Future<void> refreshHome(AuthProvider authProvider) async {
    setState(() {
      _tutorList = [];
      _favTutorsId = [];
      lessonList = [];
      isLoading = true;
    });
    await Future.wait([
      callAPIGetTutorList(1, TutorRepository(), authProvider),
      callApiGetListSchedules(BookingRepository(), authProvider)
    ]).whenComplete(() {
      setState(() {
        isLoading = false;
      });
      return Future<void>.delayed(const Duration(seconds: 0));
    });
  }

  void changeFavorite(String idTutor) {
    List<String> favoriteList = _favTutorsId;
    if (favoriteList.contains(idTutor)) {
      favoriteList.remove(idTutor);
    } else {
      favoriteList.add(idTutor!);
      favoriteList = favoriteList.toSet().toList();
    }

    setState(() {
      _favTutorsId = favoriteList;
    });
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);

    void filterCallback(String filter, String nameTutor, List<String> nation) {
      Map<String, dynamic> nationality = {
        "isVietNamese": false,
        "isNative": false
      };
      if (nation.isEmpty || nation.length == 3) {
        nationality = {};
      } else {
        nation.forEach((String item) {
          switch (item) {
            case "Vietnamese Tutor":
              nationality["isVietNamese"] = true;
              break;
            case "Native English Tutor":
              nationality["isNative"] = true;
              break;
          }
        });
      }
      nationality.removeWhere((key, value) => value == true);

      setState(() {
        specialities = filter;
        nameTutor = nameTutor;
        national = nationality;
      });

      searchTutor(currentPage, TutorRepository(), authProvider,
          filter == "all" ? "" : filter, nameTutor, nationality);
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
                      child: Column(children: [
                  (upcomingLesson != null)
                      ? UpcomingLesson(
                          upcominglesson: upcomingLesson,
                          totalLessonTime: totalLessonTime,
                        )
                      : const SizedBox(),
                  SearchTutor(filterCallback),
                  Divider(
                    // Add a horizontal line
                    color: Colors.grey, // Line color
                    height: 10, // Line height
                    thickness: 0.5, // Line thickness
                    indent: 20, // Line indent on the left
                    endIndent: 10, // Line indent on the right
                  ),
                  ListTutors(_tutorList, _favTutorsId, changeFavorite),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16),
                      child: Pagination(
                        paginateButtonStyles: paginationStyle(context),
                        prevButtonStyles: prevButtonStyles(context),
                        nextButtonStyles: nextButtonStyles(context),
                        onPageChange: (number) {
                          setState(() {
                            isLoading = true;
                            currentPage = number;
                          });
                          //Call API
                          searchTutor(number, TutorRepository(), authProvider,
                              specialities, nameTutor, national);
                        },
                        useGroup: false,
                        totalPage: maxPage,
                        show: maxPage - 1,
                        currentPage: currentPage,
                      ))
                ]))),
        ));
  }

  Future<void> callAPIGetTutorList(int page, TutorRepository tutorRepository,
      AuthProvider authProvider) async {
    await tutorRepository.getListTutor(
        accessToken: authProvider.token?.access?.token ?? "",
        page: page,
        perPage: 10,
        onSuccess: (response) async {
          _handleTutorListDataFromAPI(response);
        },
        onFail: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.toString()}')),
          );
        });
  }

  Future<void> callApiGetListSchedules(
      BookingRepository bookingRepository, AuthProvider authProvider) async {
    await bookingRepository.getUpcomingClass(
        accessToken: authProvider.token?.access?.token ?? "",
        page: 1,
        perPage: 100000,
        now: DateTime.now().millisecondsSinceEpoch.toString(),
        onSuccess: (response, total) async {
          _filterListScheduleFromApi(response);
        },
        onFail: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.toString()}')),
          );
        });
  }

  int getShowPagesBasedOnPages(int pages) {
    if (pages > 2) {
      return 2;
    } else if (pages == 2) {
      return 1;
    } else if (pages <= 1) {
      return 0;
    } else {
      return 0;
    }
  }

  Future<void> searchTutor(
      int page,
      TutorRepository tutorRepository,
      AuthProvider authProvider,
      String filter,
      String name,
      Map<String, dynamic> nationality) async {
    await tutorRepository.searchTutor(
        accessToken: authProvider.token!.access!.token ?? "",
        page: page,
        searchKeys: name,
        speciality: [filter],
        nationality: nationality,
        onSuccess: (response, total) async {
          _tutorList = [];
          _tutorList.addAll(response);
          setState(() {
            isLoading = false;
            currentPage = page;
            maxPage = (total / 10).ceil();
          });
        },
        onFail: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.toString()}')),
          );
        });
  }

  void _handleTutorListDataFromAPI(ResponseGetListTutor response) {
    response.favoriteTutor?.forEach((element) {
      if (element.secondId != null) {
        _favTutorsId.add(element.secondId!);
      }
    });

    //Separate list
    List<TutorModel> notFavoredList = [];
    List<TutorModel> favoredList = [];
    response.tutors?.rows?.forEach((element) {
      if (checkIfTutorIsFavorite(element)) {
        favoredList.add(element);
      } else {
        notFavoredList.add(element);
      }
    });

    //Sort by score
    favoredList.sort((b, a) => (a.rating ?? 0).compareTo((b.rating ?? 0)));
    notFavoredList.sort((b, a) => (a.rating ?? 0).compareTo((b.rating ?? 0)));

    //Add to final list
    _tutorList.addAll(favoredList);
    _tutorList.addAll(notFavoredList);
  }

  bool checkIfTutorIsFavorite(TutorModel tutor) {
    for (var element in _favTutorsId) {
      if (element == tutor.userId) return true;
    }
    return false;
  }

  void _filterListScheduleFromApi(List<BookingInfo> listBooking) {
    for (var value in listBooking) {
      if (value.isDeleted != true) {
        lessonList.insert(0, value);
      }
    }

    //Calculate total learning time
    DateTime totalTime = DateTime.now();
    DateTime nowTime = totalTime;
    for (var element in lessonList) {
      var startTime = DateTime.fromMillisecondsSinceEpoch(
          element.scheduleDetailInfo!.startPeriodTimestamp!);
      var endTime = DateTime.fromMillisecondsSinceEpoch(
          element.scheduleDetailInfo!.endPeriodTimestamp!);
      var learningDuration = endTime.difference(startTime);
      totalTime = totalTime.add(learningDuration);
    }
    Duration learningDuration = totalTime.difference(nowTime);

    if (lessonList.isNotEmpty) {
      upcomingLesson = lessonList.first;
      totalLessonTime = _printDuration(learningDuration);
    }
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}

class UpcomingLesson extends StatefulWidget {
  const UpcomingLesson(
      {required this.upcominglesson, required this.totalLessonTime, super.key});
  final BookingInfo upcominglesson;
  final String totalLessonTime;

  @override
  State<UpcomingLesson> createState() => _UpcomingLessonState();
}

class _UpcomingLessonState extends State<UpcomingLesson> {
  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Color.fromARGB(255, 12, 61, 223);

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
            widget.upcominglesson?.id == null
                ? "You have no upcoming lesson."
                : "Upcoming lesson",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
          SizedBox(
            height: widget.upcominglesson != null ? 20 : 0,
          ),
          Visibility(
            visible: widget.upcominglesson.id != null,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      (widget.upcominglesson.scheduleDetailInfo != null)
                          ? Text(
                              DateFormat('EEEE, MMMM d').format(
                                  DateTime.fromMillisecondsSinceEpoch(widget
                                      .upcominglesson
                                      .scheduleDetailInfo!
                                      .startPeriodTimestamp!)),
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            )
                          : const SizedBox(),
                      Text(
                        convertTimeToString(
                            widget.upcominglesson.scheduleDetailInfo != null
                                ? widget.upcominglesson.scheduleDetailInfo!
                                    .startPeriodTimestamp!
                                : 0,
                            widget.upcominglesson.scheduleDetailInfo != null
                                ? widget.upcominglesson.scheduleDetailInfo!
                                    .endPeriodTimestamp!
                                : 0),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      (widget.upcominglesson.scheduleDetailInfo != null)
                          ? CountdownTimer(
                              endTime: widget.upcominglesson.scheduleDetailInfo!
                                  .startPeriodTimestamp!,
                              textStyle: TextStyle(color: Colors.yellow),
                            )
                          : const SizedBox(),
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
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => JoinMeetingPage(upcomingClass: widget.upcominglesson)),
                        // );
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
          Visibility(
              visible: widget.totalLessonTime != null,
              child: Text(
                (widget.totalLessonTime.isEmpty)
                    ? "Total lesson time is 0"
                    : "Total lesson time is: ${widget.totalLessonTime}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }
}
