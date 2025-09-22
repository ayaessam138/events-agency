import 'package:bookingapp/core/firebase_helper.dart';
import 'package:bookingapp/core/network/dio_client.dart';
import 'package:bookingapp/core/network/network_info.dart';
import 'package:bookingapp/core/localstorage/app_local_storage.dart';
import 'package:bookingapp/core/localstorage/loacal_data_source.dart';
import 'package:bookingapp/api/bottom_nav_bar/persentation/controller/bottom_nav_bar_cubit.dart';
import 'package:bookingapp/api/events/data/datasource/events_datasource.dart';
import 'package:bookingapp/api/events/data/repo/events_repo.dart';
import 'package:bookingapp/api/events/domain/repo/events_repo.dart'
    show EventsRepo;

import 'package:bookingapp/api/events/persentation/controller/events_cubit.dart';
import 'package:bookingapp/api/organizer/data/data_source/organizer_data_source.dart';
import 'package:bookingapp/api/organizer/data/repo/organizer_repo.dart';
import 'package:bookingapp/api/organizer/domain/repo/organizer_repo.dart';
import 'package:bookingapp/api/organizer/persenation/controller/organizer_cubit.dart';
import 'package:bookingapp/api/register/data/datasource/register_datasource.dart';
import 'package:bookingapp/api/register/data/repo/register_repo.dart';
import 'package:bookingapp/api/register/domain/repo/register_repo.dart';
import 'package:bookingapp/api/register/persentation/controller/register_cubit.dart';
import 'package:bookingapp/firebase/bottomNavBar/persentation/cubit/firebase_bottom_navbar_cubit.dart';
import 'package:bookingapp/firebase/events/persentation/cubit/firebase_events_cubit.dart';
import 'package:bookingapp/firebase/events/data/data_source/local/firebase_events_local.dart';
import 'package:bookingapp/firebase/events/data/data_source/remote/firebase_events_remote.dart';
import 'package:bookingapp/firebase/events/data/repo/firebase_events_repo.dart';
import 'package:bookingapp/firebase/login/data/firebase/firebase_login.dart';
import 'package:bookingapp/firebase/login/data/repo/firebase_login_repo.dart';
import 'package:bookingapp/firebase/login/persentation/cubit/firebase_login_cubit.dart';
import 'package:bookingapp/firebase/organizer/data/repo/firebase_orgaizer_repo.dart';
import 'package:bookingapp/firebase/organizer/data/service/firebase_organizer.dart';
import 'package:bookingapp/firebase/organizer/persentation/cubit/firebase_organizer_cubit.dart';
import 'package:bookingapp/firebase/profile/data/datasource/local/firebase_profile_local.dart';
import 'package:bookingapp/firebase/profile/data/datasource/remote/firebase_profile_remote.dart';
import 'package:bookingapp/firebase/profile/data/repo/firebase_profile_repo.dart';
import 'package:bookingapp/firebase/profile/persentation/cubit/firebase_profile_cubit.dart';
import 'package:bookingapp/firebase/register/data/firebase/register_firebase.dart';
import 'package:bookingapp/firebase/register/data/repo/firebase_register_repo.dart';
import 'package:bookingapp/firebase/register/persentation/controller/cubit/firebase_register_cubit.dart';
import 'package:get_it/get_it.dart';

var getIt = GetIt.instance;

