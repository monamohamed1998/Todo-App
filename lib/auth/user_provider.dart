import 'package:flutter/material.dart';
import 'package:todo/models/user_model.dart';

class UserProvider with ChangeNotifier {
  // it can be null in case there is no user Or he can make logout so it returns null
  UserModel? currentUser;

  void updateUser(UserModel? user) {
    currentUser = user;
    notifyListeners();
  }
}
