import 'package:bookingapp/core/error_handle/failure.dart';
import 'package:bookingapp/core/models/firebase_auth_param.dart'
    show FireBaseAuthParam;
import 'package:bookingapp/firebase/login/data/firebase/firebase_login.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseLoginRepo {
  Future<Either<Failure, UserCredential>> firebaseLoginfunction({
    required FireBaseAuthParam fireBaseAuthParam,
  });
}

class FirebaseLoginRepoimpl implements FirebaseLoginRepo {
  final FirebaseLogin firebaseLogin;

  FirebaseLoginRepoimpl({required this.firebaseLogin});
  @override
  Future<Either<Failure, UserCredential>> firebaseLoginfunction({
    required FireBaseAuthParam fireBaseAuthParam,
  }) async {
    try {
      final userCredential = await firebaseLogin. firebaseLogin(
        fireBaseAuthParam: fireBaseAuthParam,
      );

      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: _getErrorMessage(e)));
    } catch (e) {
      return Left(Failure(message: "حدث خطأ غير متوقع: $e"));
    }
  }
  
  static String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'البريد الإلكتروني غير مسجل.';
      case 'wrong-password':
        return 'كلمة المرور غير صحيحة.';
      case 'email-already-in-use':
        return 'البريد الإلكتروني مستخدم بالفعل.';
      case 'weak-password':
        return 'كلمة المرور ضعيفة جداً.';
      case 'invalid-email':
        return 'صيغة البريد الإلكتروني غير صحيحة.';
      default:
        return 'حدث خطأ: ${e.message}';
    }
  }
}
