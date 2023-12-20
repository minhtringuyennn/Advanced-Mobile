import 'package:json_annotation/json_annotation.dart';
import '../../model/schedule/schedule.dart';


@JsonSerializable()
class ResponseGetListSchedule {
  String? message;
  List<ScheduleModel>? scheduleOfTutor;

  ResponseGetListSchedule({
    this.message,
    this.scheduleOfTutor,
  });

  factory ResponseGetListSchedule.fromJson(Map<String, dynamic> json) =>
      ResponseGetListSchedule(
        message: json['message'] as String?,
        scheduleOfTutor: (json['scheduleOfTutor'] as List<dynamic>?)
            ?.map((e) => ScheduleModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
