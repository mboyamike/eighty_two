import 'package:eighty_two/authentication/models/user.dart';

abstract class AuthRepository {
  Future<void> signUp(String email, String password);
  Future<void> loginWithEmailAndPassword(String email, String password);
  Stream<User?> getUser();
}

class EmailAlreadyInUseException implements Exception {}
class EmailDoesNotExistException implements Exception {}
class InvalidEmailException implements Exception {}
class WeakPasswordException implements Exception {}
class WrongPasswordException implements Exception {}
