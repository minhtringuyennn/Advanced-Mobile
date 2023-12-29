import 'package:advanced_mobile/model/schedule/review.dart';
import 'package:json_annotation/json_annotation.dart';

import '../tutor/feedback.dart';
import 'schedule_detail.dart';

//get-booked-course
@JsonSerializable()
class BookingInfo {
  int? createdAtTimeStamp;
  int? updatedAtTimeStamp;
  String? id;
  String? userId;
  String? scheduleDetailId;
  String? tutorMeetingLink;
  String? studentMeetingLink;
  String? studentRequest;
  String? tutorReview;
  int? scoreByTutor;
  String? createdAt;
  String? updatedAt;
  String? recordUrl;
  bool? isDeleted;
  ScheduleDetail? scheduleDetailInfo;
  ClassReview? classReview;
  //new
  int? cancelReasonId;
  String? lessonPlanId;
  String? cancelNote;
  String? calendarId;
  bool? showRecordUrl;
  // List<String>? studentMaterials;
  List<FeedbackDTO>? feedbacks;

  BookingInfo({
    this.createdAtTimeStamp,
    this.updatedAtTimeStamp,
    this.id,
    this.userId,
    this.scheduleDetailId,
    this.tutorMeetingLink,
    this.studentMeetingLink,
    this.studentRequest,
    this.tutorReview,
    this.scoreByTutor,
    this.createdAt,
    this.updatedAt,
    this.recordUrl,
    this.isDeleted,
    this.scheduleDetailInfo,
    this.classReview,
    this.cancelReasonId,
    this.lessonPlanId,
    this.cancelNote,
    this.calendarId,
    this.showRecordUrl,
    // this.studentMaterials,
    this.feedbacks,
  });

  factory BookingInfo.fromJson(Map<String, dynamic> json) => BookingInfo(
        createdAtTimeStamp: json['createdAtTimeStamp'] as int?,
        updatedAtTimeStamp: json['updatedAtTimeStamp'] as int?,
        id: json['id'] as String?,
        userId: json['userId'] as String?,
        scheduleDetailId: json['scheduleDetailId'] as String?,
        tutorMeetingLink: json['tutorMeetingLink'] as String?,
        studentMeetingLink: json['studentMeetingLink'] as String?,
        studentRequest: json['studentRequest'] as String?,
        tutorReview: json['tutorReview'] as String?,
        scoreByTutor: json['scoreByTutor'] as int?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        recordUrl: json['recordUrl'] as String?,
        isDeleted: json['isDeleted'] as bool?,
        scheduleDetailInfo: json['scheduleDetailInfo'] == null
            ? null
            : ScheduleDetail.fromJson(
                json['scheduleDetailInfo'] as Map<String, dynamic>),
        classReview: json['classReview'] == null
            ? null
            : ClassReview.fromJson(json['classReview'] as Map<String, dynamic>),
        cancelReasonId: json['cancelReasonId'] as int?,
        lessonPlanId: json['lessonPlanId'] as String?,
        cancelNote: json['cancelNote'] as String?,
        calendarId: json['calendarId'] as String?,
        showRecordUrl: json['showRecordUrl'] as bool?,
        feedbacks: (json['feedbacks'] as List<dynamic>?)
            ?.map((e) => FeedbackDTO.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'createdAtTimeStamp': createdAtTimeStamp,
        'updatedAtTimeStamp': updatedAtTimeStamp,
        'id': id,
        'userId': userId,
        'scheduleDetailId': scheduleDetailId,
        'tutorMeetingLink': tutorMeetingLink,
        'studentMeetingLink': studentMeetingLink,
        'studentRequest': studentRequest,
        'tutorReview': tutorReview,
        'scoreByTutor': scoreByTutor,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'recordUrl': recordUrl,
        'isDeleted': isDeleted,
        'scheduleDetailInfo': scheduleDetailInfo,
        'classReview': classReview,
        'cancelReasonId': cancelReasonId,
        'lessonPlanId': lessonPlanId,
        'cancelNote': cancelNote,
        'calendarId': calendarId,
        'showRecordUrl': showRecordUrl,
        'feedbacks': feedbacks,
      };
}
