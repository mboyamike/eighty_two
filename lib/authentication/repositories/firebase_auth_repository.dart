import 'package:eighty_two/authentication/models/user.dart' as appUser;
import 'package:eighty_two/authentication/repositories/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepository implements AuthRepository {
  final _auth = FirebaseAuth.instance;

  @override
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      if (e is FirebaseException) {
        switch (e.code) {
          case 'user-not-found':
            throw EmailDoesNotExistException();
          case 'wrong-password':
            throw WrongPasswordException();
          default:
            throw e;
        }
      }
      throw e;
    }
  }

  @override
  Future<void> signUp(String email, String password) async {
    try {
      _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseException {} catch (e) {
      if (e is FirebaseException) {
        switch (e.code) {
          case 'email-already-in-use':
            throw EmailAlreadyInUseException();
          case 'invalid-email':
            throw InvalidEmailException();
          case 'weak-password':
            throw WeakPasswordException();
          default:
            throw e;
        }
      }

      throw e;
    }
  }

  @override
  Stream<appUser.User?> getUser() {
    return _auth.authStateChanges().map(
          (user) => user == null
              ? null
              : appUser.User.fromMap(
                  map: {
                    'id': user.uid,
                    'email': user.email,
                    'imageURL': user.photoURL,
                  },
                ),
        );
  }
}
