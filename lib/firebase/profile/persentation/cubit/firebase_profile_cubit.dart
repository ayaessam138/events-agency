import 'package:bloc/bloc.dart';
import 'package:bookingapp/firebase/profile/data/models/firebase_profile_model.dart';
import 'package:bookingapp/firebase/profile/data/repo/firebase_profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'firebase_profile_state.dart';

class FirebaseProfileCubit extends Cubit<FirebaseProfileState> {
  final FirebaseProfileRepo firebaseProfileRepo;

  FirebaseProfileCubit({required this.firebaseProfileRepo})
    : super(FirebaseProfileInitial());

  static FirebaseProfileCubit of(BuildContext context) =>
      context.read<FirebaseProfileCubit>();
  Future<void> getUserProfile(String uid, {bool isRefresh = false}) async {
    emit(FirebaseProfileLoading());

    final result = await firebaseProfileRepo.getUserProfile(
      uid,
      isRefresh: isRefresh,
    );

    result.fold(
      (failure) => emit(FirebaseProfileFail(message: failure.message)),
      (profile) => emit(FirebaseProfileSuccess(profile: profile)),
    );
  }

  Future<void> updateUserProfile({
    required FirebaseProfileModel firebaseProfileModel,
    required String currentUserId,
  }) async {
    emit(FirebaseUpdateProfileLoading());

    final result = await firebaseProfileRepo.updateUserProfile(
      firebaseProfileModel: firebaseProfileModel,
      currentUserId: currentUserId,
    );

    result.fold(
      (failure) => emit(FirebaseUpdateProfileFail(message: failure.message)),
      (profile) => emit(FirebaseUpdateProfileSuccess()),
    );
  }
}
