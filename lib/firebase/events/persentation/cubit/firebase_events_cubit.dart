

import 'package:bloc/bloc.dart';
import 'package:bookingapp/firebase/events/data/model/firebase_events_model.dart';

import 'package:bookingapp/firebase/events/data/repo/firebase_events_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'firebase_events_state.dart';

class FirebaseEventsCubit extends Cubit<FirebaseEventsState> {
  FirebaseEventsCubit({required this.firebaseHomeRepo})
    : super(FirebaseEventsInitial());
  static FirebaseEventsCubit of(BuildContext context) =>
      context.read<FirebaseEventsCubit>();
  final FirebaseEventsHomeRepo firebaseHomeRepo;
  Future<void> getEvents({bool isRefresh = false}) async {
    emit(FirebaseEventsLoading());

    final result = await firebaseHomeRepo.getEvents(isRefresh: isRefresh);

    result.fold(
      (failure) => emit(FirebaseEventsFailure(message: failure.message)),
      (eventsList) {
        emit(FirebaseEventsSuccess(eventsList: eventsList));
      },
    );
  }

  Future<void> getEventsDetails({required String eventId}) async {
    emit(FirebaseEventDetailsLoading());

    final result = await firebaseHomeRepo.getEventDeatils(eventId: eventId);

    result.fold(
      (failure) => emit(FirebaseEventDetailFailure(message: failure.message)),
      (eventsModel) {
        emit(FirebaseEventDetailsSuccess(eventsModel: eventsModel));
      },
    );
  }
}

// ///addd event to firebase
// class FirebaseEventsService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> addEvent(FirebaseEventsModel event) async {
//     try {
//       await _firestore.collection('events').doc().set(event.toMap());
//     } catch (e) {
//       throw Exception("فشل في إضافة الحدث: $e");
//     }
//   }
// }
