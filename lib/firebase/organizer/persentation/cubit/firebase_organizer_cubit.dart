import 'package:bloc/bloc.dart';
import 'package:bookingapp/firebase/events/data/model/firebase_events_model.dart';
import 'package:bookingapp/firebase/organizer/data/repo/firebase_orgaizer_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'firebase_organizer_state.dart';

class FirebaseOrganizerCubit extends Cubit<FirebaseOrganizerState> {
  FirebaseOrganizerCubit({required this.firebaseOrganizerRepo})
    : super(FirebaseOrganizerInitial());
  final FirebaseOrganizerRepo firebaseOrganizerRepo;
    static FirebaseOrganizerCubit of(BuildContext context) =>
      context.read<FirebaseOrganizerCubit>();
  Future<void> getOrganizer({required String organizerId}) async {
    emit(FirebaseOrganizerlLoading());

    final result = await firebaseOrganizerRepo.getOrganizerDeatils(
      organizerId: organizerId,
    );

    result.fold(
      (failure) => emit(FirebaseOrganizerFail(message: failure.message)),
      (organizersModel) {
        emit(FirebaseOrganizerSuccess(firebaseOrganizerModel: organizersModel));
      },
    );
  }
}
