import 'package:json_annotation/json_annotation.dart';
import '../model/course/course_model.dart';



@JsonSerializable()
class ResponseGetListCourse {
  String? message;
  CoursePagination? data;

  ResponseGetListCourse({
    this.message,
    this.data,
  });

  factory ResponseGetListCourse.fromJson(Map<String, dynamic> json) =>
      ResponseGetListCourse(
        message: json['message'] as String?,
        data: json['data'] == null
            ? null
            : CoursePagination.fromJson(json['data'] as Map<String, dynamic>),
      );
  Map<String, dynamic> toJson() =><String, dynamic>{
    'message': message,
    'data': data,
  };
}


@JsonSerializable()
class CoursePagination {
  int? count;
  List<CourseModel>? rows;

  CoursePagination({
    this.count,
    this.rows,
  });

  factory CoursePagination.fromJson(Map<String, dynamic> json) =>
      CoursePagination(
        count: json['count'] as int?,
        rows: (json['rows'] as List<dynamic>?)
            ?.map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
    'count': count,
    'rows': rows,
  };
}