Future initDI() async {
  final getIt = GetIt.instance;
  ////api
  getIt.registerLazySingleton(() => DioClient());
  getIt.registerFactory<NetworkInfo>(() => NetworkInfoImpl());

  getIt.registerLazySingleton<AppHiveLocalStorage>(() => AppHiveLocalStorage());
  getIt.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  getIt.registerLazySingleton<BottomNavBarCubit>(() => BottomNavBarCubit());

  getIt.registerLazySingleton<RegisterDatasource>(
    () => RegisterDatasourceImpl(dioClient: getIt()),
  );
  getIt.registerFactory<RegisterRepo>(
    () => RegisterRepoImpl(registerDatasource: getIt()),
  );
  getIt.registerLazySingleton<RegisterCubit>(
    () => RegisterCubit(registerRepo: getIt()),
  );
  getIt.registerLazySingleton<EventsDatasource>(
    () => EventsDatasourceImpl(dioClient: getIt()),
  );
  getIt.registerFactory<EventsRepo>(
    () => EventsRepoImpl(
      localDataSource: getIt(),
      networkInfo: getIt(),
      eventsDatasource: getIt(),
    ),
  );
  getIt.registerLazySingleton<EventsCubit>(
    () => EventsCubit(
      localDataSource: getIt(),
      eventsRepo: getIt(),
      networkInfo: getIt(),
    ),
  );

  getIt.registerLazySingleton<OrganizerDatasource>(
    () => OrganizerDatasourceImpl(dioClient: getIt()),
  );
  getIt.registerFactory<OrganizerRepo>(
    () => OrganizerRepoImpl(networkInfo: getIt(), oganizerDatasource: getIt()),
  );
  getIt.registerLazySingleton<OrganizerCubit>(
    () => OrganizerCubit(organizerRepo: getIt(), networkInfo: getIt()),
  );

  ///firebase

  getIt.registerLazySingleton<FirebaseBottomNavbarCubit>(
    () => FirebaseBottomNavbarCubit(),
  );
  getIt.registerLazySingleton(() => FirestoreService());
  //register
  getIt.registerLazySingleton<RegisterFirebase>(
    () => RegisterFirebaseImpl(firestoreService: getIt()),
  );
  getIt.registerLazySingleton<FireBaseRegisterRepo>(
    () => FireBaseRegisterRepoImpl(registerFirebase: getIt()),
  );
  getIt.registerLazySingleton(
    () => FirebaseRegisterCubit(fireBaseRegisterRepo: getIt()),
  );
  //login
  getIt.registerLazySingleton<FirebaseLogin>(() => FirebaseLoginImpl());
  getIt.registerLazySingleton<FirebaseLoginRepo>(
    () => FirebaseLoginRepoimpl(firebaseLogin: getIt()),
  );
  getIt.registerLazySingleton(
    () => FirebaseLoginCubit(firebaseLoginRepo: getIt()),
  );
  //profile
  getIt.registerLazySingleton<FirebaseProfileRemote>(
    () => FirebaseProfileRemoteImpl(firestoreService: getIt()),
  );
  getIt.registerLazySingleton<FirebaseProfileLocal>(
    () => FirebaseProfileLocalImpl(box: getIt()),
  );
  getIt.registerLazySingleton<FirebaseProfileRepo>(
    () => FirebaseProfileRepoImpl(local: getIt(), remote: getIt()),
  );
  getIt.registerFactory(
    () => FirebaseProfileCubit(firebaseProfileRepo: getIt()),
  );
  //events
  getIt.registerLazySingleton<FirebaseEventsRemote>(
    () => FirebaseEventsRemoteImpl(firestoreService: getIt()),
  );
  getIt.registerLazySingleton<FirebaseEventsLocal>(
    () => FirebaseEventsLocalImpl(hiveBox: getIt()),
  );
  getIt.registerLazySingleton<FirebaseEventsHomeRepo>(
    () => FirebaseEventsRepoImpl(local: getIt(), remote: getIt()),
  );
  getIt.registerFactory(() => FirebaseEventsCubit(firebaseHomeRepo: getIt()));

  //Organizer
  getIt.registerLazySingleton<FirebaseOrganizerRemote>(
    () => FirebaseOrganizerRemoteImpl(firestoreService: getIt()),
  );

  getIt.registerLazySingleton<FirebaseOrganizerRepo>(
    () => FirebaseOrgaizerRepoImpl(firebaseOrganizerRemote: getIt()),
  );
  getIt.registerFactory(
    () => FirebaseOrganizerCubit(firebaseOrganizerRepo: getIt()),
  );
}
