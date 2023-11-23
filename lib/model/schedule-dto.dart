import 'package:advanced_mobile/model/schedule-detail-dto.dart';
import 'package:flutter/cupertino.dart';

class ScheduleDTO extends ChangeNotifier {
  final String id;
  final String tutorId;
  final String startTime;
  final String endTime;
  final int startTimestamp;
  final int endTimestamp;
  String createdAt;
  bool isBooked;
  final List<ScheduleDetails> scheduleDetails;

  void booking() {
    isBooked = true;
  }

  ScheduleDTO({
    required this.id,
    required this.tutorId,
    required this.startTime,
    required this.endTime,
    required this.startTimestamp,
    required this.endTimestamp,
    required this.createdAt,
    required this.isBooked,
    required this.scheduleDetails,
  });

  factory ScheduleDTO.fromJson(Map<String, dynamic> json) {
    List<ScheduleDetails> scheduleDetails = [];
    if (json['scheduleDetails'] != null) {
      scheduleDetails = (json['scheduleDetails'] as List)
          .map((detail) => ScheduleDetails.fromJson(detail))
          .toList();
    }

    return ScheduleDTO(
      id: json['id'] as String,
      tutorId: json['tutorId'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      startTimestamp: json['startTimestamp'] as int,
      endTimestamp: json['endTimestamp'] as int,
      createdAt: json['createdAt'] as String,
      isBooked: json['isBooked'] as bool,
      scheduleDetails: scheduleDetails,
    );
  }
}
