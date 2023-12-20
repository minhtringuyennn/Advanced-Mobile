import 'package:advanced_mobile/model/tutor/favorite.dart';
import 'package:advanced_mobile/model/tutor/tutor_model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ResponseGetListTutor {
  TutorPagination? tutors;
  List<FavoriteTutor>? favoriteTutor;

  ResponseGetListTutor({this.tutors, this.favoriteTutor});

  factory ResponseGetListTutor.fromJson(Map<String, dynamic> json) =>
      ResponseGetListTutor(
        tutors: json['tutors'] == null
            ? null
            : TutorPagination.fromJson(json['tutors'] as Map<String, dynamic>),
        favoriteTutor: (json['favoriteTutor'] as List<dynamic>?)
            ?.map((e) => FavoriteTutor.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'tutors': tutors,
        'favoriteTutor': favoriteTutor,
      };
}

@JsonSerializable()
class TutorPagination {
  int? count;
  List<TutorModel>? rows;

  TutorPagination({
    this.count,
    this.rows,
  });

  factory TutorPagination.fromJson(Map<String, dynamic> json) =>
      TutorPagination(
        count: json['count'] as int?,
        rows: (json['rows'] as List<dynamic>?)
            ?.map((e) => TutorModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'count': count,
        'rows': rows,
      };
}
