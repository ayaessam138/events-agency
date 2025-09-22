part of 'firebase_organizer_cubit.dart';

@immutable
sealed class FirebaseOrganizerState {}

final class FirebaseOrganizerInitial extends FirebaseOrganizerState {}
final class FirebaseOrganizerlLoading extends FirebaseOrganizerState {
 
}
final class FirebaseOrganizerSuccess extends FirebaseOrganizerState {
  final FirebaseOrganizerModel firebaseOrganizerModel;

  FirebaseOrganizerSuccess({required this.firebaseOrganizerModel});
}
final class FirebaseOrganizerFail extends FirebaseOrganizerState {
   final String message;

  FirebaseOrganizerFail({required this.message});
}