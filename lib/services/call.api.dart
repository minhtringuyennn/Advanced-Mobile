
import '../services/api_service.dart';
import 'base_repository.dart';

class CallRepository extends BaseRepository {
  static const String prefix = "call/";

  CallRepository() : super(prefix);

  Future<void> getTotalLessonTime({
    required String accessToken,
    required Function(int) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.get(
        url:
        "total",
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess(response.response['total']??0);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }





}
