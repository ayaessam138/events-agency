part of 'firebase_bottom_navbar_cubit.dart';

@immutable
sealed class FirebaseBottomNavbarState {}

final class FirebaseBottomNavbarInitial extends FirebaseBottomNavbarState {}
final class FirebaseBottomNavbarChangeIndex extends FirebaseBottomNavbarState {}