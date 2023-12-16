import 'dart:convert';
import 'package:advanced_mobile/Provider/auth_provider.dart';
import 'package:advanced_mobile/model/schedule/schedule.dart';
import 'package:advanced_mobile/model/tutor/tutor_model.dart';
import 'package:advanced_mobile/repository/schedule-student-repository.dart';
import 'package:advanced_mobile/services/booking.api.dart';
import 'package:advanced_mobile/services/schedule.api.dart';
import 'package:intl/intl.dart';
import 'package:advanced_mobile/presentation/DetailTutor/booking_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../model/schedule-dto.dart';

class Booking extends StatefulWidget {
  const Booking({required this.tutor, super.key});
  final TutorModel tutor;
  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  List<ScheduleModel> listScheduleByDate = [];
  late int startTime;
  late int endTime;
  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    ScheduleRepository scheduleRepository = ScheduleRepository();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    int startTime = DateTime.now().millisecondsSinceEpoch;
    int endTime = startTime + Duration(days: 4).inMilliseconds;

    await scheduleRepository.getScheduleById(
        tutorId: widget.tutor.userId!,
        startTime: startTime,
        endTime: endTime,
        accessToken: authProvider.token?.access?.token ?? "",
        onSuccess: (schedules) {
          setState(() {
            listScheduleByDate = schedules;
          });
        },
        onFail: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error when get schedule: $message'),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    ScheduleRepository scheduleRepository = ScheduleRepository();
    BookingRepository bookingRepository = BookingRepository();

    List<TimeRegion> _getTimeRegions(String? idUser) {
      final List<TimeRegion> regions = <TimeRegion>[];

      for (int i = 0; i < listScheduleByDate.length; i++) {
        int? timestamp = listScheduleByDate[i].startTimestamp;
        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp!);
        DateTime date = DateTime(dateTime.year, dateTime.month, dateTime.day,
            dateTime.hour, dateTime.minute, dateTime.second);
        regions.add(TimeRegion(
          startTime: date,
          endTime: date.add(Duration(minutes: 30)),
          enablePointerInteraction: true,
          color: Colors.grey.withOpacity(0.2),
          text: !listScheduleByDate[i].isBooked!
              ? "Book"
              : (listScheduleByDate[i]
                          .scheduleDetails?[0]
                          ?.bookingInfo?[0]
                          ?.userId ==
                      idUser)
                  ? "Booked"
                  : "Reserved",
        ));
      }

      return regions;
    }

    return Container(
      height: 2520,
      child: SfCalendar(
        view: CalendarView.week,
        firstDayOfWeek: 1,
        showNavigationArrow: true,
        showCurrentTimeIndicator: false,
        timeSlotViewSettings: TimeSlotViewSettings(
          timeInterval: Duration(minutes: 30),
          timeFormat: 'HH:mm',
          timeIntervalHeight: 50,
          dateFormat: 'd',
          dayFormat: 'EEE',
          startHour: 0, // Set the start hour (24-hour format)
          endHour: 24,
          numberOfDaysInView: 5,
          // Set the end hour (24-hour format)
        ),
        onViewChanged: (ViewChangedDetails details) async {
          startTime = details.visibleDates[0].millisecondsSinceEpoch;
          endTime = details.visibleDates[details.visibleDates.length - 1]
              .millisecondsSinceEpoch;
          await scheduleRepository.getScheduleById(
              tutorId: widget.tutor.userId!,
              startTime: startTime,
              endTime: endTime,
              accessToken: authProvider.token?.access?.token ?? "",
              onSuccess: (schedules) {
                setState(() {
                  listScheduleByDate = schedules;
                });
              },
              onFail: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error when get schedule: $message'),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.red,
                  ),
                );
              });
        },
        specialRegions: _getTimeRegions(authProvider.currentUser?.id!),
        timeRegionBuilder: (BuildContext context, TimeRegionDetails details) {
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
                _getTimeRegions(authProvider.currentUser?.id!);
            for (int i = 0; i < timeRegions.length; i++) {
              if (tappedTime.isAtSameMomentAs(timeRegions[i].startTime) &&
                  tappedTime.isBefore(timeRegions[i].endTime) &&
                  !listScheduleByDate[i].isBooked!) {
                DateTime timestart = DateTime.fromMillisecondsSinceEpoch(
                    listScheduleByDate[i].startTimestamp!);
                DateTime timeend = DateTime.fromMillisecondsSinceEpoch(
                    listScheduleByDate[i].endTimestamp!);

                String start =
                    "${timestart.hour.toString().length == 1 ? "0" + timestart.hour.toString() : timestart.hour.toString()}:${timestart.minute.toString().length == 1 ? "0" + timestart.minute.toString() : timestart.minute.toString()}";
                String end =
                    "${timeend.hour.toString().length == 1 ? "0" + timeend.hour.toString() : timeend.hour.toString()}:${timeend.minute.toString().length == 1 ? "0" + timeend.minute.toString() : timeend.minute.toString()}";
                String date = DateFormat.yMMMMEEEEd().format(
                    DateTime.fromMillisecondsSinceEpoch(
                        listScheduleByDate[i].startTimestamp!));
                final dialogResult = await showDialog(
                  context: context,
                  builder: (context) =>
                      BookingConfirmDialog(start: start, end: end, date: date),
                );

                if (dialogResult[0]) {
                  try {
                    List<String> list = [];
                    list.add(listScheduleByDate[i].scheduleDetails!.first.id!);
                    await bookingRepository.bookClass(
                        scheduleDetailIds: list,
                        notes: dialogResult[1],
                        accessToken: authProvider.token?.access?.token ?? "",
                        onSuccess: (message) async {
                          await scheduleRepository.getScheduleById(
                              tutorId: widget.tutor.userId!,
                              startTime: startTime,
                              endTime: endTime,
                              accessToken:
                                  authProvider.token?.access?.token ?? " ",
                              onSuccess: (schedules) {
                                setState(() {
                                  listScheduleByDate = schedules;
                                });
                              },
                              onFail: (message) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Error: $message'),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.green,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        onFail: (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(error),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        });
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  } finally {}
                }
              }
            }
          }
        },
      ),
    );
  }
}
