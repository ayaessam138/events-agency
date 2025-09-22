import 'package:bookingapp/core/models/firebase_auth_param.dart';
import 'package:bookingapp/firebase/register/data/firebase/register_firebase.dart';
import 'package:bookingapp/firebase/register/data/models/firebase_register_model.dart';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error_handle/failure.dart';

abstract class FireBaseRegisterRepo {
  Future<Either<Failure, UserCredential>> registerWithEmailAndPassword({
    required FireBaseAuthParam registerParam,
  });
  Future<Either<Failure, void>> addUser({
    required FireBaseRegisterModel fireBaseRegisterModel,
  });
}

class FireBaseRegisterRepoImpl implements FireBaseRegisterRepo {
  final RegisterFirebase registerFirebase;

  FireBaseRegisterRepoImpl({required this.registerFirebase});

  @override
  Future<Either<Failure, UserCredential>> registerWithEmailAndPassword({
    required FireBaseAuthParam registerParam,
  }) async {
    try {
      final userCredential = await registerFirebase
          .registerWithEmailAndPassword(registerParam: registerParam);

      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: _getErrorMessage(e)));
    } catch (e) {
      return Left(Failure(message: "حدث خطأ غير متوقع: $e"));
    }
  }

  @override
  Future<Either<Failure, void>> addUser({
    required FireBaseRegisterModel fireBaseRegisterModel,
  }) async {
    try {
      await registerFirebase.addUser(registerModel: fireBaseRegisterModel);
      return const Right(null);
    } catch (e) {
      print("add user error");
      print(e.toString());

      return Left(Failure(message: "فشل في إضافة المستخدم: $e"));
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
