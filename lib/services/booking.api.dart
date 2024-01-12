import 'package:advanced_mobile/responses/list_booking_homepage_response.dart';

import '../model/schedule/booking_infor.dart';
import '../responses/list_booking_response.dart';
import '../services/api_service.dart';
import 'base_repository.dart';

class BookingRepository extends BaseRepository {
  static const String prefix = "booking/";

  BookingRepository() : super(prefix);

  Future<void> getUpcomingClass({
    required String accessToken,
    required String now,
    required int page,
    required int perPage,
    required Function(List<BookingInfo>, int) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.get(
        url:
            "list/student?page=$page&perPage=$perPage&inFuture=1&orderBy=meeting&sortBy=asc",
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        var result = ResponseGetListBooking.fromJson(response.response).data;
        onSuccess(result?.rows ?? [], result?.count ?? 0);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }

  // Future<void> getUpcomingClassHomePage({
  //   required String accessToken,
  //   required int now,
  //   required Function(List<BookingInfo>) onSuccess,
  //   required Function(String) onFail,
  // }) async {
  //   final response = await service.get(
  //       url: "next?dateTime=$now",
  //       headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;
  //
  //   switch (response.statusCode) {
  //     case 200:
  //     case 201:
  //       onSuccess(
  //           ResponseGetNextBookingInfo.fromJson(response.response).data ?? []);
  //       break;
  //     default:
  //       onFail(response.errorMsg.toString());
  //       break;
  //   }
  // }
  Future<void> bookClass({
    required String accessToken,
    required String notes,
    required List<String> scheduleDetailIds,
    required Function(String) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.post(
        url: "",
        data: {"note": notes, "scheduleDetailIds": scheduleDetailIds},
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess(response.response['message']);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }

  Future<void> cancelClass({
    required String accessToken,
    required String cancelReasonId,
    required String note,
    required String scheduleDetailId,
    required Function(String) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.delete(url: "schedule-detail", data: {
      "scheduleDetailId": scheduleDetailId,
      "cancelInfo": {"cancelReasonId": cancelReasonId, "note": note}
    }, headers: {
      "Authorization": "Bearer $accessToken"
    }) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess(response.response['message']);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }

  Future<void> getHistoryLesson({
    required String accessToken,
    required String now,
    required int page,
    required int perPage,
    required Function(List<BookingInfo>, int) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.get(
        url:
            "list/student?page=$page&perPage=$perPage&dateTimeLte=$now&orderBy=meeting&sortBy=desc",
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        var result = ResponseGetListBooking.fromJson(response.response).data;
        onSuccess(result?.rows ?? [], result?.count ?? 0);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }
}
