import 'package:bookingapp/core/helpers/dependency_injection.dart';
import 'package:bookingapp/api/bottom_nav_bar/persentation/controller/bottom_nav_bar_cubit.dart';
import 'package:bookingapp/api/events/persentation/controller/events_cubit.dart';
import 'package:bookingapp/api/organizer/persenation/controller/organizer_cubit.dart';
import 'package:bookingapp/api/register/persentation/controller/register_cubit.dart';
import 'package:bookingapp/firebase/bottomNavBar/persentation/cubit/firebase_bottom_navbar_cubit.dart';
import 'package:bookingapp/firebase/register/persentation/controller/cubit/firebase_register_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> appBlocProviders() {
  return [
    BlocProvider<BottomNavBarCubit>(
      create: (context) => getIt<BottomNavBarCubit>(),
    ),
    BlocProvider<EventsCubit>(create: (context) => getIt<EventsCubit>()),
    BlocProvider<OrganizerCubit>(create: (context) => getIt<OrganizerCubit>()),
    BlocProvider<RegisterCubit>(create: (context) => getIt<RegisterCubit>()),
    BlocProvider<FirebaseBottomNavbarCubit>(
      create: (context) => getIt<FirebaseBottomNavbarCubit>(),
    ),
  ];
}
