import 'package:bloc/bloc.dart';
import 'package:bookingapp/core/helpers/dependency_injection.dart';
import 'package:bookingapp/core/models/firebase_auth_param.dart';
import 'package:bookingapp/firebase/login/data/repo/firebase_login_repo.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'firebase_login_state.dart';

class FirebaseLoginCubit extends Cubit<FirebaseLoginState> {
  FirebaseLoginCubit({required this.firebaseLoginRepo})
    : super(FirebaseLoginInitial());
  final FirebaseLoginRepo firebaseLoginRepo;
  static FirebaseLoginCubit get get => getIt();
  Future<void> login({required FireBaseAuthParam param}) async {
    emit(FirebaseLoginLoading());

    final result = await firebaseLoginRepo.firebaseLoginfunction(
      fireBaseAuthParam: param,
    );

    result.fold(
      (failure) => emit(FirebaseLoginFailure(message: failure.message)),
      (userCredential) => emit(FirebaseLoginSuccess()),
    );
  }
}
