import 'package:advanced_mobile/model/user/token.dart';
import 'package:advanced_mobile/model/user/user.dart';
import 'package:advanced_mobile/services/api_service.dart';
import 'base_repository.dart';

class AuthRepository extends BaseRepository {
  static const String prefix = "auth/";

  AuthRepository() : super(prefix);

  Future<void> loginByAccount({
    required String email,
    required String password,
    required Function(UserModel, Token) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.post(url: 'login', data: {
      "email": email,
      "password": password,
    }) as BoundResource;
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
      case 201:
        final user = UserModel.fromJson(response.response['user']);
        final token = Token.fromJson(response.response['tokens']);
        await onSuccess(user, token);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }

  Future<void> signUpByAccount({
    required String email,
    required String password,
    required Function() onSuccess,
    required Function(String) onFail,
  }) async {
    final response =
        await service.postFormUrlEncoded(url: "register", headers: {
      "origin": "https://sandbox.app.lettutor.com",
      "referer": "https://sandbox.app.lettutor.com/",
    }, data: {
      "email": email,
      "password": password,
      "source": null
    }) as BoundResource;
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess();
        break;
      default:
        onFail(response.errorMsg.toString());

        break;
    }
  }
}
