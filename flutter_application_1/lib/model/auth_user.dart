import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/user_controller.dart';
import 'package:flutter_application_1/model/user_model.dart';

class AdminData extends ChangeNotifier {
  Users AuthUser = Users();

  AdminData(this.AuthUser);

  final UserController _controller = UserController();

  void SetAuthUser() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      AuthUser = (await _controller.getUserById(user.email!))!;
    }
    notifyListeners();
  }
}
