import 'package:advanced_mobile/responses/list_tutor_response.dart';

import '../model/tutor/infor.dart';
import '../model/tutor/tutor_model.dart';
import '../services/api_service.dart';
import 'base_repository.dart';

class TutorRepository extends BaseRepository {
  static const String prefix = "tutor/";

  TutorRepository() : super(prefix);

  //TODO: RESPONSE UNKNOWN
  Future<void> becomeTutor({
    required Function() onSuccess,
  }) async {
    final response = await service.postFormUrlEncoded(
      url: "register",
      data: {},
    );

    await onSuccess();
  }

  //TODO: RESPONSE UNKNOWN
  Future<void> writeReviewAfterClass({
    required Function() onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.post(
      url: "feedbackTutor",
    );

    await onSuccess();
  }

  Future<void> getTutorById({
    required String accessToken,
    required String tutorId,
    required Function(TutorInfo) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.get(
        url: tutorId,
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess(TutorInfo.fromJson(response.response));
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }

  Future<void> searchTutor({
    required String accessToken,
    required String searchKeys,
    required int page,
    required List<String> speciality,
    required Map<String, dynamic> nationality,
    required Function(List<TutorModel>, int) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.post(url: "search", data: {
      "filters": {
        "specialties": speciality,
        "nationality": nationality,
        "date": null,
        "tutoringTimeAvailable": [null, null]
      },
      "search": searchKeys,
      "page": '$page',
      "perPage": 10
    }, headers: {
      "Authorization": "Bearer $accessToken"
    }) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        var result = TutorPagination.fromJson(response.response);
        onSuccess(result.rows ?? [], result.count ?? 0);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }

  //TODO: RESPONSE UNKNOWN
  Future<void> addTutorToFavorite({
    required Function() onSuccess,
  }) async {
    final response = await service.post(
      url: "manageFavoriteTutor",
    );

    await onSuccess();
  }
}
