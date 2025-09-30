import 'package:bookingapp/api/login/persentation/screens/login_screen.dart';
import 'package:bookingapp/core/helpers/dependency_injection.dart';
import 'package:bookingapp/core/helpers/functions.dart';
import 'package:bookingapp/core/routing/app_routes.dart';
import 'package:bookingapp/api/bottom_nav_bar/persentation/screens/bottom_nav_bar_screen.dart';
import 'package:bookingapp/api/events/persentation/screens/event_details.dart';
import 'package:bookingapp/api/events/persentation/screens/events_screen.dart';
import 'package:bookingapp/api/onboading/persentations/screens/on_borading_screen.dart';
import 'package:bookingapp/api/organizer/persenation/screens/organizer_screen.dart';
import 'package:bookingapp/api/otp/persentation/screens/otp_screen.dart';
import 'package:bookingapp/api/profile/persentation/screens/edit_profile_screen.dart';
import 'package:bookingapp/api/register/persentation/screens/register_screen.dart';
import 'package:bookingapp/api/splash/persentation/screens/splash_screen.dart';
import 'package:bookingapp/firebase/bottomNavBar/persentation/ui/screens/firebase_bottom_navbar_screen.dart';
import 'package:bookingapp/firebase/events/persentation/cubit/firebase_events_cubit.dart';
import 'package:bookingapp/firebase/events/persentation/ui/screens/firebase_all_events_screen.dart';
import 'package:bookingapp/firebase/events/persentation/ui/screens/firebase_events_details_screen.dart';
import 'package:bookingapp/firebase/login/persentation/cubit/firebase_login_cubit.dart';
import 'package:bookingapp/firebase/login/persentation/screens/firebase_login_screen.dart';
import 'package:bookingapp/firebase/organizer/persentation/cubit/firebase_organizer_cubit.dart';
import 'package:bookingapp/firebase/organizer/persentation/screens/firebase_organizer_screen.dart';
import 'package:bookingapp/firebase/profile/data/models/firebase_profile_model.dart';
import 'package:bookingapp/firebase/profile/persentation/cubit/firebase_profile_cubit.dart';
import 'package:bookingapp/firebase/profile/persentation/ui/screens/firebase_edit_profile_screen.dart';
import 'package:bookingapp/firebase/register/persentation/controller/cubit/firebase_register_cubit.dart';
import 'package:bookingapp/firebase/register/persentation/ui/screens/firebase_register_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppHeleperFunctions.getinialRoutes(),
    routes: [
      GoRoute(
        name: AppRoutes.splashScreen,
        path: AppRoutes.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: AppRoutes.onBoradingScreen,
        path: AppRoutes.onBoradingScreen,
        builder: (context, state) => const OnBoradingScreen(),
      ),
      //api
      GoRoute(
        name: AppRoutes.loginScreen,
        path: AppRoutes.loginScreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: AppRoutes.registerScreen,
        path: AppRoutes.registerScreen,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        name: AppRoutes.otpScrren,
        path: AppRoutes.otpScrren,
        builder: (context, state) => OtpScreen(),
      ),
      GoRoute(
        name: AppRoutes.eventsScreen,
        path: AppRoutes.eventsScreen,
        builder: (context, state) => const EventsScreen(),
      ),
      GoRoute(
        name: AppRoutes.eventsDeatilsScreen,
        path: '${AppRoutes.eventsDeatilsScreen}/:id',
        builder:
            (context, state) =>
                EventDetails(id: state.pathParameters["id"] ?? ''),
      ),
      GoRoute(
        name: AppRoutes.organizerScreen,
        path: '${AppRoutes.organizerScreen}/:id',
        builder:
            (context, state) =>
                OrganizerScreen(id: state.pathParameters["id"] ?? ''),
      ),
      GoRoute(
        name: AppRoutes.editProfileScreen,
        path: AppRoutes.editProfileScreen,
        builder: (context, state) => EditProfileScreen(),
      ),
      GoRoute(
        name: AppRoutes.bottomNavBarScreen,
        path: AppRoutes.bottomNavBarScreen,
        builder: (context, state) => BottomNavBarScreen(),
      ),

      //firebase
      GoRoute(
        name: AppRoutes.firbasebottomNavBarScreen,
        path: AppRoutes.firbasebottomNavBarScreen,
        builder: (context, state) => const FirebaseBottomNavbarScreen(),
      ),
      GoRoute(
        name: AppRoutes.firbaseRegisterScreen,
        path: AppRoutes.firbaseRegisterScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => getIt<FirebaseRegisterCubit>(),
              child: FirebaseRegisterScreen(),
            ),
      ),
      GoRoute(
        name: AppRoutes.firbaseLoginScreen,
        path: AppRoutes.firbaseLoginScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => getIt<FirebaseLoginCubit>(),
              child: const FirebaseLoginScreen(),
            ),
      ),
      GoRoute(
        name: AppRoutes.firebaseEditProfileScreen,
        path: AppRoutes.firebaseEditProfileScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => getIt<FirebaseProfileCubit>(),
              child: FirebaseEditProfileScreen(
                firebaseProfileModel: state.extra as FirebaseProfileModel,
              ),
            ),
      ),
      GoRoute(
        name: AppRoutes.firebaseAllEventsScreen,
        path: AppRoutes.firebaseAllEventsScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => getIt<FirebaseEventsCubit>(),
              child: FirebaseAllEventsScreen(),
            ),
      ),
      GoRoute(
        name: AppRoutes.firebaseEventDetailsScreen,
        path: '${AppRoutes.firebaseEventDetailsScreen}/:id',
        builder:
            (context, state) => BlocProvider(
              create: (context) => getIt<FirebaseEventsCubit>(),
              child: FirebaseEventsDetailsScreen(
                id: state.pathParameters["id"] ?? '',
              ),
            ),
      ),
      GoRoute(
        name: AppRoutes.firebaseOrganizerScreen,
        path: '${AppRoutes.firebaseOrganizerScreen}/:id',
        builder:
            (context, state) => BlocProvider(
              create: (context) => getIt<FirebaseOrganizerCubit>(),
              child: FirebaseOrganizerScreen(
                id: state.pathParameters["id"] ?? '',
              ),
            ),
      ),
      
    ],
  );
}
