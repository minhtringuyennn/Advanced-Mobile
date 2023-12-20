import 'package:advanced_mobile/model/user/user.dart';
import 'package:advanced_mobile/services/authentication.api.dart';
import 'package:flutter/cupertino.dart';

import '../model/user/token.dart';

class AuthProvider extends ChangeNotifier {
  late AuthRepository authRepository;

  UserModel? currentUser;
  Token? token;

  bool refreshHome = false;

  AuthProvider() {
    authRepository = AuthRepository();
  }

  void saveLoginInfo(UserModel currentUser, Token? token) {
    this.token = token;
    this.currentUser = currentUser;
    notifyListeners();
  }

  void clearUserInfo() {
    token = null;
    currentUser = null;
    notifyListeners();
  }
}
