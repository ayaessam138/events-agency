part of 'firebase_profile_cubit.dart';

@immutable
sealed class FirebaseProfileState {}

final class FirebaseProfileInitial extends FirebaseProfileState {}

final class FirebaseProfileLoading extends FirebaseProfileState {}

final class FirebaseProfileFail extends FirebaseProfileState {
  final String message;
  FirebaseProfileFail({required this.message});
}

final class FirebaseProfileSuccess extends FirebaseProfileState {
  final FirebaseProfileModel profile;
  FirebaseProfileSuccess({required this.profile});
}

final class FirebaseUpdateProfileLoading extends FirebaseProfileState {}

final class FirebaseUpdateProfileFail extends FirebaseProfileState {
  final String message;
  FirebaseUpdateProfileFail({required this.message});
}

final class FirebaseUpdateProfileSuccess extends FirebaseProfileState {
  
}
