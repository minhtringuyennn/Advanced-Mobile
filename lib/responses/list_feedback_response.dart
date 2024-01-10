import 'package:json_annotation/json_annotation.dart';

import '../model/tutor/feedback.dart';



@JsonSerializable()
class ResponseGetListFeedback {
  String? message;
  FeedbackPagination? data;

  ResponseGetListFeedback({
    this.message,
    this.data,
  });

  factory ResponseGetListFeedback.fromJson(Map<String, dynamic> json) =>
      ResponseGetListFeedback(
        message: json['message'] as String?,
        data: json['data'] == null
            ? null
            : FeedbackPagination.fromJson(json['data'] as Map<String, dynamic>),
      );
  Map<String, dynamic> toJson() =><String, dynamic>{
    'message': message,
    'data': data,
  };
}


@JsonSerializable()
class FeedbackPagination {
  int? count;
  List<FeedbackDTO>? rows;

  FeedbackPagination({
    this.count,
    this.rows,
  });

  factory FeedbackPagination.fromJson(Map<String, dynamic> json) =>
      FeedbackPagination(
        count: json['count'] as int?,
        rows: (json['rows'] as List<dynamic>?)
            ?.map((e) => FeedbackDTO.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
    'count': count,
    'rows': rows,
  };
}

