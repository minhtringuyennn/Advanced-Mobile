import 'package:advanced_mobile/services/api_service.dart';
import 'package:dio/dio.dart';

abstract class BaseRepository {
  late CancelToken cancelToken;
  late ApiService service;

  BaseRepository(String prefix) {
    String apiBaseUrl = "https://sandbox.api.lettutor.com/";

    service = ApiService("$apiBaseUrl$prefix");
    cancelToken = CancelToken();
  }
}
