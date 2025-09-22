import 'package:bookingapp/core/models/firebase_auth_param.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseLogin {
  Future<UserCredential> firebaseLogin({
    required FireBaseAuthParam fireBaseAuthParam,
  });
}

class FirebaseLoginImpl implements FirebaseLogin {
  @override
  Future<UserCredential> firebaseLogin({
    required FireBaseAuthParam fireBaseAuthParam,
  }) {
    final userCredential = FirebaseAuth.instance.signInWithEmailAndPassword(
      email: fireBaseAuthParam.email,
      password: fireBaseAuthParam.password,
    );
    return userCredential;
  }
}
