import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LearnTopic {
  int? id;
  String? key;
  String? name;

  LearnTopic({this.id, this.key, this.name});
  factory LearnTopic.fromJson(Map<String, dynamic> json) =>
      LearnTopic(
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
