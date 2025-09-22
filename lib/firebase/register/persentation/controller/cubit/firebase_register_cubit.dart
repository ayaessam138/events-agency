import 'package:bloc/bloc.dart';
import 'package:bookingapp/core/helpers/dependency_injection.dart';
import 'package:bookingapp/core/models/firebase_auth_param.dart'
    show FireBaseAuthParam;
import 'package:bookingapp/firebase/register/data/models/firebase_register_model.dart';

import 'package:bookingapp/firebase/register/data/repo/firebase_register_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'firebase_register_state.dart';

class FirebaseRegisterCubit extends Cubit<FirebaseRegisterState> {
  FirebaseRegisterCubit({required this.fireBaseRegisterRepo})
    : super(FirebaseRegisterInitial());

  FireBaseRegisterRepo fireBaseRegisterRepo;
  static FirebaseRegisterCubit get get => getIt();


  Future<UserCredential?> register({required FireBaseAuthParam param}) async {
    emit(FirebaseRegisterLoading());

    final result = await fireBaseRegisterRepo.registerWithEmailAndPassword(
      registerParam: param,
    );

    return result.fold(
      (failure) {
        emit(FirebaseRegisterFailure(message: failure.message));
        return null;
      },
      (userCredential) {
        final uid = userCredential.user?.uid ?? '';
        emit(FirebaseRegisterSuccess(uid: uid));
        return userCredential;
      },
    );
  }

  Future<void> addUser({
    required FireBaseRegisterModel fireBaseRegisterModel,
  }) async {
    emit(FirebaseAddUserLoading());

    final result = await fireBaseRegisterRepo.addUser(
      fireBaseRegisterModel: fireBaseRegisterModel,
    );

    result.fold(
      (failure) => emit(FirebaseAddUserFailure(message: failure.message)),
      (userCredential) => emit(FirebaseAddUserSuccess()),
    );
  }
}
