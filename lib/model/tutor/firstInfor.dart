import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class FirstInfor {
  String? name;
  String? avatar;


  FirstInfor({
    this.name,
    this.avatar,

  });

  factory FirstInfor.fromJson(Map<String, dynamic> json) =>
      FirstInfor(
        name: json['name'] as String?,
        avatar: json['avatar'] as String?,
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'avatar': avatar
  };
}
