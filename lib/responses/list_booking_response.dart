import 'package:json_annotation/json_annotation.dart';

import '../model/schedule/booking_infor.dart';



@JsonSerializable()
class ResponseGetListBooking {
  String? message;
  BookingPagination? data;

  ResponseGetListBooking({
    this.message,
    this.data,
  });

  factory ResponseGetListBooking.fromJson(Map<String, dynamic> json) =>
      ResponseGetListBooking(
        message: json['message'] as String?,
        data: json['data'] == null
            ? null
            : BookingPagination.fromJson(json['data'] as Map<String, dynamic>),
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
    'message': message,
    'data': data,
  };
}


@JsonSerializable()
class BookingPagination {
  int? count;
  List<BookingInfo>? rows;

  BookingPagination({
    this.count,
    this.rows,
  });

  factory BookingPagination.fromJson(Map<String, dynamic> json) =>
      BookingPagination(
        count: json['count'] as int?,
        rows: (json['rows'] as List<dynamic>?)
            ?.map((e) => BookingInfo.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  Map<String, dynamic> toJson() =>  <String, dynamic>{
    'count': count,
    'rows': rows,
  };
}

