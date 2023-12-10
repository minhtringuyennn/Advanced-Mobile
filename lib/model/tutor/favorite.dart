import 'package:advanced_mobile/model/tutor/tutor_tranfered_data.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class FavoriteTutor {
  String? id;
  String? firstId;
  String? secondId; // = userId ??
  String? createdAt;
  String? updatedAt;
  TutorTranferedData? secondInfo;

  FavoriteTutor({
    this.id,
    this.firstId,
    this.secondId,
    this.createdAt,
    this.updatedAt,
    this.secondInfo,
  });

  factory FavoriteTutor.fromJson(Map<String, dynamic> json) => FavoriteTutor(
        id: json['id'] as String?,
        firstId: json['firstId'] as String?,
        secondId: json['secondId'] as String?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        secondInfo: json['secondInfo'] == null
            ? null
            : TutorTranferedData.fromJson(
                json['secondInfo'] as Map<String, dynamic>),
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'firstId': firstId,
        'secondId': secondId,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'secondInfo': secondInfo,
      };
}
