import 'package:bookingapp/core/firebase_helper.dart';
import 'package:bookingapp/core/helpers/app_const.dart';
import 'package:bookingapp/core/models/firebase_auth_param.dart';
import 'package:bookingapp/firebase/register/data/models/firebase_register_model.dart';

import 'package:firebase_auth/firebase_auth.dart';

abstract class RegisterFirebase {
  Future<UserCredential> registerWithEmailAndPassword({
    required FireBaseAuthParam registerParam,
  });
  Future<void> addUser({required FireBaseRegisterModel registerModel});
}

class RegisterFirebaseImpl implements RegisterFirebase {
  final FirestoreService firestoreService;

  RegisterFirebaseImpl({required this.firestoreService});
  @override
  Future<UserCredential> registerWithEmailAndPassword({
    required FireBaseAuthParam registerParam,
  }) {
    final userCredential = FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: registerParam.email,
      password: registerParam.password,
    );
    return userCredential;
  }

  @override
  Future<void> addUser({required FireBaseRegisterModel registerModel}) async {
    await firestoreService.addDocument(
      collection: FirebaseCollections.userCollection,
      data: registerModel.toJson(),
    );
  }
}
