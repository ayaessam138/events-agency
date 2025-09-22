part of 'firebase_login_cubit.dart';

@immutable
sealed class FirebaseLoginState {}

final class FirebaseLoginInitial extends FirebaseLoginState {}
final class FirebaseLoginLoading extends FirebaseLoginState {}
final class FirebaseLoginFailure extends FirebaseLoginState {
  final String message;

  FirebaseLoginFailure({required this.message});
}
final class FirebaseLoginSuccess extends FirebaseLoginState {}

