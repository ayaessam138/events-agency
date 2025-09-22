part of 'firebase_register_cubit.dart';

@immutable
sealed class FirebaseRegisterState {}

final class FirebaseRegisterInitial extends FirebaseRegisterState {}

final class FirebaseRegisterLoading extends FirebaseRegisterState {}

final class FirebaseRegisterFailure extends FirebaseRegisterState {
  final String message;

  FirebaseRegisterFailure({required this.message});
}

final class FirebaseRegisterSuccess extends FirebaseRegisterState {
    final String uid;

  FirebaseRegisterSuccess({required this.uid});
}

final class FirebaseAddUserLoading extends FirebaseRegisterState {
  
}

final class FirebaseAddUserFailure extends FirebaseRegisterState {
  final String message;

  FirebaseAddUserFailure({required this.message});
}

final class FirebaseAddUserSuccess extends FirebaseRegisterState {}
