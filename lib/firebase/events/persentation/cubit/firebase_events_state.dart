part of 'firebase_events_cubit.dart';

@immutable
sealed class FirebaseEventsState {}

final class FirebaseEventsInitial extends FirebaseEventsState {}

final class FirebaseEventsLoading extends FirebaseEventsState {}

final class FirebaseEventsFailure extends FirebaseEventsState {
  final String message;

  FirebaseEventsFailure({required this.message});
}

final class FirebaseEventsSuccess extends FirebaseEventsState {
  final List<FirebaseEventsModel> eventsList;

  FirebaseEventsSuccess({required this.eventsList});
}

final class FirebaseEventDetailsLoading extends FirebaseEventsState {}

final class FirebaseEventDetailFailure extends FirebaseEventsState {
  final String message;

  FirebaseEventDetailFailure({required this.message});
}

final class FirebaseEventDetailsSuccess extends FirebaseEventsState {
  final FirebaseEventsModel eventsModel;

  FirebaseEventDetailsSuccess({required this.eventsModel});
}
