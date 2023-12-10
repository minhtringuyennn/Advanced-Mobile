import 'package:json_annotation/json_annotation.dart';

import '../tutor/tutor_model.dart';
import 'schedule_detail.dart';

@JsonSerializable()
class ScheduleModel {
  String? id;
  String? date;
  String? tutorId;
  String? startTime;
  String? endTime;
  int? startTimestamp;
  int? endTimestamp;
  String? createdAt;
  bool? isBooked;
  bool? isDeleted;
  List<ScheduleDetail>? scheduleDetails;
  TutorModel? tutorInfo;

  ScheduleModel({
    this.id,
    this.date,
    this.tutorId,
    this.startTime,
    this.endTime,
    this.startTimestamp,
    this.endTimestamp,
    this.createdAt,
    this.isBooked,
    this.isDeleted,
    this.scheduleDetails,
    this.tutorInfo,
  });

  String getDisplayTime() {
    return "$startTime:$endTime";
  }

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        id: json['id'] as String?,
        date: json['date'] as String?,
        tutorId: json['tutorId'] as String?,
        startTime: json['startTime'] as String?,
        endTime: json['endTime'] as String?,
        startTimestamp: json['startTimestamp'] as int?,
        endTimestamp: json['endTimestamp'] as int?,
        createdAt: json['createdAt'] as String?,
        isBooked: json['isBooked'] as bool?,
        isDeleted: json['isDeleted'] as bool?,
        scheduleDetails: (json['scheduleDetails'] as List<dynamic>?)
            ?.map((e) => ScheduleDetail.fromJson(e as Map<String, dynamic>))
            .toList(),
        tutorInfo: json['tutorInfo'] == null
            ? null
            : TutorModel.fromJson(json['tutorInfo'] as Map<String, dynamic>),
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'date': date,
        'tutorId': tutorId,
        'startTime': startTime,
        'endTime': endTime,
        'startTimestamp': startTimestamp,
        'endTimestamp': endTimestamp,
        'createdAt': createdAt,
        'isBooked': isBooked,
        'isDeleted': isDeleted,
        'scheduleDetails': scheduleDetails,
        'tutorInfo': tutorInfo,
      };
}
