import 'dart:async';

import 'package:eighty_two/authentication/models/user.dart';
import 'package:eighty_two/authentication/repositories/authentication_repository.dart';
import 'package:flutter/cupertino.dart';

enum AuthFailure {
  none,
  emailInUse,
  invalidPassword,
  unknownFailure,
}

class AuthProvider extends ChangeNotifier {
  AuthProvider({required this.repository}) {
    _userStream = repository.getUser().listen((_user) {
      user = _user;
      notifyListeners();
    });
  }

  final AuthRepository repository;
  late StreamSubscription<User?> _userStream;

  bool isLoading = false;
  bool hasError = false;
  String? errorMessage;

  AuthFailure _authFailure = AuthFailure.none;
  AuthFailure get authFailure => _authFailure;

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

  Future<void> signInWithEmailAndPassword({
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

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    _onActionStart();
    try {
      await repository.signUp(email, password);
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
