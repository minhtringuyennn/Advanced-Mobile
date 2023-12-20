import 'package:json_annotation/json_annotation.dart';

import '../model/schedule/booking_infor.dart';


@JsonSerializable()
class ResponseGetBookingInfoHomePage {
  String? message;
  List<BookingInfo>? data;

  ResponseGetBookingInfoHomePage({
    this.message,
    this.data,
  });

  factory ResponseGetBookingInfoHomePage.fromJson(Map<String, dynamic> json) =>
      ResponseGetBookingInfoHomePage(
        message: json['message'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => BookingInfo.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  Map<String, dynamic> toJson() =>  <String, dynamic>{
    'message': message,
    'data': data,
  };
}



