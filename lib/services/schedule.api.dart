import 'package:advanced_mobile/model/schedule/schedule.dart';
import 'package:advanced_mobile/responses/list_schedule_of_tutor_response.dart';

import '../services/api_service.dart';
import 'base_repository.dart';

class ScheduleRepository extends BaseRepository {
  static const String prefix = "schedule";

  ScheduleRepository() : super(prefix);

  Future<void> getScheduleById({
    required String accessToken,
    required String tutorId,
    required int startTime,
    required int endTime,
    required Function(List<ScheduleModel>) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.get(
        url:
            "?tutorId=$tutorId&startTimestamp=$startTime&endTimestamp=$endTime&=",
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess(ResponseGetListSchedule.fromJson(response.response)
                .scheduleOfTutor ??
            []);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }

  Future<void> getOwnSchedule({
    required String accessToken,
    required Function(List<ScheduleModel>) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.post(
        url: "",
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess(ResponseGetListSchedule.fromJson(response.response)
                .scheduleOfTutor ??
            []);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }
}
