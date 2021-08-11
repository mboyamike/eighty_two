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
      throw e;
    }
  }

  @override
  Future<void> signUp(String email, String password) async {
    try {
      _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
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
