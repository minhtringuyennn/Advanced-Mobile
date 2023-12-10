import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class TestPreparation {
  int? id;
  String? key;
  String? name;

  TestPreparation({this.id, this.key, this.name});
  factory TestPreparation.fromJson(Map<String, dynamic> json) =>
      TestPreparation(
        id: json['id'] as int?,
        key: json['key'] as String?,
        name: json['name'] as String?,
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'key': key,
    'name': name,
  };
}
