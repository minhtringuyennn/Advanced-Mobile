import 'package:flutter/cupertino.dart';

class Account extends ChangeNotifier{
  String? email;
  String? password;
  bool isAuthenticated=false;

  Account({required this.email,required this.password});

  void loginSuccess()
  {
    isAuthenticated=true;
    notifyListeners();
  }
  void register(String newEmail,String newPassword)
  {
    email=newEmail;
    password=newPassword;
    notifyListeners();
  }

}