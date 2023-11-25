import 'dart:convert';
import 'package:advanced_mobile/repository/schedule-student-repository.dart';
import 'package:intl/intl.dart';
import 'package:advanced_mobile/presentation/DetailTutor/booking_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../model/schedule-dto.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});
  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  late Future<List<ScheduleDTO>> _loadScheduleFuture;
  @override
  void initState() {
    super.initState();
    setState(() {
      _loadScheduleFuture = loadScheduleOfTutor();
    });
  }

  Future<List<ScheduleDTO>> loadScheduleOfTutor() async {
    String jsonString =
        await rootBundle.loadString('assets/data/schedule.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);

    List<Map<String, dynamic>> schedules = [];

    if (jsonData['data'] != null && jsonData['data'] is List) {
      schedules = List<Map<String, dynamic>>.from(jsonData["data"]);
    }
    print("Hihi" + schedules.length.toString());

    return schedules.map((json) => ScheduleDTO.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    MyScheduleChangeNotifier mySchedule =
        context.watch<MyScheduleChangeNotifier>();

    List<TimeRegion> _getTimeRegions(List<ScheduleDTO> listScheduleOfTutor) {
      final List<TimeRegion> regions = <TimeRegion>[];
      print("a " + listScheduleOfTutor.length.toString());

      for (int i = 0; i < listScheduleOfTutor.length; i++) {
        print(2);

        int timestamp = listScheduleOfTutor[i].startTimestamp;
        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
        DateTime date = DateTime(dateTime.year, dateTime.month, dateTime.day,
            dateTime.hour, dateTime.minute, dateTime.second);
        print(1);
        print(date);
        regions.add(TimeRegion(
          startTime: date,
          endTime: date.add(Duration(minutes: 30)),
          enablePointerInteraction: true,
          color: Colors.grey.withOpacity(0.2),
          text: listScheduleOfTutor[i].isBooked ? "Booked" : 'Book',
        ));
      }

      return regions;
    }

    return FutureBuilder<List<ScheduleDTO>>(
      future: _loadScheduleFuture,
      builder:
          (BuildContext context, AsyncSnapshot<List<ScheduleDTO>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          List<ScheduleDTO> listScheduleOfTutor =
              snapshot.data as List<ScheduleDTO>;
          print("Zoooooooooooo" + listScheduleOfTutor.length.toString());
          return Container(
            height: 2520,
            child: SfCalendar(
              view: CalendarView.week,
              firstDayOfWeek: 1,
              showNavigationArrow: true,
              showCurrentTimeIndicator: false,
              timeSlotViewSettings: TimeSlotViewSettings(
                timeInterval: Duration(minutes: 30), timeFormat: 'h:mm a',
                timeIntervalHeight: 50,
                dateFormat: 'd', dayFormat: 'EEE',
                startHour: 0, // Set the start hour (24-hour format)
                endHour: 24, numberOfDaysInView: 5,
                // Set the end hour (24-hour format)
              ),
              specialRegions: _getTimeRegions(listScheduleOfTutor),
              timeRegionBuilder:
                  (BuildContext context, TimeRegionDetails details) {
                if (details.region.text == 'Book') {
                  return Container(
                    alignment: Alignment.center,
                    child: TextButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                              Size(18, 18)), // Thay đổi width và height tùy ý
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(horizontal: 8, vertical: 3)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Book',
                          style: TextStyle(color: Colors.white),
                        )),
                  );
                } else {
                  return Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Booked',
                      style: TextStyle(color: Colors.green),
                    ),
                  );
                }
              },
              onTap: (CalendarTapDetails details) async {
                if (details.targetElement == CalendarElement.calendarCell) {
                  // Check if the tap is within a time region
                  DateTime tappedTime = details.date!;
                  List<TimeRegion> timeRegions =
                      _getTimeRegions(listScheduleOfTutor);
                  for (int i = 0; i < timeRegions.length; i++) {
                    if (tappedTime.isAtSameMomentAs(timeRegions[i].startTime) &&
                        tappedTime.isBefore(timeRegions[i].endTime) &&
                        !listScheduleOfTutor[i].isBooked) {
                      DateTime timestart = DateTime.fromMillisecondsSinceEpoch(
                          listScheduleOfTutor[i].startTimestamp);
                      DateTime timeend = DateTime.fromMillisecondsSinceEpoch(
                          listScheduleOfTutor[i].endTimestamp);

                      String start =
                          "${timestart.hour.toString().length == 1 ? "0" + timestart.hour.toString() : timestart.hour.toString()}:${timestart.minute.toString().length == 1 ? "0" + timestart.minute.toString() : timestart.minute.toString()}";
                      String end =
                          "${timeend.hour.toString().length == 1 ? "0" + timeend.hour.toString() : timeend.hour.toString()}:${timeend.minute.toString().length == 1 ? "0" + timeend.minute.toString() : timeend.minute.toString()}";
                      String date = DateFormat.yMMMMEEEEd().format(
                          DateTime.fromMillisecondsSinceEpoch(
                              listScheduleOfTutor[i].startTimestamp!));
                      final dialogResult = await showDialog(
                        context: context,
                        builder: (context) => BookingConfirmDialog(
                            start: start, end: end, date: date),
                      );

                      if (dialogResult) {
                        mySchedule.addSchedule(listScheduleOfTutor[i]);
                        setState(() {
                          listScheduleOfTutor[i].booking();
                        });
                      }

                      // Tap is within a time region, perform your action
                    }
                  }
                }
              },
            ),
          );
        } else {
          // Dữ liệu đã được tải, có thể sử dụng nó
          return Center(
            child: Text('Error loading data'),
          );
        }
      },
    );
  }
}
