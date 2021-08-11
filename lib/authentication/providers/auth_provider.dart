import 'dart:async';

import 'package:eighty_two/authentication/models/user.dart';
import 'package:eighty_two/authentication/repositories/authentication_repository.dart';
import 'package:flutter/cupertino.dart';

enum AuthFailure {
  none,
  emailInUse,
  invalidPassword,
  unknown,
}

class AuthProvider extends ChangeNotifier {
  AuthProvider({required this.repository}) {
    _userStream = repository.getUser().listen((_user) {
      user = _user;
      notifyListeners();
    });
  }

  bool isLoading = false;
  bool hasError = false;
  String? errorMessage;
  late StreamSubscription<User?> _userStream;
  final AuthRepository repository;

  User? user;

  void _onActionStart() {
    isLoading = true;
    errorMessage = null;
    hasError = false;
    notifyListeners();
  }

  void _onActionEnd() {
    isLoading = false;
    notifyListeners();
  }

  void signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    _onActionStart();
    try {
      await repository.loginWithEmailAndPassword(email, password);
    } catch (exception) {
      errorMessage = exception.toString();
      hasError = true;
    } finally {
      _onActionEnd();
    }
  }

  @override
  void dispose() {
    _userStream.cancel();
    super.dispose();
  }
}
