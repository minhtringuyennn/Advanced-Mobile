
import '../../model/course/course_model.dart';
import '../responses/list_course_response.dart';
import '../services/api_service.dart';
import 'base_repository.dart';

class CourseRepository extends BaseRepository {
  static const String prefix = "";

  CourseRepository() : super(prefix);

  Future<void> getCourseListWithPagination({
    required String accessToken,
    required int size,
    required int page,
    required String search,
    required String sort,
    required List<String> level,
    required Function(List<CourseModel>, int) onSuccess,
    required Function(String) onFail,
  }) async {

    String oderBy=sort.isNotEmpty? '&orderBy[]=$sort':"";
    String dataLevel="";
    for (String lv in level)
      {
        dataLevel=dataLevel+"&level[]=$lv";
      }
    final response = await service.get(
        url: "course?page=$page&size=$size&q=$search$oderBy$dataLevel",
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        var result = ResponseGetListCourse.fromJson(response.response).data;
        onSuccess(result?.rows ?? [], result?.count ?? 0);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }


}
