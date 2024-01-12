

import '../model/tutor/feedback.dart';
import '../responses/list_feedback_response.dart';
import '../services/api_service.dart';
import 'base_repository.dart';

class FeedBackRepository extends BaseRepository {
  static const String prefix = "feedback/v2/";

  FeedBackRepository() : super(prefix);

  Future<void> getFeedBackOfTutor({
    required String accessToken,
    required int page,
    required int perPage,
    required String tutorId,
    required Function(List<FeedbackDTO>, int) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.get(
        url:
        "$tutorId?page=$page&perPage=$perPage",
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
      var result = ResponseGetListFeedback.fromJson(response.response).data;

      onSuccess(result?.rows ?? [], result?.count ?? 0);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }





}
