import 'package:bloc/bloc.dart';
import 'package:bookingapp/core/helpers/dependency_injection.dart';
import 'package:bookingapp/firebase/events/persentation/ui/screens/firebase_saved_events_screen.dart' show FirebaseSavedEventsScreen;
import 'package:bookingapp/firebase/home/persentation/ui/screens/firebase_home_screen%20.dart';
import 'package:bookingapp/firebase/profile/persentation/ui/screens/firebase_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'firebase_bottom_navbar_state.dart';

class FirebaseBottomNavbarCubit extends Cubit<FirebaseBottomNavbarState> {
  FirebaseBottomNavbarCubit() : super(FirebaseBottomNavbarInitial());
  static FirebaseBottomNavbarCubit get get => getIt();

  List<Widget> pages = [FirebaseHomeScreen(), FirebaseSavedEventsScreen(), Container(), FirebaseProfileScreen()];

  int currentIndex = 0;

  void changeIndex(int index) {
    emit(FirebaseBottomNavbarInitial());
    currentIndex = index;
    emit( FirebaseBottomNavbarChangeIndex());
  }
}
